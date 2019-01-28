//
//  XMShareInfoViewController.m
//  lockPro
//
//  Created by 牛付威 on 2018/5/31.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "XMDeviceBindViewController.h"
#import "XMShareInfoCell.h"
#import "XMConfirmButtonCell.h"
#import "XMSelectListViewController.h"
#import "XMSelectPositionViewController.h"
#import "XMContainer.h"

@interface XMDeviceBindViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,assign) BOOL isSelect;

@end

@implementation XMDeviceBindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [[NSMutableArray alloc] init];
    [self.dataArray addObject:@{@"title":@"铅封编号",@"content":self.lock.SN}];
    [self.dataArray addObject:@{@"title":@"MAC地址",@"content":self.lock.macAddr}];
    [self.dataArray addObject:@{@"title":@"选择车辆",@"content":@""}];
    [self.dataArray addObject:@{@"title":@"选择位置",@"content":@""}];
    [self.dataArray addObject:@{@"title":@"设备名称",@"content":@""}];

    self.title = @"设备绑定";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.backgroundColor = BGCOLOR;

    [self.view addSubview:self.tableView];
    
    self.isSelect = false;
    // Do any additional setup after loading the view.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 52;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMShareInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XMShareInfoCell" ];
    if(!cell){
        if(indexPath.row ==4){
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"XMShareInfoTextFieldCell" owner:self options:nil]lastObject];

        }else{
            cell = [[[NSBundle mainBundle] loadNibNamed:@"XMShareInfoCell" owner:self options:nil]lastObject];

        }
    }
    // Configure the cell...
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLabel.text = [[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.contentLabel.text = [[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"content"];
    cell.textField.placeholder = @"请输入铅封名称";
    if(indexPath.row==2 || indexPath.row==3){
        cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;//添加箭头
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 78;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    XMConfirmButtonCell * bottom = [tableView dequeueReusableCellWithIdentifier:@"XMConfirmButtonCell"];
    if(!bottom)
    {
        bottom = [[[NSBundle mainBundle] loadNibNamed:@"XMConfirmButtonCell" owner:self options:nil]lastObject];
    }
    
    [bottom.confirmButton setTitle:@"确定绑定" forState:UIControlStateNormal];
    [bottom.confirmButton addTarget:self action:@selector(onBind:) forControlEvents:UIControlEventTouchUpInside];
    return bottom;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    XMShareInfoCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
    XMShareInfoCell * cell2 = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];

    WeakSelf(weakSelf)
    
    if(indexPath.row==2){
        
        
        //选择车辆
        XMSelectListViewController * select = [[XMSelectListViewController alloc] init];
        select.pageType = BIND_DEVICE;
        [select getBackResult:^(XMContainer * result) {
            cell.contentLabel.text = result.cUid;
            weakSelf.lock.cUid = result.cUid;
            weakSelf.lock.containerID = result.containerID;
         
            if([self.lock.cUid length]!=0 && [self.lock.pos length]!=0){
                
                cell2.textField.text =[NSString stringWithFormat:@"%@%@",self.lock.cUid,self.lock.pos];
            }
        }];
        [self.navigationController pushViewController:select animated:YES];
        
    }
    else if(indexPath.row==3){
        //选择位置

        XMSelectPositionViewController * select = [[XMSelectPositionViewController alloc] init];
        select.lock = self.lock;
        [select getBackResult:^(id result) {
            
            
            cell.contentLabel.text = result[@"title"];
            weakSelf.lock.pos = result[@"title"];

            if([self.lock.cUid length]!=0 && [self.lock.pos length]!=0){
                
                cell2.textField.text =[NSString stringWithFormat:@"%@%@",self.lock.cUid,self.lock.pos];
            }
        }];
        [self.navigationController pushViewController:select animated:YES];
        
    }
   
  
    
}

//标签数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(void)onBind:(id)sender{
    XMShareInfoCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];

    [XMDataManager editBindDevicePosManager:@{@"lockID":self.lock.lockID,
                                              @"lockName":cell.textField.text,
                                              @"hostID":[XMUserModel shareInstance].userID,
                                              @"containerID":self.lock.containerID,
                                              @"pos":self.lock.pos,
                                              @"entID":[XMUserModel shareInstance].entID
                                              } success:^(id result) {
        
                                             
                                                  [XMMethod alertErrorMessage:result[@"msg"]];
                                                  [self.navigationController popViewControllerAnimated:YES];
                                                  
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
