//
//  XMSearchViewController.m
//  lockPro
//
//  Created by 牛付威 on 2018/5/28.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "XMSearchViewController.h"
#import "XMHomeListViewVell.h"
#import "XMHomeHeaderView.h"
#import "WMSearchBar.h"
#import "XMFriendListCell.h"
#import "XMAddFriendList.h"
#import "XMFriendModel.h"

@interface XMSearchViewController ()<NavCustomDelegate,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    XMNavCustom * nav;

}
@property (nonatomic,strong) NSMutableArray * rowDataArray;
@property (nonatomic,strong) NSMutableDictionary*selectSection;
@property (nonatomic,strong) UITableView*tableview;


@end

@implementation XMSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
 
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableview];
    [appDelegate.tabbar hideTabBar];

  
    
    
    self.selectSection = [[NSMutableDictionary alloc] init];
    
//    nav = [[XMNavCustom alloc] init];
//    nav.NavDelegate =self;
//    [nav setNavRightBtnTitle:@"取消" mySelf:self width:30 height:20];
    
    //创建右边按钮
    UIButton *rightBackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    rightBackBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBackBtn setTitle:@"取消" forState:UIControlStateNormal];
    [rightBackBtn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
    [rightBackBtn addTarget:self action:@selector(NavRightButtononClick) forControlEvents:UIControlEventTouchUpInside];
    
    //添加进BARBUTTONITEM
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBackBtn];
    
    //右按钮
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    //导航条的搜索条
    WMSearchBar *searchBar = [[WMSearchBar alloc]initWithFrame:CGRectMake(-30,5.f, self.view.frame.size.width-70,30.0f)];
    searchBar.delegate = self;
    [searchBar setPlaceholder:@"搜索"];
    [searchBar setBackgroundColor:[UIColor clearColor]];
    
    UITextField *searchField = [searchBar valueForKey:@"_searchField"];
    searchField.backgroundColor = UIColorFromRGB(0xf0f0f0);
    searchField.layer.cornerRadius = 15;
    searchField.layer.masksToBounds = YES;

    //将搜索条放在一个UIView上
    UIView *searchView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-100, 44)];
    searchView.backgroundColor = [UIColor whiteColor];
    [searchView addSubview:searchBar];
    
    self.navigationItem.titleView = searchView;

}

-(void)NavRightButtononClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [XMDataManager searchFriendManager:@{@"account":searchBar.text} success:^(id result)
    {
        self.rowDataArray = [[NSMutableArray alloc] init];

        XMFriendModel * model = [[XMFriendModel alloc] initWithDictionary:result[@"obj"] error:nil];
        [self.rowDataArray addObject:model];
        
        [self.tableview reloadData];
        
    } err:^(NSError *error) {

        
    }];
}

/**
 *  生成图片
 *
 *  @param color  图片颜色
 *  @param height 图片高度
 *
 *  @return 生成的图片
 */
- (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}


-(void)viewWillAppear:(BOOL)animated{
//    UIImage *bgImage = [[UIImage imageNamed:@"navWhiteBG"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
//    [[UINavigationBar appearance] setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
    
    
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
    self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
    
    [self.navigationController.navigationBar setBackgroundImage:
     [UIImage imageNamed:@"navWhiteBG"] forBarMetrics:UIBarMetricsDefault];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.type==SEARCH_FRIEND){
        return [self.rowDataArray count];
    }
  
    
    if(self.type==SEARCH_ADD_FRIEND){
        return [self.rowDataArray count];;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.type==SEARCH_FRIEND){
        return 70;
    }
    
    if(self.type==SEARCH_ADD_FRIEND){
        return 267;
    }
   
    return 61;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(self.type==SEARCH_FRIEND){
        return 0;
    }
   
    if(self.type==SEARCH_ADD_FRIEND){
        return 0;
    }
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
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//
    if(self.type==SEARCH_FRIEND){
        XMFriendListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XMFriendListCell" ];
        if(!cell){
            cell= [[[NSBundle mainBundle] loadNibNamed:@"XMFriendListCell" owner:self options:nil]lastObject];
        }
        // Configure the cell...
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.rowDataArray[indexPath.row];
        return cell;
    }
    else  if(self.type==SEARCH_ADD_FRIEND){
        XMAddFriendList *cell = [tableView dequeueReusableCellWithIdentifier:@"XMAddFriendList" ];
        if(!cell){
            cell= [[[NSBundle mainBundle] loadNibNamed:@"XMAddFriendList" owner:self options:nil]lastObject];
        }
        cell.model = self.rowDataArray[indexPath.row];
        cell.addFriend.tag = indexPath.row+1;
        [cell.addFriend addTarget:self action:@selector(onAddFriend:) forControlEvents:UIControlEventTouchUpInside];

        // Configure the cell...
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
    }
   
    else {
        return nil;
        
    }
}

-(void)onSectionButtonClick:(UIButton*)btn{
    if([self.selectSection valueForKey:[NSString stringWithFormat:@"%ld",btn.tag]]){
        [self.selectSection removeObjectForKey:[NSString stringWithFormat:@"%ld",btn.tag]];
    }else{
        [self.selectSection setValue:@1 forKey:[NSString stringWithFormat:@"%ld",btn.tag]];
    }
    
    [self.tableview reloadData];
    
}


-(void)onAddFriend:(UIButton*)sender{
    
    XMFriendModel * model = [self.rowDataArray objectAtIndex:sender.tag-1];
    [XMDataManager addFriendManager:model success:^(id result) {
        
        [XMMethod alertErrorMessage:result[@"msg"]];
        [sender setTitle:@"已添加为好友" forState:UIControlStateNormal];
        [sender setBackgroundColor:LIGHTGRAY];
        sender.enabled = NO;
        
    } err:^(NSError *error) {
        
    }];
}

@end
