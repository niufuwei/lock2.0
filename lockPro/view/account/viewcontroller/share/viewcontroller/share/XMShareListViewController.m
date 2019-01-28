//
//  XMShareListViewController.m
//  lockPro
//
//  Created by 牛付威 on 2018/5/31.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "XMShareListViewController.h"
#import "WMSearchBar.h"
#import "XMShareListCell.h"
#import "XMSelectListViewController.h"
#import "XMShareModel.h"

@interface XMShareListViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,NavCustomDelegate>
{
    XMNavCustom * nav;
   __block  NSInteger indxPg;
}
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataArray;

@end

@implementation XMShareListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //导航条的搜索条
    WMSearchBar *searchBar = [[WMSearchBar alloc]initWithFrame:CGRectMake(10,10, self.view.frame.size.width-20,30.0f)];
    searchBar.delegate = self;
    [searchBar setPlaceholder:@"输入设备名称或分享用户昵称"];
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
    
    //    self.navigationItem.titleView = searchView;
    
    
    self.title = self.container.cName;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, kScreen_Width, kScreen_Height-50-20)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = BGCOLOR;
    [self.view addSubview:self.tableView];
    
    nav = [[XMNavCustom alloc] init];
    nav.NavDelegate = self;
    [nav setNavRightBtnImage:@"addIcon" RightBtnSelectedImage:@"addIcon" mySelf:self width:20 height:20];
    
    self.dataArray = [[NSMutableArray alloc] init];
    indxPg = 0;
    
    // 下拉刷新
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.dataArray removeAllObjects];
        indxPg = 0;
        [self request];
    }];
    
//    // 上拉刷新
//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//
//        indxPg++;
//        [self request];
//
//    }];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
  
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tableView.mj_header beginRefreshing];

}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self request];
}


-(void)request{
    [XMDataManager shareListManager:@{@"containerID":self.container.containerID,@"indxPg":[NSString stringWithFormat:@"%ld",indxPg]} success:^(id result) {
        
        NSArray * arr = result[@"obj"][@"lsObj"];
        for(NSDictionary * dic in arr){
            XMShareModel * model = [[XMShareModel alloc] initWithDictionary:dic error:nil];
            [self.dataArray addObject:model];
        }
        //
        
        if(indxPg == [result[@"obj"][@"totPg"] integerValue]){
            dispatch_async(dispatch_get_main_queue(), ^{
                self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
            });
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } err:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

-(void)NavRightButtononClick{
//    XMSelectListViewController * select = [[XMSelectListViewController alloc] init];
//    select.pageType = ADD_SHARE_SELECT_CAR;
//
//    [self.navigationController pushViewController:select animated:YES];
    
    [XMMethod runtimePush:@"XMShareInfoViewController" dic:@{@"container":self.container}];

}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 171;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMShareListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XMShareListCell" ];
    if(!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"XMShareListCell" owner:self options:nil]lastObject];
    }
    // Configure the cell...
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.shareModel = self.dataArray[indexPath.row];
    return cell;
}

//标签数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 从数据源中删除
    //...
    //    [self.sectionName removeObjectAtIndex:indexPath.row];
    // 从列表中删除
    //    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    XMShareModel * shareModel = [self.dataArray objectAtIndex:indexPath.row];
    [XMDataManager deleteShareManager:@{@"authoID":shareModel.authoID,
                                        @"locksID":shareModel.locksID,
                                        @"containerID":shareModel.containerID
                                        } success:^(id result) {
        
      
        [self.dataArray removeObject:shareModel];
        [self.tableView reloadData];
        
    } err:^(NSError *error) {
        
    }];
    
    
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
