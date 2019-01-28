//
//  XMShareInfoViewController.m
//  lockPro
//
//  Created by 牛付威 on 2018/5/31.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "XMShareInfoViewController.h"
#import "XMShareInfoCell.h"
#import "XMConfirmButtonCell.h"
#import "XMSelectDeviceListViewController.h"
#import "XMFriendListViewController.h"
#import "MOFSPickerManager.h"
#import "XMFriendModel.h"
#import "XMSingleLock.h"
#import "XMShareSave.h"
@interface XMShareInfoViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,assign) BOOL isSelect;
@property (nonatomic,strong) XMShareSave * shareSave;

@end

@implementation XMShareInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [[NSMutableArray alloc] init];
    [self.dataArray addObject:@{@"title":@"选择设备",@"content":@""}];
    [self.dataArray addObject:@{@"title":@"选择好友",@"content":@""}];
    [self.dataArray addObject:@{@"title":@"开始时间",@"content":@""}];
    [self.dataArray addObject:@{@"title":@"结束时间",@"content":@""}];
    [self.dataArray addObject:@{@"title":@"地理范围",@"content":@""}];
    [self.dataArray addObject:@{@"title":@"无限操作",@"content":@""}];
    
    self.title = @"设备名字";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
    
    self.shareSave = [[XMShareSave alloc] init];

    self.isSelect = false;
    
    self.shareSave.timesOfOprt =@"1";

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
        if([self.dataArray count]-1==indexPath.row){
            cell = [[[NSBundle mainBundle] loadNibNamed:@"XMShareInfoSegmentCell" owner:self options:nil]lastObject];

        }else{
            cell = [[[NSBundle mainBundle] loadNibNamed:@"XMShareInfoCell" owner:self options:nil]lastObject];
            cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;//添加箭头

        }
    }
    // Configure the cell...
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLabel.text = [[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.contentLabel.text = [[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"content"];

    [cell.segment addTarget:self action:@selector(onSegment:) forControlEvents:UIControlEventTouchUpInside];
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
    
    [bottom.confirmButton setTitle:@"确定分享" forState:UIControlStateNormal];
    [bottom.confirmButton addTarget:self action:@selector(onConfirm:) forControlEvents:UIControlEventTouchUpInside];
    return bottom;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    XMShareInfoCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    WeakSelf(weakSelf)
    if(indexPath.row==0){
        
        //选择设备
        XMSelectDeviceListViewController * selectDevice = [[XMSelectDeviceListViewController alloc] init];
        selectDevice.container = self.container;
        selectDevice.backResult = ^(id result) {
            
            NSString * string =@"";
            NSString * stringModel =@"";

            for(XMSingleLock * lock in result){
               string = [string stringByAppendingFormat:@"%@/",lock.pos];
                stringModel = [stringModel stringByAppendingFormat:@"|%@",lock.lockID];
            }
            cell.contentLabel.text = [string stringByReplacingCharactersInRange:NSMakeRange(string.length-1, 1) withString:@""];

            
            weakSelf.shareSave.locksID =[stringModel stringByAppendingString:@"|"];
            
        } ;
        [self.navigationController pushViewController:selectDevice animated:YES];
        
    }else if(indexPath.row==1){
        
        //选择好友
        XMFriendListViewController * friend = [[XMFriendListViewController alloc] init];
        friend.friendPageType = SELECT_FRIEND;
        friend.blockBack = ^(XMFriendModel * Result) {
            cell.contentLabel.text = Result.nickName;
            
           weakSelf.shareSave.pasID =Result.userID ;
            weakSelf.shareSave.posID = [XMUserModel shareInstance].userID;
            weakSelf.shareSave.authoType = @"03";
            weakSelf.shareSave.containerID = self.container.containerID;
            
        } ;
        [self.navigationController pushViewController:friend animated:YES];
        
    }
    else if(indexPath.row==2){
        //选择开始时间
        
        MOFSPickerManager * picker = [[MOFSPickerManager alloc] init];
        [picker showDatePickerWithTag:1 commitBlock:^(NSDate * _Nonnull date) {
            // 日期格式化类
            NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
            // 设置日期格式(为了转换成功)
            fmt.dateFormat = @"yyyy-MM-dd HH:mm";
            
            // NSString * -> NSDate *
            
            cell.contentLabel.text = [fmt stringFromDate:date];

            weakSelf.shareSave.authoStTime =[fmt stringFromDate:date];
        } cancelBlock:^{
            
        }];
        
    }
    else if(indexPath.row==3){
        //选择结束时间
        MOFSPickerManager * picker = [[MOFSPickerManager alloc] init];
        [picker showDatePickerWithTag:1 commitBlock:^(NSDate * _Nonnull date) {
            NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
            // 设置日期格式(为了转换成功)
            fmt.dateFormat = @"yyyy-MM-dd HH:mm";
            
            // NSString * -> NSDate *
            
            cell.contentLabel.text = [fmt stringFromDate:date];
            weakSelf.shareSave.authoSpTime =[fmt stringFromDate:date];

        } cancelBlock:^{
            
        }];
    }
    else if(indexPath.row==4){
        //地理范围
        
    }
    
}

-(void)onSegment:(UIButton*)btn{
    self.isSelect = !self.isSelect;
    
    if(self.isSelect){
        [btn setImage:[UIImage imageNamed:@"wxcz_icon"] forState:UIControlStateNormal];
    }else{
        [btn setImage:[UIImage imageNamed:@"once_icon"] forState:UIControlStateNormal];
    }
    
    self.shareSave.timesOfOprt =self.isSelect?@"-1":@"1";

}

-(void)onConfirm:(id)sender{

    if(!self.shareSave.locksID ||
       !self.shareSave.pasID||
       !self.shareSave.authoType||
       !self.shareSave.containerID||
       !self.shareSave.authoStTime||
       !self.shareSave.authoSpTime
       ){
        [XMMethod alertErrorMessage:@"请选择完整"];
        return;
    }
    [XMDataManager confirmShareManager:self.shareSave success:^(id result) {
        [XMMethod alertErrorMessage:result[@"msg"]];
        [self.navigationController popViewControllerAnimated:YES];
    } err:^(NSError *error) {
        
    }];
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
