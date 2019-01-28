//
//  XMFriendListViewController.m
//  lockPro
//
//  Created by 牛付威 on 2018/5/28.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "XMFriendListViewController.h"
#import "XMFriendListCell.h"
#import "WMSearchBar.h"
#import "XMSearchViewController.h"

@interface XMFriendListViewController ()<NavCustomDelegate,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>{
   
    XMNavCustom * nav;
    __block NSInteger indexPage;
}
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * rowDataArray;
@property (nonatomic,strong) NSMutableArray * itemArray;

@end

@implementation XMFriendListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    
    //导航条的搜索条
    WMSearchBar *searchBar = [[WMSearchBar alloc]initWithFrame:CGRectMake(10,10, self.view.frame.size.width-20,30.0f)];
    searchBar.delegate = self;
    [searchBar setPlaceholder:@"搜索"];
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
    
    
    self.title = @"好友";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, kScreen_Width, kScreen_Height-49-50)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionIndexColor = [UIColor lightGrayColor];
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
    
    self.rowDataArray = [[NSMutableArray alloc] init];
    self.itemArray = [[NSMutableArray alloc] init];
    
    nav = [[XMNavCustom alloc] init];
    nav.NavDelegate = self;
    [nav setNavRightBtnImage:@"addIcon" RightBtnSelectedImage:@"addIcon" mySelf:self width:20 height:20];
    [nav setNavLeftBtnImage:@"" LeftBtnSelectedImage:@"" mySelf:self width:0 height:0];
    indexPage =0;

    // 下拉刷新
    self.tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        indexPage =0;
        [self.itemArray removeAllObjects];
        [self.rowDataArray removeAllObjects];
        [self requestFriendList];
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    self.tableView.mj_footer.automaticallyChangeAlpha = YES;
    
    // 上拉刷新
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        indexPage++;
        [self requestFriendList];

    }];
    
    [self.tableView.mj_header beginRefreshing];
    
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [XMDataManager searchFriendManager:@{@"account":searchBar.text} success:^(id result)
     {
         [self.rowDataArray removeAllObjects];
         [self.itemArray removeAllObjects];
         
         NSMutableDictionary * tempDic = [[NSMutableDictionary alloc] initWithDictionary:result[@"obj"]];
         [tempDic setObject:[self firstCharactor:result[@"obj"][@"nickName"]] forKey:@"key"];//拼音首字符
         XMFriendModel * model = [[XMFriendModel alloc] initWithDictionary:tempDic error:nil];
         [self.rowDataArray addObject:model];
         [self sortWifiList];
         
         
     } err:^(NSError *error) {
         
         
     }];
}

-(void)setBlockBack:(void (^)(XMFriendModel *))blockBack{
    _blockBack =  blockBack;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if([searchBar.text length]==0)
    {
        indexPage =0;
        [self.rowDataArray removeAllObjects];
        [self.itemArray removeAllObjects];
        [self requestFriendList];
    }
}

//- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
//    XMSearchViewController * search = [[XMSearchViewController alloc] init];
//    search.type = SEARCH_FRIEND;
//    [self.navigationController pushViewController:search  animated:YES];
//    return NO;
//}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if(self.friendPageType == SELECT_FRIEND){
        [appDelegate.tabbar hideTabBar];
        self.tableView.frame = CGRectMake(0, 44, kScreen_Width, kScreen_Height-44);

        [nav setNavLeftBtnImage:@"backWhite" LeftBtnSelectedImage:@"" mySelf:self width:0 height:0];

    }else{

        [appDelegate.tabbar showTabBar];
    }

    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navBG"] forBarMetrics:UIBarMetricsDefault];
    //
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
    
    //隐藏黑线
    
    //    [self.navigationController.navigationBar setBackgroundImage:
    //     bgImage forBarMetrics:UIBarMetricsDefault];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

}

-(void)requestFriendList{

    [XMDataManager myFriendListManager:@{@"indxPg":[NSString stringWithFormat:@"%ld",indexPage]} success:^(id result)
    {
        
        for(NSDictionary * dic in result[@"obj"][@"lsObj"]){
            NSMutableDictionary * tempDic = [[NSMutableDictionary alloc] initWithDictionary:dic];
            [tempDic setObject:[self firstCharactor:dic[@"nickName"]] forKey:@"key"];//拼音首字符
            XMFriendModel * model = [[XMFriendModel alloc] initWithDictionary:tempDic error:nil];
            [self.rowDataArray addObject:model];
            
        }
        
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        
        if([result[@"obj"][@"totPg"] integerValue] == indexPage){
            dispatch_async(dispatch_get_main_queue(), ^{
                self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
            });
        }
        else{
            self.tableView.mj_footer.state = MJRefreshStateIdle;
        }
        
        [self sortWifiList];

    } err:^(NSError *error) {
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
    }];
}

