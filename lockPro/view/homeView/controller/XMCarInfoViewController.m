//
//  XMCarInfoViewController.m
//  lockPro
//
//  Created by 牛付威 on 2018/6/1.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "XMCarInfoViewController.h"
#import "XMBigCarView.h"
#import "XMShowPhotoPicker.h"
#import "XMLockRelat.h"
#import <CoreLocation/CoreLocation.h>
#import <iconv.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "LCLoadingHUD.h"
#import "NAPushFile.h"
#import "XMRequestNetWork.h"

@interface XMCarInfoViewController ()<CLLocationManagerDelegate,CBCentralManagerDelegate,CBPeripheralDelegate,UIAlertViewDelegate,NavCustomDelegate>
{
    //定义变量
     XMBigCarView * car;
    //用于保存被发现设备
    NSMutableArray *peripherals;
    NSMutableArray * findDeviceArr;

    //用于保存设备动态密码
    NSString * OTP;
    
    NSString * macAddr;//用于保存当前选中的设备mac地址
    NSString * currentCity;//用于保存当前位置

    BOOL lockStatus;
    
    XMNavCustom * customNav;
    
    NSString * posString;
    
    NSString * oprtId;//上传记录id
    
    NSTimer * timer;
    
    BOOL isTimeOut;
    
     CLLocationCoordinate2D coordinate;

    XMLockRelat * selectLockRelat;
    
    UIButton * currentLock;
    
    NSMutableDictionary * lockStatusDictinary;
}
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLGeocoder *geocoder;
@property(nonatomic,strong)CBCentralManager* centralManager;
@property(nonatomic,strong)CBPeripheral* myPeripheral;
@property(nonatomic,strong)CBCharacteristic* lockUnlockCharacteristic;//上锁和解锁的characteristic
@property(nonatomic,strong)CBCharacteristic* readPowerCharacteristic;//电量的characteristic
-(void)initCentralManager;//初始化中心设备管理器
-(void)setLockInstruction:(NSString*)lockInstruction;//传入上锁指令
-(void)setUnlockInstruction:(NSString *)unlockInstruction;//传入解锁指令
@end

