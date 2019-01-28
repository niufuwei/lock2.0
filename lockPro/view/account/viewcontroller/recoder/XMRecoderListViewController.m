//
//  XMRecoderListViewController.m
//  lockPro
//
//  Created by 牛付威 on 2018/6/1.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "XMRecoderListViewController.h"
#import "XMRecoderListCell.h"
#import "XMConfirmButtonCell.h"
#import "XMRecoderShaixuanViewController.h"
@interface XMRecoderListViewController ()<UITableViewDataSource,UITableViewDelegate,NavCustomDelegate>
{
    XMNavCustom * nav;
    __block NSInteger indxPg;

}
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataArray;

@end

@implementation XMRecoderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = self.container.cUid;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];

    
    nav = [[XMNavCustom alloc] init];
    nav.NavDelegate = self;
    [nav setNavRightBtnImage:@"recoder_address" RightBtnSelectedImage:@"recoder_address" mySelf:self width:20 height:20];
    self.dataArray = [[NSMutableArray alloc] init];
    
    indxPg = 1;
    
    // 下拉刷新
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.dataArray removeAllObjects];
        indxPg = 1;
        [self request];
    }];
    
    // 上拉刷新
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        indxPg++;
        [self request];
        
    }];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    // Do any additional setup after loading the view.
}

-(void)request{
    
    [XMDataManager catRecoderManager:@{@"stTime":[NSString stringWithFormat:@"%@ 00:00",self.oprts.oprtTime],
                                       @"spTime":[NSString stringWithFormat:@"%@ 23:59",self.oprts.oprtTime],
                                       @"indxPg":[NSString stringWithFormat:@"%ld",indxPg],
                                       @"lockIDs":self.oprts.lockID,
                                       @"containerID":self.container.containerID
                                       } success:^(id result) {
                                           
                                           for(NSDictionary * dic in result[@"obj"][@"lsObj"]){
                                               XMOprts * opers = [[XMOprts alloc] initWithDictionary:dic error:nil];
                                               [self.dataArray addObject:opers];
                                           }
                                           
                                           
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
    [XMMethod runtimePush:@"XMRecoderMapView" dic:@{@"dataArray":self.dataArray,@"container":self.container}];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 129;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMRecoderListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XMRecoderListCell" ];
    if(!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"XMRecoderListCell" owner:self options:nil]lastObject];
    }
    // Configure the cell...
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.opers = self.dataArray[indexPath.row];
    return cell;
}

//标签数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
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
