//
//  XMHomeVontroller.m
//  lockPro
//
//  Created by 牛付威 on 2018/5/28.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "XMHomeViewController.h"
#import "XMHomeListViewVell.h"
#import "XMHomeHeaderView.h"
#import "CZHPopUpView.h"
#import "CZHHeader.h"
#import "HWScanViewController.h"
#import "XMSearchCarViewController.h"
#import "XMDevice.h"
#import "XMBleTableViewController.h"
#import "SGQRCodeScanManager.h"

@interface XMHomeViewController ()<NavCustomDelegate,UITableViewDataSource,UITableViewDelegate,SGQRCodeScanManagerDelegate>
{
    XMNavCustom * nav;

}
@property (nonatomic,strong) NSMutableArray * sectionDataArray;
@property (nonatomic,strong) NSMutableDictionary*selectSection;
@property (nonatomic,strong) UITableView * tableView;



@end

@implementation XMHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的车辆";
    
    self.sectionDataArray = [[NSMutableArray alloc] init];

    self.selectSection = [[NSMutableDictionary alloc] init];
    
    
    self.tableView = [[UITableView alloc] initWithFrame: CGRectMake(0, 0, kScreen_Width, kScreen_Height-49)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];

    nav = [[XMNavCustom alloc] init];
    nav.NavDelegate = self;
    [nav setNavLeftBtnImage:@"searchWhite" LeftBtnSelectedImage:@"searchWhite" mySelf:self width:25 height:25];
    
    [nav setNavRightBtnImage:@"more" RightBtnSelectedImage:@"more" mySelf:self width:25 height:25];
    
    
    // 下拉刷新
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self request];
        
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
   
}

-(void)request{
    [XMDataManager myDeviceListManager:@{@"userID":[XMUserModel shareInstance].userID,@"gsID":[XMUserModel shareInstance].gsID} success:^(id result) {
        
        [self.sectionDataArray removeAllObjects];
        [self.selectSection removeAllObjects];
        
        NSDictionary * dic = result[@"obj"];
        
        for(NSInteger i =0;i<[dic[@"lsCT"] count];i++){
            XMDevice * device = [[XMDevice alloc] init];
            [device.lsCT setValuesForKeysWithDictionary:dic[@"lsCT"][i]];
            
//            NSArray * kkkArray = @[@{@"name":@"后",@"value":@(0x01)},
//                                   @{@"name":@"左后",@"value":@(0x02)},
//                                   @{@"name":@"右后",@"value":@(0x04)},
//                                   @{ @"name":@"上",@"value":@(0x08)},
//                                   @{@"name":@"上前",@"value":@(0x10)},
//                                   @{ @"name":@"上后",@"value":@(0x20)},
//                                   @{@"name":@"中",@"value":@(0x40)}];
            
//            for(int kkk = 0; kkk<[kkkArray count];kkk++){
            
              
//                if(([device.lsCT.posInfo integerValue] & [kkkArray[kkk][@"value"] integerValue]) == [kkkArray[kkk][@"value"] integerValue]){
            
                    for(NSInteger j =0;j<[dic[@"lsMyLock"] count];j++){
                        
                        
//                        if([[XMMethod checkParam:dic[@"lsMyLock"][j][@"containerID"]] isEqualToString:[XMMethod checkParam:device.lsCT.containerID]] && [[XMMethod checkParam:dic[@"lsMyLock"][j][@"pos"]] isEqualToString:kkkArray[kkk][@"name"]])
                        if([[XMMethod checkParam:dic[@"lsMyLock"][j][@"containerID"]] isEqualToString:[XMMethod checkParam:device.lsCT.containerID]])
                        {
                            XMDevice * deviceRow = [[XMDevice alloc] init];
                            [deviceRow.lsMyLock setValuesForKeysWithDictionary:dic[@"lsMyLock"][j]];
                            [device.rowDataArray addObject:deviceRow.lsMyLock];
                        }
//                        else{
//
//
//
//
//
//
//                        }
//
                    }
//                }else{
//                    XMDevice * deviceRow = [[XMDevice alloc] init];
//
//                    NSDecimalNumber * number = [[NSDecimalNumber alloc] initWithInt:[device.lsCT.statInfo intValue]];
//                    [self getHexByDecimal:number];
//
//                    deviceRow.lsMyLock.SN = @"";
//                    deviceRow.lsMyLock.pos = kkkArray[kkk][@"name"];
//                    [device.rowDataArray addObject:deviceRow.lsMyLock];
//                }
                
//            }
            
          
           
          
            [self.sectionDataArray addObject:device];
            
        }
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
        
    } err:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];

    }];
}