@implementation XMCarInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.device.lsCT.cUid;

   
    if(iPhone6){
         car = [[[NSBundle mainBundle] loadNibNamed:@"XMBigCarView" owner:self options:nil]lastObject];
    }
    else{
         car = [[[NSBundle mainBundle] loadNibNamed:@"XMBigCarPlusView" owner:self options:nil]lastObject];
    }
    car.frame = CGRectMake(0, -Nav_TopHeight, kScreen_Width, kScreen_Height+Nav_TopHeight);
    car.oneButton.tag = 101;
    [car.oneButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    car.oneButton.hidden = YES;
    car.oneLabel.hidden = YES;
    
    car.twoButton.tag = 102;
    [car.twoButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    car.twoButton.hidden = YES;
    car.twoLabel.hidden = YES;

    car.threeButton.tag = 103;
    [car.threeButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    car.threeButton.hidden = YES;
    car.threeLabel.hidden = YES;

    car.fourButton.tag = 104;
    [car.fourButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    car.fourButton.hidden = YES;
    car.fourLabel.hidden = YES;

    car.fiveButton.tag = 105;
    [car.fiveButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    car.fiveButton.hidden = YES;
    car.fiveLabel.hidden = YES;

    car.sixButton.tag = 106;
    [car.sixButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    car.sixButton.hidden = YES;
    car.sixLabel.hidden = YES;

    car.servenButton.tag = 107;
    [car.servenButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    car.servenButton.hidden = YES;
    car.servenLabel.hidden = YES;

    [self.view addSubview:car];

    lockStatusDictinary = [[NSMutableDictionary alloc] init];
    
    findDeviceArr = [[NSMutableArray alloc] init];
    
    
    //  从列表带过来的数据，检查状态
    for(XMLockRelat * lock in self.device.rowDataArray){
        
        NSLog(@"%@",lock.macAddr);
        
        if([lock.lockStat integerValue]==2){
            //开
            lockStatus = false;
        }else{
            lockStatus = true;
            
        }
        
        [lockStatusDictinary setObject:@{@"lock":lock,@"status":@(YES),@"lockStatus":@(lockStatus),@"data":@[]} forKey:[NSString stringWithFormat:@"%@",lock.macAddr]];
        [self checkLockStatus:lock enable:NO];
       
    }
    
    isTimeOut = true;
    [self initLocation];
    
//    [self startGetLocation];
    
    peripherals =[[ NSMutableArray alloc] init];
    

//    self.options = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithBool:YES], CBCentralManagerScanOptionAllowDuplicatesKey,nil];

    customNav = [[XMNavCustom alloc] init];
    [customNav setNavLeftBtnImage:@"backWhite" LeftBtnSelectedImage:@"" mySelf:self width:40 height:40];
    customNav.NavDelegate = self;
 
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    
    // Do any additional setup after loading the view.
}

-(void)initLockStatus{
    [car.oneButton setImage:[UIImage imageNamed:@"what_no_select"] forState:UIControlStateNormal];
    car.oneButton.enabled = NO;
    
    [car.twoButton setImage:[UIImage imageNamed:@"what_no_select"] forState:UIControlStateNormal];
    car.twoButton.enabled = NO;
    
    [car.threeButton setImage:[UIImage imageNamed:@"what_no_select"] forState:UIControlStateNormal];
    car.threeButton.enabled = NO;
    
    [car.fourButton setImage:[UIImage imageNamed:@"what_no_select"] forState:UIControlStateNormal];
    car.fourButton.enabled = NO;
    
    [car.fiveButton setImage:[UIImage imageNamed:@"what_no_select"] forState:UIControlStateNormal];
    car.fiveButton.enabled = NO;
    
    [car.sixButton setImage:[UIImage imageNamed:@"what_no_select"] forState:UIControlStateNormal];
    car.sixButton.enabled = NO;
    
    [car.servenButton setImage:[UIImage imageNamed:@"what_no_select"] forState:UIControlStateNormal];
    car.servenButton.enabled = NO;
    
    
}

-(void)NavLeftButtononClick{
    
    if(_myPeripheral){
        [self disconnectPeripheral:_centralManager peripheral:_myPeripheral];
    }
    
    [self.centralManager stopScan];
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)checkLockStatus:(XMLockRelat*)lock enable:(BOOL)enabel{
    
    if([lock.pos isEqualToString:@"上前"]){
        [self checkLockButton:car.oneButton label:car.oneLabel lockRelat:lock enable:enabel];
    }
    else if([lock.pos isEqualToString:@"上"]){
        [self checkLockButton:car.twoButton label:car.twoLabel lockRelat:lock enable:enabel];
    }
    else if([lock.pos isEqualToString:@"中"]){
        [self checkLockButton:car.threeButton label:car.threeLabel lockRelat:lock enable:enabel];
    }
    else if([lock.pos isEqualToString:@"上后"]){
        [self checkLockButton:car.fourButton label:car.fourLabel lockRelat:lock enable:enabel];
    }
    else if([lock.pos isEqualToString:@"左后"]){
        [self checkLockButton:car.fiveButton label:car.fiveLabel lockRelat:lock enable:enabel];
    }
    else if([lock.pos isEqualToString:@"后"]){
        [self checkLockButton:car.sixButton label:car.sixLabel lockRelat:lock enable:enabel];
    }
    else if([lock.pos isEqualToString:@"右后"]){
        [self checkLockButton:car.servenButton label:car.servenLabel lockRelat:lock enable:enabel];
    }
}


-(void)getLockPassword:(NSString*)lockMac{
    [XMDataManager checkDevicePasswordManager:@{@"lockMac":lockMac} success:^(id result) {
        
        OTP = [[result objectForKey:@"obj"] objectForKey:@"OTP"];
        
        if([peripherals count]==0){
            
            [XMMethod alertErrorMessage:@"未查找到相关设备"];
            return;
        }
        CBPeripheral * per = [peripherals[0] objectForKey:@"peripheral"];

        if(!per){
            [XMMethod alertErrorMessage:@"未查找到相关设备"];
            
            return;
        }
       
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [LCLoadingHUD showLoading:@"正在连接设备，请稍后..."];
            isTimeOut = true;

            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW,5 * NSEC_PER_SEC); dispatch_after(popTime, dispatch_get_main_queue(), ^(void){ // do something
                if(isTimeOut){
                    [LCLoadingHUD showLoading:@"连接超时，请重新连接。"];
                    [LCLoadingHUD hideInKeyWindow];
                }
               
                
            });

        });
        
        timer = [NSTimer timerWithTimeInterval:8 target:self selector:@selector(timerMethod) userInfo:nil repeats:NO];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        
        
        [self.centralManager connectPeripheral:per options:nil];

    } err:^(NSError *error) {
        
    }];
}


-(void)timerMethod{
    
    [LCLoadingHUD showLoading:@"连接超时，请重新连接。"];
    isTimeOut = false;
    [self.centralManager stopScan];
    [self disconnectPeripheral:_centralManager peripheral:_myPeripheral];
    [timer invalidate];
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC); dispatch_after(popTime, dispatch_get_main_queue(), ^(void){ // do something
        
        [LCLoadingHUD hideInKeyWindow];
        
    });
}


-(void)initLocation
{
    // 定位管理器
    _locationManager = [[CLLocationManager alloc] init];
    _geocoder = [[CLGeocoder alloc] init];
    // 当它定位完成,获得用户的经度和纬度时,会通知代理
    _locationManager.delegate = self;
    [_locationManager requestWhenInUseAuthorization];
    [_locationManager startUpdatingLocation];
}

#pragma mark 启动定位
//- (BOOL)startGetLocation
//{
//
//    if ([CLLocationManager locationServicesEnabled]) {
//        // 定位管理器 开始更新位置
//        return YES;
//    } else {
//        return NO;
//    }
//}

#pragma mark - 定位管理器 代理方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    // 1.既然已经定位到了用户当前的经纬度了,那么可以让定位管理器 停止定位了
    [_locationManager stopUpdatingLocation];
    // 2.然后,取出第一个位置,根据其经纬度,通过CLGeocoder反向解析,获得该位置所在的城市名称
    CLLocation *loc = [locations firstObject];
    
    [self getAddressByLocation:loc];
}

#pragma mark 根据坐标取得地名
-(void)getAddressByLocation:(CLLocation *)location
{
    //    __weak __typeof(self)weakSelf = self;
    

     coordinate = location.coordinate;
    //反地理编码
    [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark = [placemarks firstObject];
        NSString *locality = placemark.locality;
        NSRange range = [locality rangeOfString:@"市"];
        if (range.length > 0) {
            // 将最后一个字符【市】去掉
            locality = [placemark.locality substringToIndex:placemark.locality.length - 1]; // 城市
        }
        
        // 获取详细地址信息
        
        NSArray* addrArray = [placemark.addressDictionary objectForKey:@"FormattedAddressLines"];
        
        // 将详细地址拼接成一个字符串
        NSMutableString* addr = [[NSMutableString alloc] init];
        for(int i = 0 ; i < addrArray.count ; i ++)
        {
            [addr appendString:addrArray[i]];
        }
        
        currentCity = addr;
        
        NSLog(@"locality : %@", locality);
        
        //        if ([weakSelf.delegate respondsToSelector:@selector(didFinishLocations:error:)]) {
        //            weakSelf.locationState = SuSLocationFinish;
        //            [weakSelf.delegate didFinishLocations:[placemarks firstObject] error:error];
        //        }
    }];
}

