//
//  XMBindDeviceListViewController.m
//  lockPro
//
//  Created by 牛付威 on 2018/6/1.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "XMBindDeviceListViewController.h"
#import "XMBindDeviceListCell.h"
#import "XMSingleLock.h"

@interface XMBindDeviceListViewController ()<UITableViewDataSource,UITableViewDelegate,NavCustomDelegate>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataArray;

@end

@implementation XMBindDeviceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"未绑定设备";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.backgroundColor = BGCOLOR;
    [self.view addSubview:self.tableView];
    
    
    // 下拉刷新
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.dataArray removeAllObjects];
        [self request];
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
 
    // Do any additional setup after loading the view.
}

-(void)request{
    self.dataArray = [[NSMutableArray alloc] init];
    
    [XMDataManager noBindDeviceManager:@{@"UserID":[XMUserModel shareInstance].userID,@"mStr":@"containerID = 0"} success:^(id result)
     {
         
         for(NSDictionary * dic in result[@"obj"][@"lsObj"]){
             XMSingleLock * lock = [[XMSingleLock alloc] initWithDictionary:dic error:nil];
             [self.dataArray addObject:lock];
         }
         [self.tableView.mj_header endRefreshing];

         [self.tableView reloadData];
         
     } err:^(NSError *error) {
         [self.tableView.mj_header endRefreshing];

     }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMBindDeviceListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XMBindDeviceListCell" ];
    if(!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"XMBindDeviceListCell" owner:self options:nil]lastObject];
    }
    // Configure the cell...
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.lock = self.dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [XMMethod runtimePush:@"XMDeviceBindViewController" dic:@{@"lock":self.dataArray[indexPath.row]}];
}

//标签数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setHidden:NO];
    [appDelegate.tabbar hideTabBar];
    
    [self request];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