- (NSString *)getHexByDecimal:(NSDecimalNumber *)decimal {
    //10进制转换16进制（支持无穷大数）
    NSString *hex =@"";
    NSString *letter;
    NSDecimalNumber *lastNumber = decimal;
    for (int i = 0; i<999; i++) {
        NSDecimalNumber *tempShang = [lastNumber decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"16"]];
        NSString *tempShangString = [tempShang stringValue];
        if ([tempShangString containsString:@"."]) {
            // 有小数
            tempShangString = [tempShangString substringToIndex:[tempShangString rangeOfString:@"."].location];
            // DLog(@"%@", tempShangString);
            NSDecimalNumber *number = [[NSDecimalNumber decimalNumberWithString:tempShangString] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"16"]];
            NSDecimalNumber *yushu = [lastNumber decimalNumberBySubtracting:number];
            int yushuInt = [[yushu stringValue] intValue]; switch (yushuInt) {
                case 10: letter =@"A";
                break;
                case 11: letter =@"B";
                break; case 12: letter =@"C";
                break; case 13: letter =@"D";
                break; case 14: letter =@"E";
                break; case 15: letter =@"F";
                break;
                default: letter = [NSString stringWithFormat:@"%d", yushuInt];
                    
            }
            lastNumber = [NSDecimalNumber decimalNumberWithString:tempShangString];
            
        } else {
            // 没有小数
            if (tempShangString.length <= 2 && [tempShangString intValue] < 16) {
                int num = [tempShangString intValue];
                if (num == 0) {
                    break;
                    
                }
                switch (num) {
                    case 10: letter =@"A"; break; case 11: letter =@"B";
                    break;
                    case 12: letter =@"C";
                    break;
                    case 13: letter =@"D";
                    break; case 14: letter =@"E";
                    break; case 15: letter =@"F";
                    break; default: letter = [NSString stringWithFormat:@"%d", num];
                        
                }
                hex = [letter stringByAppendingString:hex];
                break; } else { letter = @"0";
                    
                }
            lastNumber = tempShang;
            
        }
        hex = [letter stringByAppendingString:hex];
        
    }
    // return hex;
    return hex.length > 0 ? hex : @"0";
    
}
    
    

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [appDelegate.tabbar showTabBar];


}

-(void)viewDidAppear:(BOOL)animated{
    [appDelegate.tabbar showTabBar];
    [self request];

}

-(void)NavRightButtononClick{
    CGPoint point = CGPointMake(kScreen_Width-30, TheNavHeight+5 );
    
    CZHPopUpView *view = [CZHPopUpView czh_popUpWithPoint:point arrowOffset:CZH_ScaleWidth(150)];
    [view czh_addItemWithImageName:@"nearIcon" title:@"附近" clickHandler:^(CZHPopUpItem *item) {
       
        [XMMethod runtimePush:@"XMNearListViewController" dic:nil];
        
    }];
    
    [view czh_addItemWithImageName:@"scanIcon" title:@"扫一扫" clickHandler:^(CZHPopUpItem *item) {
        
    
        
        
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if(status != AVAuthorizationStatusAuthorized) {
            //            [XMMethod alertErrorMessage:@"您没有权限访问相机"];
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        HWScanViewController *vc = [[HWScanViewController alloc] init];
                        [vc scanResult:^(id result) {
                            [XMMethod runtimePush:@"XMCheckLockViewController" dic:nil];
                        }];
                        [self.navigationController presentViewController:vc animated:YES completion:nil];
                    });
                    NSLog(@"用户第一次同意了访问相机权限 - - %@", [NSThread currentThread]);
                } else {
                    NSLog(@"用户第一次拒绝了访问相机权限 - - %@", [NSThread currentThread]);
                }
            }];
            return;
        }
        else{
            HWScanViewController *vc = [[HWScanViewController alloc] init];
            [vc scanResult:^(id result) {
                [XMMethod runtimePush:@"XMCheckLockViewController" dic:nil];
            }];
            [self.navigationController presentViewController:vc animated:YES completion:nil];
        }
        
        
        /// 扫描二维码创建
//        SGQRCodeScanManager *scanManager = [SGQRCodeScanManager sharedManager];
//        NSArray *arr = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
//        // AVCaptureSessionPreset1920x1080 推荐使用，对于小型的二维码读取率较高
//        [scanManager setupSessionPreset:AVCaptureSessionPreset1920x1080 metadataObjectTypes:arr currentController:self];
//        scanManager.delegate = self;

        
    }];
    
//    [view czh_addItemWithImageName:@"scanIcon" title:@"扫描设备" clickHandler:^(CZHPopUpItem *item) {
//
//        XMBleTableViewController *vc = [[XMBleTableViewController alloc] init];
//
//        [self.navigationController pushViewController:vc animated:YES];
//
//
//
//    }];
    
   
    [view czh_showView];
}