-(void)checkLockButton:(UIButton*)btn label:(UILabel*)label lockRelat:(XMLockRelat*)lockRelat enable:(BOOL)enable{
    btn.hidden = NO;
    label.hidden = NO;
    
    btn.enabled = enable;
    if(enable){
        if([lockRelat.lockStat integerValue]==1){
            //设备打开状态
            [btn setImage:[UIImage imageNamed:@"find_lock_open_status"] forState:UIControlStateNormal];
        }else if([lockRelat.lockStat integerValue]==2){
            //设备关闭
            [btn setImage:[UIImage imageNamed:@"find_nearIcon_close"] forState:UIControlStateNormal];
        }
        else{
            //未知状态
            [btn setImage:[UIImage imageNamed:@"what_select"] forState:UIControlStateNormal];
        }
    }else{
        if([lockRelat.lockStat integerValue]==1){
            //设备打开状态
            [btn setImage:[UIImage imageNamed:@"noFind_open_lock"] forState:UIControlStateNormal];
        }else if([lockRelat.lockStat integerValue]==2){
            //设备关闭
            [btn setImage:[UIImage imageNamed:@"lock_close_status"] forState:UIControlStateNormal];
        }
        else{
            //未知状态
            [btn setImage:[UIImage imageNamed:@"what_no_select"] forState:UIControlStateNormal];
        }
    }
    
 
}

