//
//  XMAccountViewController.m
//  lockPro
//
//  Created by 牛付威 on 2018/5/29.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "XMAccountViewController.h"
#import "XMAccountList.h"
#import "XMAccountHeaderView.h"
#import "XMSelectListViewController.h"


@interface XMAccountViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray * dataArray;
}

@property (nonatomic,strong) UITableView * tableView;
@end

@implementation XMAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    dataArray = @[@[@{@"title":@"",@"icon":@""},
                      @{@"title":@"分享权限",@"icon":@"share"},
                    @{@"title":@"解封记录",@"icon":@"recoder"},
                    @{@"title":@"设备绑定",@"icon":@"bind"},
                    @{@"title":@"我的设备",@"icon":@"device"},
                    ],
                  @[@{@"title":@"账户设置",@"icon":@"set"}]];
    
    self.tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, -20, kScreen_Width, kScreen_Height+20)];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = COLOR(245, 245, 245);
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setHidden:YES];
    [appDelegate.tabbar showTabBar];
    
    NSIndexSet * set = [NSIndexSet indexSetWithIndex:0];
    
    [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationAutomatic];

}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        if(indexPath.row==0){
            return 217;
        }
    }
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section==0){
        return 0;
    }
    return 15;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *v =[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 15)];
    return v;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [dataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[dataArray objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section ==0 && indexPath.row==0){
        XMAccountHeaderView *cell = [tableView dequeueReusableCellWithIdentifier:@"XMAccountHeaderView"];
        
        // Configure the cell...
        if(!cell){
            cell = [[[NSBundle mainBundle] loadNibNamed:@"XMAccountHeaderView" owner:self options:nil]lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        cell.nameLabel.text = [XMUserModel shareInstance].nickName;
        cell.namePhone.text = [XMUserModel shareInstance].account;
        return cell;
    }
    else{
        XMAccountList *cell = [tableView dequeueReusableCellWithIdentifier:@"XMAccountList"];
        
        // Configure the cell...
        if(!cell){
            cell = [[[NSBundle mainBundle] loadNibNamed:@"XMAccountList" owner:self options:nil]lastObject];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        cell.titleLabel.text = [[[dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"title"];
        [cell.icon setImage:[UIImage imageNamed:[[[dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"icon"]]];
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        
        //修改用户信息
        if(indexPath.row==0){
            [XMMethod runtimePush:@"XMInfomationViewController" dic:nil];
        }
        else if(indexPath.row==1){
            XMSelectListViewController * select = [[XMSelectListViewController alloc] init];
            select.pageType = FROM_ACCOUNT_LIS;
            [self.navigationController pushViewController:select animated:YES];
        }
        else if(indexPath.row ==2){
            XMSelectListViewController * select = [[XMSelectListViewController alloc] init];
            select.pageType = RECODER;
            [self.navigationController pushViewController:select animated:YES];
        }
        else if(indexPath.row ==3){
            [XMMethod runtimePush:@"XMBindDeviceListViewController" dic:nil];
        }
        else if(indexPath.row==4){
            [XMMethod runtimePush:@"XMMyDeviceListViewController" dic:nil];
        }
        
        
    }else{
        [XMMethod runtimePush:@"XMSetViewController" dic:nil];

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

@end
