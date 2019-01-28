//
//  XMShareInfoViewController.m
//  lockPro
//
//  Created by 牛付威 on 2018/5/31.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "XMRecoderShaixuanViewController.h"
#import "XMShareInfoCell.h"
#import "XMConfirmButtonCell.h"
#import "XMSelectDeviceListViewController.h"
#import "XMFriendListViewController.h"
#import "MOFSPickerManager.h"
#import "XMSingleLock.h"
#import "XMOprts.h"

@interface XMRecoderShaixuanViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,assign) BOOL isSelect;
@property (nonatomic,strong) XMOprts * oprts;

@end

@implementation XMRecoderShaixuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [[NSMutableArray alloc] init];
    [self.dataArray addObject:@{@"title":@"选择设备",@"content":@""}];
    [self.dataArray addObject:@{@"title":@"选择时间",@"content":@""}];
    
    self.title = self.container.cUid;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
    
    self.oprts = [[XMOprts alloc] init];
 

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
        cell = [[[NSBundle mainBundle] loadNibNamed:@"XMShareInfoCell" owner:self options:nil]lastObject];
    }
    // Configure the cell...
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLabel.text = [[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.contentLabel.text = [[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"content"];
    cell.accessoryType =UITableViewCellAccessoryDisclosureIndicator;//添加箭头

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
    
    [bottom.confirmButton setTitle:@"查看记录" forState:UIControlStateNormal];
    [bottom.confirmButton addTarget:self action:@selector(onCat:) forControlEvents:UIControlEventTouchUpInside];
    return bottom;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WeakSelf(weakSelf)
    XMShareInfoCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if(indexPath.row==0){
        
        //选择设备
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
            
            
            weakSelf.oprts.lockID =[stringModel stringByAppendingString:@"|"];
            
        } ;
        [self.navigationController pushViewController:selectDevice animated:YES];
        
    }
    else if(indexPath.row==1){
        //选择开始时间
        
        MOFSPickerManager * picker = [[MOFSPickerManager alloc] init];
        [picker showDatePickerNoHHWithTag:1 commitBlock:^(NSDate * _Nonnull date) {
            NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
            // 设置日期格式(为了转换成功)
            fmt.dateFormat = @"yyyy-MM-dd";
            
            // NSString * -> NSDate *
            
            cell.contentLabel.text = [fmt stringFromDate:date];
            weakSelf.oprts.oprtTime =[fmt stringFromDate:date];
        } cancelBlock:^{
            
        }];
        
    }
  
    
}

//标签数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(void)onCat:(id)sender{
    
    if(!self.oprts.lockID){
        [XMMethod alertErrorMessage:@"请选择设备"];
        return;
    }
    if(!self.oprts.oprtTime){
        [XMMethod alertErrorMessage:@"请选择时间"];
        return;
    }
    [XMMethod runtimePush:@"XMRecoderListViewController" dic:@{@"oprts":self.oprts,@"container":self.container}];

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