-(void)viewDidAppear:(BOOL)animated{
  
}

-(void)onClick:(UIButton*)btn
{
    switch (btn.tag) {
        case 101:
        {
//            [XMShowPhotoPicker showPhotoPickerView:self backImage:^(NSArray<UIImage *> *images) {
//                [btn setImage:images[0] forState:UIControlStateNormal];
//            }];
        }
        break;
            
        case 102:
        {
//            [XMShowPhotoPicker showPhotoPickerView:self backImage:^(NSArray<UIImage *> *images) {
//                [btn setImage:images[0] forState:UIControlStateNormal];
//
//            }];
        }
            break;
            
        case 103:
        {
//            [XMShowPhotoPicker showPhotoPickerView:self backImage:^(NSArray<UIImage *> *images) {
//                [btn setImage:images[0] forState:UIControlStateNormal];
//
//            }];
        }
            break;
            
        case 104:
        {
//            [XMShowPhotoPicker showPhotoPickerView:self backImage:^(NSArray<UIImage *> *images) {
//                [btn setImage:images[0] forState:UIControlStateNormal];
//
//            }];
        }
            break;
            
        case 105:
        {
//            [XMShowPhotoPicker showPhotoPickerView:self backImage:^(NSArray<UIImage *> *images) {
//                [btn setImage:images[0] forState:UIControlStateNormal];
//
//            }];
        }
            break;
            
        case 106:
        {
//            [XMShowPhotoPicker showPhotoPickerView:self backImage:^(NSArray<UIImage *> *images) {
//                [btn setImage:images[0] forState:UIControlStateNormal];
//
//            }];
        }
            break;
            
        case 107:
        {
//            [XMShowPhotoPicker showPhotoPickerView:self backImage:^(NSArray<UIImage *> *images) {
//                [btn setImage:images[0] forState:UIControlStateNormal];
//
//            }];
        }
            break;
            
            
        default:
            break;
    }
    currentLock =btn;
    
    
    NSDictionary * lockDic = @{@"101":@"上前",
                               @"102":@"上",
                               @"103":@"中",
                               @"104":@"上后",
                               @"105":@"左后",
                               @"106":@"后",
                               @"107":@"右后",
                               
                               };
    
    

    
    for(XMLockRelat * lock in self.device.rowDataArray){
        if([lock.pos isEqualToString:[lockDic objectForKey:[NSString stringWithFormat:@"%ld",btn.tag]]]){
            
            if([[lockStatusDictinary objectForKey:[NSString stringWithFormat:@"%@",lock.macAddr]] objectForKey:@"status"]){
                
                posString =lock.pos;
                macAddr = lock.macAddr;
                lockStatus = [[[lockStatusDictinary objectForKey:[NSString stringWithFormat:@"%@",lock.macAddr]]  objectForKey:@"lockStatus"] boolValue];
                peripherals = [[lockStatusDictinary objectForKey:[NSString stringWithFormat:@"%@",lock.macAddr]]  objectForKey:@"data"];
                [self getLockPassword:lock.macAddr];

            }
            
            selectLockRelat = [[XMLockRelat alloc] init];
            selectLockRelat = lock;
            macAddr =lock.macAddr;
            break;
        }
    }

    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [appDelegate.tabbar hideTabBar];
}



