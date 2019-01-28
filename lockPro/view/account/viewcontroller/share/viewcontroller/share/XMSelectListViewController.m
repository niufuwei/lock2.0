//
//  XMSelectListViewController.m
//  lockPro
//
//  Created by 牛付威 on 2018/5/31.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "XMSelectListViewController.h"
#import "WMSearchBar.h"
#import "XMSelectListCell.h"
#import "XMContainer.h"
@interface XMSelectListViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataArray;
@end

@implementation XMSelectListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    //    self.navigationItem.titleView = searchView;
    
    
    self.title = @"选择车辆";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
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

    [XMDataManager myCarListManager:@{@"userID":[XMUserModel shareInstance].userID,@"mStr":@"1=1"} success:^(id result) {
        for(int i=0;i<[result[@"obj"][@"lsObj"] count];i++){
            NSDictionary * dic = result[@"obj"][@"lsObj"][i];
            XMContainer * con = [[XMContainer alloc] initWithDictionary:dic error:nil];
            [self.dataArray addObject:con];
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
        
    } err:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];

    }];
}

-(void)getBackResult:(blockResult)result{
    self.backResult = result;
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 66;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMSelectListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XMSelectListCell" ];
    if(!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"XMSelectListCell" owner:self options:nil]lastObject];
    }
    // Configure the cell...
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.container = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}

//标签数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(self.pageType == FROM_ACCOUNT_LIS){
        [XMMethod runtimePush:@"XMShareListViewController" dic:@{@"container":[self.dataArray objectAtIndex:indexPath.row]} ];
    }
    else if(self.pageType == ADD_SHARE_SELECT_CAR){
        [XMMethod runtimePush:@"XMShareInfoViewController" dic:@{@"container":[self.dataArray objectAtIndex:indexPath.row]}];

    }else if(self.pageType == RECODER){
        
        [XMMethod runtimePush:@"XMRecoderShaixuanViewController" dic:@{@"container":[self.dataArray objectAtIndex:indexPath.row]}];

    }else if(self.pageType == BIND_DEVICE){
        
        self.backResult([self.dataArray objectAtIndex:indexPath.row]);
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self.navigationController.navigationBar setHidden:NO];
    [appDelegate.tabbar hideTabBar];
    [self.tableView.mj_header beginRefreshing];

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
