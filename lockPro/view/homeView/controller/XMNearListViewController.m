//
//  XMNearListViewController.m
//  lockPro
//
//  Created by laoniu on 2018/5/29.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "XMNearListViewController.h"
#import "XMNearListCell.h"
#import "XMConfirmButtonCell.h"
#import "BabyBluetooth.h"
#import <iconv.h>

@interface XMNearListViewController ()<UITableViewDelegate,UITableViewDataSource,NavCustomDelegate>
{
    //定义变量
    BabyBluetooth *baby;
    
    //用于保存被发现设备
    NSMutableArray *peripherals;
    
    XMConfirmButtonCell *bottomView ;
    
    
    XMNavCustom * customNav;
    
    
}

@property (nonatomic,strong) UITableView * tableView;
@end

@implementation XMNearListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"附近设备";
    
    
    peripherals = [[NSMutableArray alloc] init];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-20-78)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc] init];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    //初始化BabyBluetooth 蓝牙库
    baby = [BabyBluetooth shareBabyBluetooth];
    //设置蓝牙委托
    [self babyDelegate];
    //设置委托后直接可以使用，无需等待CBCentralManagerStatePoweredOn状态
    baby.scanForPeripherals().begin();
    
    [appDelegate.tabbar hideTabBar];
    self.title = @"正在扫描附近的设备...";
    
    bottomView =  [[[NSBundle mainBundle]loadNibNamed:@"XMConfirmButtonCell" owner:self options:nil]lastObject];
    bottomView.frame = CGRectMake(0, kScreen_Height-20-78, kScreen_Width,78);
    [bottomView.confirmButton addTarget:self action:@selector(onConfirmButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview: bottomView];
    
    bottomView.confirmButton.selected = true;
    
    
    customNav = [[XMNavCustom alloc] init];
    [customNav setNavLeftBtnImage:@"backWhite" LeftBtnSelectedImage:@"" mySelf:self width:40 height:40];
    customNav.NavDelegate = self;
}

-(void)NavLeftButtononClick{
    
    [baby cancelAllPeripheralsConnection];
    [baby cancelScan];
    [self.navigationController popViewControllerAnimated:YES];
}

//设置蓝牙委托
-(void)babyDelegate{
    
    //设置扫描到设备的委托
    [baby setBlockOnDiscoverToPeripherals:^(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI) {
        
        
        NSLog(@"搜索到了设备:%@",peripheral.name);
//        NSMutableString *string;
//        if([peripheral.name isEqualToString:@"unseal015"] || [peripheral.name isEqualToString:@"laoniu的MacBook Pro"])
//        {
//
//        }
//        else{
//            string = [[NSMutableString alloc]  initWithData:[advertisementData objectForKey:@"kCBAdvDataManufacturerData"] encoding:NSUTF8StringEncoding];
//
//            NSData *data = [advertisementData objectForKey:@"kCBAdvDataManufacturerData"];
////            Byte *testByte = (Byte *)[data bytes];
////            NSMutableArray *byte = [NSMutableArray array];
//
//            NSUInteger len = [data length];
//            Byte *byteData = (Byte *)malloc(len);
//            memcpy(byteData, [data bytes], len);
//            NSMutableString *commandArray = [[NSMutableString alloc] init];
//            // Byte数组转字符串
//            for (int i = 0; i < len; i++) {
//                NSString *str = [NSString stringWithFormat:@"%02x", byteData[i]];
//                if(i>=9&&i<14){
//                    [commandArray appendString:str];
//                    [commandArray appendString:@":"];
//                }
//                if(i==14){
//                    [commandArray appendString:str];
//                }
//                NSLog(@"byteData = %@", str);
//            }
//
//            NSLog(@"byteData = %@", commandArray);
//
//
//        }
//        if (!string) {
//            string = [[NSMutableString alloc]initWithData:[self cleanUTF8:[advertisementData objectForKey:@"kCBAdvDataServiceData"]] encoding:NSUTF8StringEncoding];
//        }
        
        
        //如果扫描到的mac地址为空，那么就直接跳过
//        if (!string) {
//            return ;
//        }
        
        if(![XMMethod isNull:peripheral.name]){
            NSLog(@"%ld",RSSI.integerValue);
            [peripherals addObject:@{@"peripheral":peripheral,@"advertisementData":advertisementData,@"wifi":RSSI}];
            [self.tableView reloadData];
        }
    }];
    
    //过滤器
    //设置查找设备的过滤器
    [baby setFilterOnDiscoverPeripherals:^BOOL(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI) {
        //最常用的场景是查找某一个前缀开头的设备 most common usage is discover for peripheral that name has common prefix
        //if ([peripheralName hasPrefix:@"Pxxxx"] ) {
        //    return YES;
        //}
        //return NO;
        //设置查找规则是名称大于1 ， the search rule is peripheral.name length > 1
        if (peripheralName.length >1) {
            return YES;
        }
        return NO;
    }];
    
    //.......

}

-(NSString*)getMac:(id)data{
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
    
    return  commandArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [appDelegate.tabbar hideTabBar];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  65;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return peripherals.count;
}

//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//
//    return bottomView;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 78;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMNearListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XMNearListCell" ];
    if(!cell){
        cell = [[[NSBundle mainBundle]loadNibNamed:@"XMNearListCell" owner:self options:nil]lastObject];
    }
    // Configure the cell...
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    CBPeripheral * pheral = [[peripherals objectAtIndex:indexPath.row] objectForKey:@"peripheral"];
    cell.lockName.text = pheral.name;
    if(![[[peripherals objectAtIndex:indexPath.row] objectForKey:@"advertisementData"] objectForKey:@"kCBAdvDataManufacturerData"]){
        cell.lockMac.text = @"未知";
    }else{
        cell.lockMac.text = [self getMac:[[[peripherals objectAtIndex:indexPath.row] objectForKey:@"advertisementData"] objectForKey:@"kCBAdvDataManufacturerData"]];

    }

    //wifi
//    NSInteger wifi = [[peripherals objectAtIndex:indexPath.row] objectForKey:@"wifi"];
    return cell;
}

-(void)onConfirmButtonClick:(UIButton*)btn{
    
    btn.selected = !btn.selected;
    if(btn.selected){
        [bottomView.confirmButton setTitle:@"停止扫描" forState:UIControlStateNormal];
        [peripherals removeAllObjects];
        [self.tableView reloadData];
        baby.scanForPeripherals().begin();
        
    }else{
        [bottomView.confirmButton setTitle:@"开始扫描" forState:UIControlStateNormal];
        [baby cancelScan];
        

    }
   
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)dealloc
{
 
}

@end