-(void)centralManagerDidUpdateState:(CBCentralManager *)central{
    switch (central.state) {
        case CBCentralManagerStateUnknown:
            NSLog(@">>>CBCentralManagerStateUnknown");
            break;
        case CBCentralManagerStateResetting:
            NSLog(@">>>CBCentralManagerStateResetting");
            break;
        case CBCentralManagerStateUnsupported:
            NSLog(@">>>CBCentralManagerStateUnsupported");
            break;
        case CBCentralManagerStateUnauthorized:
            NSLog(@">>>CBCentralManagerStateUnauthorized");
            break;
        case CBCentralManagerStatePoweredOff:
        {
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"未获得授权使用蓝牙" message:@"请在iOS-“设置”-“蓝牙”中打开" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
            
            break;
        case CBCentralManagerStatePoweredOn:
            NSLog(@">>>CBCentralManagerStatePoweredOn");
            //开始扫描周围的外设
            /*
             第一个参数nil就是扫描周围所有的外设，扫描到外设后会进入
             - (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI;
             */
            
            [self.centralManager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:@"FF00"]] options:nil];
            
            break;
        default:
            break;
    }
}



//扫描到设备会进入方法
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
 
    NSData *data = [advertisementData objectForKey:@"kCBAdvDataManufacturerData"];
    //            Byte *testByte = (Byte *)[data bytes];
    //            NSMutableArray *byte = [NSMutableArray array];
    
    NSUInteger len = [data length];
    Byte *byteData = (Byte *)malloc(len);
    memcpy(byteData, [data bytes], len);
    NSMutableString *commandArray = [[NSMutableString alloc] init];

    NSString * allString = @"";
    
    // Byte数组转字符串
    for (int i = 0; i < len; i++) {
        
        allString = [allString stringByAppendingString:[NSString stringWithFormat:@"%02x", byteData[i]]];
        NSString *str = [NSString stringWithFormat:@"%02x", byteData[i]];
        if(i>=9&&i<14){
            [commandArray appendString:str];
            [commandArray appendString:@":"];
        }
        if(i==14){
            [commandArray appendString:str];
        }
        
        NSLog(@"byteData = %@", str);
    }
    NSLog(@"byteData = %@", [commandArray uppercaseString]);

    

    if((![XMMethod isNull:commandArray] && [lockStatusDictinary.allKeys containsObject:[commandArray uppercaseString]])){
        
        //            [findDeviceArr addObject:[commandArray uppercaseString]];
        
        NSMutableArray * data = [[NSMutableArray alloc] init];
        
        if([allString length]==0)
            return ;
        NSString * status = [allString substringWithRange:NSMakeRange(4, 2)];
        NSLog(@"byteData = %@", [commandArray uppercaseString]);

        if([status isEqualToString:@"02"]){
            //开
            lockStatus = false;
        }else{
            lockStatus = true;
            
        }
        
        [data addObject:@{@"peripheral":peripheral,@"advertisementData":advertisementData,@"wifi":RSSI}];
        
        XMLockRelat * lock =[[lockStatusDictinary objectForKey:[commandArray uppercaseString]] objectForKey:@"lock"];
        lock.lockStat = status;
        //将锁的状态传过去
        [lockStatusDictinary setObject:@{@"lock":lock,@"status":@(TRUE),@"lockStatus":@(lockStatus), @"data":data} forKey:[commandArray uppercaseString]];
        
        dispatch_async(dispatch_get_main_queue(),^{
            [self checkLockStatus:lock enable:YES];
            
        });
        
    }
//    else{
//
//        for(XMLockRelat * lock in self.device.rowDataArray){
//
//            NSLog(@"%@",lock.macAddr);
//            if(![XMMethod isNull:commandArray] && ![[lock.macAddr uppercaseString] isEqualToString:[commandArray uppercaseString]]){
//                [lockStatusDictinary setObject:@{@"lock":lock,@"status":@(NO),@"data":@[]} forKey:[NSString stringWithFormat:@"%@",lock.macAddr]];
//                [self checkLockStatus:lock enable:NO];
//            }
//
//        }
//
//
//    }

}


//连接到Peripherals-失败
-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@">>>连接到名称为（%@）的设备-失败,原因:%@",[peripheral name],[error localizedDescription]);
    [self disconnectPeripheral:_centralManager peripheral:peripheral];
    [timer invalidate];

}