-(void)viewDidAppear:(BOOL)animated{

}
-(void)NavRightButtononClick{
    XMSearchViewController * search = [[XMSearchViewController alloc] init];
    search.type = SEARCH_ADD_FRIEND;
    [self.navigationController pushViewController:search  animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.rowDataArray objectAtIndex:section] count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMFriendListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XMFriendListCell" ];
    if(!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"XMFriendListCell" owner:self options:nil]lastObject];
    }
    
    cell.model = [[self.rowDataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    // Configure the cell...
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}
//右边索引 字节数(如果不实现 就不显示右侧索引)
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.itemArray;
}

//section （标签）标题显示
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return self.itemArray[section];
//    XMFriendModel * model = [self.sectionName objectAtIndex:section][0];
}

//标签数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.itemArray.count;
}

// 设置section的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
//点击右侧索引表项时调用
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    
    XMFriendModel * model = [self.rowDataArray objectAtIndex:index][0];
    
    NSString *key = model.key;
    NSLog(@"sectionForSectionIndexTitle key=%@",key);
    if (key == UITableViewIndexSearch) {
        [self.tableView setContentOffset:CGPointZero animated:NO];
        return NSNotFound;
    }
    return index;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0,kScreen_Width, 30)];
    view.backgroundColor = UIColorFromRGB(0xf0f0f0);
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 70, 30)];
    title.text =self.itemArray[section];
    title.textColor=LIGHTGRAY;
    title.font = [UIFont systemFontOfSize:15];
    title.textAlignment= NSTextAlignmentLeft;
    [view addSubview:title];
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.friendPageType == SELECT_FRIEND){
        _blockBack([[self.rowDataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.friendPageType == TABBAR_LIST){
        return YES;
    }
    return NO;
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
    XMFriendModel * model = [[self.rowDataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    [XMDataManager removeFriendListManager:@{@"userID":model.userID} success:^(id result)
    {
        NSMutableArray * tempSectionArr = [[NSMutableArray alloc] init];
        NSMutableArray * tempRowArr = [[NSMutableArray alloc] init];

        for(NSInteger i =0;i<[self.rowDataArray count];i++){
            for(NSInteger j =0;j<[self.rowDataArray[i] count];j++){
                if(i==indexPath.section&&j==indexPath.row){
                    
                }else{
                    [ tempRowArr addObject: self.rowDataArray[i][j] ];
                }
            }
            [tempSectionArr addObject:tempRowArr];
        }
        
        if([self.rowDataArray[indexPath.section]count]==1){
            [self.itemArray removeObjectAtIndex:indexPath.section];
        }
        [self.rowDataArray removeAllObjects];
        self.rowDataArray = tempSectionArr;
        
        [self.tableView reloadData];
        
    } err:^(NSError *error) {
        
    }];
    
    
}
#pragma mark -

#pragma 获取字符串的首字符

- (NSString *)firstCharactor:(NSString *)aString

{
    
    //转成了可变字符串
    
    NSMutableString *str = [NSMutableString stringWithString:aString];
    
    //先转换为带声调的拼音
    
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    
    //再转换为不带声调的拼音
    
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    
    //转化为大写拼音
    
    NSString *pinYin = [str capitalizedString];
    
    //获取并返回首字母
    
    return [pinYin substringToIndex:1];
    
}


- (void)sortWifiList {
    
    NSArray *resultArray = [self.rowDataArray sortedArrayUsingFunction:compare context:NULL];
    
    [self.rowDataArray removeAllObjects];
    [self.itemArray removeAllObjects];
//    [self.rowDataArray addObjectsFromArray:resultArray];
    
    NSMutableArray * tempArr = [[NSMutableArray alloc] init];
    for(NSInteger i = 0;i< [resultArray count];i++){
        
        XMFriendModel *model  =resultArray[i];
        XMFriendModel * nextModel ;
        if(i==[resultArray count]-1){
            nextModel = [[XMFriendModel alloc] init];
        }else{
            nextModel = resultArray[i+1];
        }
        [self.itemArray addObject:model.key];

        if([model.key isEqualToString:nextModel.key]){
            [tempArr addObject:model];
            [self.itemArray removeLastObject];
        }
        if(![model.key isEqualToString:nextModel.key]){
            [tempArr addObject:model];
            [self.rowDataArray addObject:tempArr];
            tempArr = [[NSMutableArray alloc] init];
        }
    }
    
    [self.tableView reloadData];
    
}



NSComparisonResult compare( XMFriendModel*firstDict, XMFriendModel *secondDict, void *context) {
    
    if ([firstDict.key characterAtIndex:0] < [secondDict.key characterAtIndex:0])
        
        return NSOrderedAscending;
    
    else if ([firstDict.key  characterAtIndex:0] > [secondDict.key characterAtIndex:0])
        
        return NSOrderedDescending;
    
    else
        
        return NSOrderedSame;
    
}


@end
