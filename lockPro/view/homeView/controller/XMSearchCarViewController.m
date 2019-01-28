//
//  XMSearchViewController.m
//  lockPro
//
//  Created by 牛付威 on 2018/5/28.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "XMSearchCarViewController.h"
#import "XMHomeListViewVell.h"
#import "XMHomeHeaderView.h"
#import "WMSearchBar.h"
#import "XMDevice.h"

@interface XMSearchCarViewController ()<NavCustomDelegate,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    XMNavCustom * nav;

}
@property (nonatomic,strong) NSMutableArray * sectionDataArray;
@property (nonatomic,strong) NSMutableDictionary*selectSection;
@property (nonatomic,strong) UITableView*tableview;


@end

@implementation XMSearchCarViewController

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

  
    self.sectionDataArray = [[NSMutableArray alloc] init];
    
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
    
    [self.sectionDataArray removeAllObjects];
    [searchBar resignFirstResponder];
    for(int i=0;i<self.carArray.count;i++){
        
        XMDevice * device = self.carArray[i];
        if([device.lsCT.cUid rangeOfString:searchBar.text].location!=NSNotFound){
            [self.sectionDataArray addObject:device];
        }
    }
    
    if([self.sectionDataArray count]==0){
        [XMMethod alertErrorMessage:@"没有搜到相关数据!"];
        return;
    }
    [self.tableview reloadData];
    
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
  
    return self.sectionDataArray.count;
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
        }else if([relat.lockStat integerValue]==0 || [relat.lockStat integerValue]==3){
            normalNumber++;
        }
    }
    
    headerView.openNumber.text = [NSString stringWithFormat:@"%ld",openNumber];
    headerView.closeNumber.text = [NSString stringWithFormat:@"%ld",closeNumber];
    headerView.normalNumber.text =[NSString stringWithFormat:@"%ld",normalNumber];
    
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//
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
    
    dispatch_async(dispatch_get_main_queue(), ^{
        CGRect proGressWidth = cell.progress.frame;
        proGressWidth.size.width = [relat.elec floatValue]/100.0*15;
        cell.progress.frame = proGressWidth;
    });
    
    
    [cell.statusImage setImage:[UIImage imageNamed:[XMInstanceDataCheck checkLockStatus:relat.lockStat]]];
    cell.name.text = [NSString stringWithFormat:@"铅封锁编号#%@",relat.SN];
    cell.pos.text = relat.pos;
    return cell;
}

-(void)onSectionButtonClick:(UIButton*)btn{
    if([self.selectSection valueForKey:[NSString stringWithFormat:@"%ld",btn.tag]]){
        [self.selectSection removeObjectForKey:[NSString stringWithFormat:@"%ld",btn.tag]];
    }else{
        [self.selectSection setValue:@1 forKey:[NSString stringWithFormat:@"%ld",btn.tag]];
    }
    
    [self.tableview reloadData];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [XMMethod runtimePush:@"XMCarInfoViewController" dic:nil];
}
@end