//Peripherals断开连接
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@">>>外设连接断开连接 %@: %@\n", [peripheral name], [error localizedDescription]);
    [timer invalidate];

}

//连接到Peripherals-成功
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@">>>连接到名称为（%@）的设备-成功",peripheral.name);
    //设置的peripheral委托CBPeripheralDelegate
    //@interface ViewController : UIViewController<CBCentralManagerDelegate,CBPeripheralDelegate>
    [peripheral setDelegate:self];
    //扫描外设Services，成功后会进入方法：-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{

    _myPeripheral = peripheral;
    [timer invalidate];

    //获得服务
    [peripheral discoverServices:@[[CBUUID UUIDWithString:@"0000ff00-0000-1000-8000-00805f9b34fb"],[CBUUID UUIDWithString:@"0000ff09-0000-1000-8000-00805f9b34fb"]]];

}

//扫描到Services
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    //  NSLog(@">>>扫描到服务：%@",peripheral.services);
    if (error)
    {
        NSLog(@">>>Discovered services for %@ with error: %@", peripheral.name, [error localizedDescription]);
        [self disconnectPeripheral:_centralManager peripheral:peripheral];

        return;
    }
    
    for (CBService *service in peripheral.services) {
         //扫描每个service的Characteristics，扫描到后会进入方法： -(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
        [peripheral discoverCharacteristics:nil forService:service];
    }
}


//扫描到Characteristics
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    if (error)
    {
        NSLog(@"error Discovered characteristics for %@ with error: %@", service.UUID, [error localizedDescription]);
        return;
    }
    
    for (CBCharacteristic *characteristic in service.characteristics) {
        
        if([characteristic.UUID.UUIDString isEqualToString:@"FF09"]){
            //订阅通知
            [self notifyCharacteristic:peripheral characteristic:characteristic];
        }
        if ([characteristic.UUID.UUIDString isEqualToString:@"FF02"]) {//你需要的characteristic UUID
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
            
            NSInteger OTPInt = [OTP integerValue];
            
            Byte dataArr[19] = {0};
            dataArr[0]=lockStatus?0:1;//开锁1，关锁0，
            dataArr[1]=2;//2（通过授权模式开关锁），0（通过密码方式开关锁）
            dataArr[2]=OTPInt&0x000000ff;
            dataArr[3]=(OTPInt&0x0000ff00)>> 8;
            dataArr[4]=(OTPInt&0x00ff0000)>> 16;
            dataArr[5]=(OTPInt&0xff000000)>> 24;


            [LCLoadingHUD showLoading:lockStatus?@"正在施封，请稍候":@"正在解封，请稍候"];
            NSData *data = [NSData dataWithBytes:dataArr length:19];
            //    [self.myPeripheral writeValue:data forDescriptor:CBCharacteristicWriteWithResponse];
            [peripheral writeValue:data forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
            
        }
    }
    
}
//获取的charateristic的值
-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    //打印出characteristic的UUID和值
    //!注意，value的类型是NSData，具体开发时，会根据外设协议制定的方式去解析数据
    NSLog(@"characteristic uuid:%@  value:%@",characteristic.UUID,characteristic.value);

    NSString * value = [[NSString alloc] initWithFormat:@"%@",characteristic.value];
    
    NSString * success = [value substringWithRange:NSMakeRange(3, 2)];
    NSString * status = [value substringWithRange:NSMakeRange(5, 2)];
    
    NSString * runtime = [value substringWithRange:NSMakeRange(7, 2)];
    NSString * plugVT = [value substringWithRange:NSMakeRange(9, 2)];

    NSString * lockStatusString ;
    
    [self disconnectPeripheral:_centralManager peripheral:peripheral];
    isTimeOut = false;

    if([success isEqualToString:@"01"]){
        
//        [appDelegate.window hideToastActivity];


        if([status isEqualToString:@"01"]){
            [LCLoadingHUD showLoading:[NSString stringWithFormat:@"%@ 解封成功",posString]];

            [currentLock setImage:[UIImage imageNamed:@"find_lock_open_status"] forState:UIControlStateNormal];
            lockStatusString = @"1";
            [lockStatusDictinary setObject:@{@"lock":[[lockStatusDictinary objectForKey:macAddr] objectForKey:@"lock"],@"status":@(TRUE), @"lockStatus":@(TRUE),@"data":[[lockStatusDictinary objectForKey:macAddr] objectForKey:@"data"]} forKey:macAddr];
        
            [self notify:lockStatusString runtime:runtime plugVT:plugVT];
            
            [self initLockStatus];

            self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];

            [self.centralManager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:@"FF00"]] options:nil];


        }
        else if([status isEqualToString:@"02"]){
            [LCLoadingHUD showLoading:[NSString stringWithFormat:@"%@ 施封成功",posString]];

            [currentLock setImage:[UIImage imageNamed:@"find_nearIcon_close"] forState:UIControlStateNormal];
            lockStatusString = @"2";
            [lockStatusDictinary setObject:@{@"lock":[[lockStatusDictinary objectForKey:macAddr] objectForKey:@"lock"],@"status":@(TRUE),@"lockStatus":@(false), @"data":[[lockStatusDictinary objectForKey:macAddr] objectForKey:@"data"]} forKey:macAddr];

            [self notify:lockStatusString runtime:runtime plugVT:plugVT];
            
            [self initLockStatus];

            self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];

            [self.centralManager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:@"FF00"]] options:nil];

        }
        else{
            lockStatusString = @"0";
        }
    }
    else{
        
//        [appDelegate.window hideToastActivity];

        if([status isEqualToString:@"02"]){
            [XMMethod alertErrorMessage:@"密码错误"];
            
        }else{
            [XMMethod alertErrorMessage:@"出现未知错误"];
        }
    }
    

}