-(void)NavLeftButtononClick{
    XMSearchCarViewController * search = [[XMSearchCarViewController alloc] init];
    search.carArray = self.sectionDataArray;
    [self.navigationController pushViewController:search  animated:YES];
    
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.sectionDataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if([self.selectSection valueForKey:[NSString stringWithFormat:@"%ld",section+1]])
    {
        XMDevice * device = [self.sectionDataArray objectAtIndex:section];
        return [device.rowDataArray count];
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 61;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 100;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    XMHomeHeaderView *headerView = [tableView dequeueReusableCellWithIdentifier:@"XMHomeHeaderView"];
    if(!headerView){
        headerView= [[[NSBundle mainBundle] loadNibNamed:@"XMHomeHeaderView" owner:self options:nil]lastObject];
    }
    headerView.sectionButton.tag = section+1;
    [headerView.sectionButton addTarget:self action:@selector(onSectionButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    if([self.selectSection valueForKey:[NSString stringWithFormat:@"%ld",section+1]]){
        [headerView.icon setImage:[UIImage imageNamed:@"topIcon"]];
    }else{
        [headerView.icon setImage:[UIImage imageNamed:@"downIcon"]];
    }
    headerView.icon.userInteractionEnabled = YES;
    headerView.icon.tag = section+1;
    UITapGestureRecognizer * tap= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onCheckCell:)];
    [headerView.icon addGestureRecognizer:tap];
  
    
    XMDevice * device = [self.sectionDataArray objectAtIndex:section];
    headerView.carNumber.text = device.lsCT.cUid;
    
    NSInteger openNumber=0;
    NSInteger closeNumber=0;
    NSInteger normalNumber=0;

    for(XMLockRelat *  relat in device.rowDataArray){
        if([relat.lockStat integerValue]==1){
            openNumber++;
        }else if([relat.lockStat integerValue]==2){
            closeNumber++;
        }else{
            normalNumber++;
        }
    }
    
    headerView.openNumber.text = [NSString stringWithFormat:@"%ld",openNumber];
    headerView.closeNumber.text = [NSString stringWithFormat:@"%ld",closeNumber];
    headerView.normalNumber.text =[NSString stringWithFormat:@"%ld",normalNumber];

    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMHomeListViewVell *cell = [tableView dequeueReusableCellWithIdentifier:@"XMHomeListViewVell" ];
    if(!cell){
        cell= [[[NSBundle mainBundle] loadNibNamed:@"XMHomeListViewVell" owner:self options:nil]lastObject];
    }
    // Configure the cell...
    
    
    XMDevice * device = [self.sectionDataArray objectAtIndex:indexPath.section];
    XMLockRelat * relat = [device.rowDataArray objectAtIndex:indexPath.row];
    
    if([relat.elec floatValue] < 20){
        cell.progress.backgroundColor = COLOR(250, 108, 132);
        [cell.progressBGView setImage:[UIImage imageNamed:@"dianchi_no"]];

    }else{
        cell.progress.backgroundColor = BLACKCOLOR;
        [cell.progressBGView setImage:[UIImage imageNamed:@"dianchi_ok"]];

    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    if([relat.elec floatValue]>100){
        relat.elec =@"100";
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        CGRect proGressWidth = cell.progress.frame;
        proGressWidth.size.width = [relat.elec floatValue]/100.0*15;
        cell.progress.frame = proGressWidth;
    });
    
  
    [cell.statusImage setImage:[UIImage imageNamed:[XMInstanceDataCheck checkLockStatus:relat.lockStat]]];
    cell.name.text = [NSString stringWithFormat:@"%@",relat.SN];
    cell.pos.text = relat.pos;
    return cell;
}

-(void)onSectionButtonClick:(UIButton*)btn{
    [XMMethod runtimePush:@"XMCarInfoViewController" dic:@{@"device":self.sectionDataArray[btn.tag-1]}];

}

-(void)onCheckCell:(UITapGestureRecognizer*)tap{
    if([self.selectSection valueForKey:[NSString stringWithFormat:@"%ld",tap.view.tag]]){
        [self.selectSection removeObjectForKey:[NSString stringWithFormat:@"%ld",tap.view.tag]];
    }else{
        [self.selectSection setValue:@1 forKey:[NSString stringWithFormat:@"%ld",tap.view.tag]];
    }
    
    [self.tableView reloadData];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [XMMethod runtimePush:@"XMCarInfoViewController" dic:@{@"device":self.sectionDataArray[indexPath.section]}];
}


@end
