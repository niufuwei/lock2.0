//
//  XMMyDeviceListViewController.m
//  lockPro
//
//  Created by 牛付威 on 2018/6/1.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "XMMyDeviceListViewController.h"
#import "XMMydeviceListCell.h"
#import "WMSearchBar.h"
#import "XMLockRelat.h"
#import "XMContainer.h"

@interface XMMyDeviceListViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,strong) NSMutableArray * dataCopyArray;

@end

@implementation XMMyDeviceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //导航条的搜索条
    WMSearchBar *searchBar = [[WMSearchBar alloc]initWithFrame:CGRectMake(10,10, self.view.frame.size.width-20,30.0f)];
    searchBar.delegate = self;
    [searchBar setPlaceholder:@"输入车牌号"];
    [searchBar setBackgroundColor:[UIColor clearColor]];
    
    UITextField *searchField = [searchBar valueForKey:@"_searchField"];
    searchField.backgroundColor = WHITECOLOR;
    searchField.layer.cornerRadius = 15;
    searchField.layer.masksToBounds = YES;
    
    //将搜索条放在一个UIView上
    UIView *searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    searchView.backgroundColor = [UIColor clearColor];
    [searchView addSubview:searchBar];
    
    [self.view addSubview:searchView];
    
    self.title = @"我的设备";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, kScreen_Width, kScreen_Height-50)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.backgroundColor = BGCOLOR;
    [self.view addSubview:self.tableView];
    
    
    self.dataArray = [[NSMutableArray alloc] init];
    
    // 下拉刷新
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.dataArray removeAllObjects];
        [self requestFriendList];
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
 
    // Do any additional setup after loading the view.
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    NSMutableArray * data = [[NSMutableArray alloc] init];
    self.dataArray = self.dataCopyArray;
    for(int i=0;i<self.dataArray.count;i++){
        
        XMLockRelat * LockRelat = self.dataArray[i];
        if([LockRelat.cUid isEqualToString:searchBar.text]){
            [data addObject:LockRelat];
            break;
        }
    }
    
    if([data count]==0){
        [XMMethod alertErrorMessage:@"没有搜到相关数据!"];
        return;
    }
    self.dataArray = data;
    [self.tableView reloadData];
    
    
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if([searchBar.text length]==0){
        [self.dataArray removeAllObjects];
        [self requestFriendList];
    }
}

-(void)requestFriendList{
    
    [XMDataManager myDeviceManager:@{@"UserID":[XMUserModel shareInstance].userID,@"gsID":[XMUserModel shareInstance].gsID} success:^(id result)
     {
         
         for(NSDictionary * dic in result[@"obj"][@"lsMyLock"]){
             XMLockRelat * lock = [[XMLockRelat alloc] initWithDictionary:dic error:nil];
             
             for(NSDictionary*lsCT in result[@"obj"][@"lsCT"]){
                 XMLockRelat * LockRelat = [[XMLockRelat alloc] initWithDictionary:lsCT error:nil];
                 
                 if([lock.containerID integerValue]==[LockRelat.containerID integerValue]){
                     lock.cUid = LockRelat.cUid;
                     lock.authoCnt = LockRelat.authoCnt;
                     break;
                 }
             }
             [self.dataArray addObject:lock];
             
         }
         self.dataCopyArray = self.dataArray;
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
    return 92;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMMydeviceListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XMMydeviceListCell" ];
    if(!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"XMMydeviceListCell" owner:self options:nil]lastObject];
    }
    // Configure the cell...
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.lockRelat = self.dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [XMMethod runtimePush:@"XMCheckLockViewController" dic:nil];
}

//标签数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setHidden:NO];
    [appDelegate.tabbar hideTabBar];
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