-(void)notify:(NSString*)lockStatusString runtime:(NSString*)runtime plugVT:(NSString*)plugVT{
    
//    [LCLoadingHUD showLoading:@"正在更新服务器，请稍等..."];

    
    [XMDataManager postRecoderRequestManager:@{@"oprtWay":@"2",
                                               @"lockID":selectLockRelat.lockID,
                                               @"oprtUserID":[XMUserModel shareInstance].userID,
                                               @"authoUserID":selectLockRelat.posID,
                                               @"oprtGID":selectLockRelat.posID,
                                               @"oprtTime":[self currentTimeStr],
                                               @"oprtLat":[NSString stringWithFormat:@"%f",coordinate.latitude],
                                               @"oprtLng":[NSString stringWithFormat:@"%f",coordinate.longitude],
                                               @"oprtAddr":currentCity,
                                               @"oprtStat":lockStatusString,
                                               @"runT":runtime,
                                               @"plugV":plugVT,
                                               @"devIMEI":[XMMethod getUUID],
                                               } success:^(id result) {
                                                   
                                                   NSLog(@"%@",runtime);
                                                   
                                                   oprtId = [result objectForKey:@"obj"];
                                                   
//                                                   [LCLoadingHUD showLoading:@"更新成功"];

                                                   if([[NSUserDefaults standardUserDefaults] objectForKey:@"takePhoto"]){
                                                       [self toPhoto];

                                                   }
                                                   
                                                   dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC); dispatch_after(popTime, dispatch_get_main_queue(), ^(void){ // do something
                                                       
                                                       [LCLoadingHUD hideInKeyWindow];

                                                   });
                                                       
                                                    

                                               } err:^(NSError *error) {
                                                   
                                                   [LCLoadingHUD hideInKeyWindow];
                                                   
                                               }];
}

-(void)toPhoto{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您需要拍照吗？" delegate:self cancelButtonTitle:@"去拍照" otherButtonTitles:@"取消", nil];
    [alert show];
    
 
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [XMRequestNetWork cancelRequestNetWork];
    [LCLoadingHUD hideInKeyWindow];
    if(_myPeripheral){
        [self disconnectPeripheral:_centralManager peripheral:_myPeripheral];
    }
    
    [self.centralManager stopScan];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0){
        [XMDataManager getKeyServiceManager:@{} success:^(id result) {
            
            NAPushFile * file = [[NAPushFile alloc] init];
            NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
            [dic setDictionary:result[@"obj"]];
            [dic setObject:macAddr forKey: @"lockMac"];
            [file setVc:self];
            file.oprtId = oprtId;
            [file setPushDic:dic];
            
        } err:^(NSError *error) {
            
        }];
    }
}

