//
//  XMSetViewController.m
//  lockPro
//
//  Created by 牛付威 on 2018/6/1.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "XMSetViewController.h"
#import "XMAccountList.h"
#import "XMSelectListViewController.h"
#import "XMSetHeader.h"


@interface XMSetViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    NSArray * dataArray;
}

@property (nonatomic,strong) UITableView * tableView;
@end

@implementation XMSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.title = @"账户设置";
    
    dataArray = @[@[@{@"title":@"",@"icon":@""},
                    @{@"title":@"修改密码",@"icon":@"share"},
                    @{@"title":@"关于软件",@"icon":@"recoder"},
                    @{@"title":@"操作设置",@"icon":@"bind"},
                    @{@"title":@"清除缓存",@"icon":@"device"},
                    ],
                  @[@{@"title":@"退出登录",@"icon":@"set"}]];
    
    self.tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
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
    
    [self.navigationController.navigationBar setHidden:NO];
    [appDelegate.tabbar hideTabBar];
}
#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        if(indexPath.row==0){
            return 197;
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
        XMSetHeader *cell = [tableView dequeueReusableCellWithIdentifier:@"XMSetHeader"];
        
        // Configure the cell...
        if(!cell){
            cell = [[[NSBundle mainBundle] loadNibNamed:@"XMSetHeader" owner:self options:nil]lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        
        // Configure the cell...
        if(!cell){
            cell = [[UITableViewCell alloc ] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textLabel.text = [[[dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"title"];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        
        if(indexPath.row==0&& indexPath.section==1){
            cell.textLabel.textColor = COLOR(253, 149, 167);
        }
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        
        //修改用户信息
        if(indexPath.row==1){
            [XMMethod runtimePush:@"XMModiftPasswordViewController" dic:nil];
        }
        else if(indexPath.row==2){
         
        }
        else if(indexPath.row ==3){
            [XMMethod runtimePush:@"XMCZSetViewController" dic:nil];
        }
        else if(indexPath.row ==4){
        }
     
        
    }else{
       
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"您确定要退出吗?" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alert show];
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex ==0){
        [self.navigationController popViewControllerAnimated:YES];
        [appDelegate logout];
    }
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