//获取当前时间戳
- (NSString *)currentTimeStr{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time=[date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}
//搜索到Characteristic的Descriptors
-(void)peripheral:(CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    
    //打印出Characteristic和他的Descriptors
    NSLog(@"characteristic uuid:%@",characteristic.UUID);
    for (CBDescriptor *d in characteristic.descriptors) {
        NSLog(@"Descriptor uuid:%@",d.UUID);
    }
    
}
//获取到Descriptors的值
-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error{
    //打印出DescriptorsUUID 和value
    //这个descriptor都是对于characteristic的描述，一般都是字符串，所以这里我们转换成字符串去解析
    NSLog(@"characteristic uuid:%@  value:%@",[NSString stringWithFormat:@"%@",descriptor.UUID.UUIDString],descriptor.value);
    
  
}

//写数据
-(void)writeCharacteristic:(CBPeripheral *)peripheral
            characteristic:(CBCharacteristic *)characteristic
                     value:(NSData *)value{
    
    //打印出 characteristic 的权限，可以看到有很多种，这是一个NS_OPTIONS，就是可以同时用于好几个值，常见的有read，write，notify，indicate，知知道这几个基本就够用了，前连个是读写权限，后两个都是通知，两种不同的通知方式。
    /*
     typedef NS_OPTIONS(NSUInteger, CBCharacteristicProperties) {
     CBCharacteristicPropertyBroadcast                                              = 0x01,
     CBCharacteristicPropertyRead                                                   = 0x02,
     CBCharacteristicPropertyWriteWithoutResponse                                   = 0x04,
     CBCharacteristicPropertyWrite                                                  = 0x08,
     CBCharacteristicPropertyNotify                                                 = 0x10,
     CBCharacteristicPropertyIndicate                                               = 0x20,
     CBCharacteristicPropertyAuthenticatedSignedWrites                              = 0x40,
     CBCharacteristicPropertyExtendedProperties                                     = 0x80,
     CBCharacteristicPropertyNotifyEncryptionRequired NS_ENUM_AVAILABLE(NA, 6_0)        = 0x100,
     CBCharacteristicPropertyIndicateEncryptionRequired NS_ENUM_AVAILABLE(NA, 6_0)  = 0x200
     };
     
     */
    NSLog(@"%lu", (unsigned long)characteristic.properties);
    
    
    //只有 characteristic.properties 有write的权限才可以写
    if(characteristic.properties & CBCharacteristicPropertyWrite){
        /*
         最好一个type参数可以为CBCharacteristicWriteWithResponse或type:CBCharacteristicWriteWithResponse,区别是是否会有反馈
         */
        [peripheral writeValue:value forCharacteristic:characteristic type:CBCharacteristicWriteWithResponse];
    }else{
        NSLog(@"该字段不可写！");
    }
    
    
}

-(void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    NSLog(@"%s",__FUNCTION__);
}

//设置通知notifyCharacteristic
-(void)notifyCharacteristic:(CBPeripheral *)peripheral
             characteristic:(CBCharacteristic *)characteristic{
    //设置通知，数据通知会进入：didUpdateValueForCharacteristic方法
    //设置通知，数据通知会进入：didUpdateValueForCharacteristic方法
    [peripheral setNotifyValue:YES forCharacteristic:characteristic];
    [self.centralManager stopScan];
}

//取消通知
-(void)cancelNotifyCharacteristic:(CBPeripheral *)peripheral
                   characteristic:(CBCharacteristic *)characteristic{
    
    [peripheral setNotifyValue:NO forCharacteristic:characteristic];
}

//停止扫描并断开连接
-(void)disconnectPeripheral:(CBCentralManager *)centralManager
                 peripheral:(CBPeripheral *)peripheral{
    //停止扫描
    [centralManager stopScan];
    //断开连接
    [centralManager cancelPeripheralConnection:peripheral];
    [timer invalidate];

    NSLog(@"蓝牙已断开连接");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    if(_myPeripheral){
        [self disconnectPeripheral:_centralManager peripheral:_myPeripheral];
    }

    [self.centralManager stopScan];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
