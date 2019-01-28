//
//  XMSelectDeviceListViewController.m
//  lockPro
//
//  Created by 牛付威 on 2018/5/31.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "XMSelectDeviceListViewController.h"
#import "XMSelectDeviceCell.h"
#import "XMConfirmButtonCell.h"
#import "XMSingleLock.h"

@interface XMSelectDeviceListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,strong) NSMutableDictionary * selectDic;

@end

@implementation XMSelectDeviceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"选择设备";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableView];
    
    
    
    self.selectDic = [[NSMutableDictionary alloc] init];
    self.dataArray = [[NSMutableArray alloc] init];
    
    [XMDataManager getCarsAllDeviceManager:@{@"containerID":self.container.containerID} success:^(id result) {
        
        for(NSDictionary * dic in result[@"obj"][@"lsObj"])
        {
            XMSingleLock * lock = [[XMSingleLock alloc] initWithDictionary:dic error:nil];
            [self.dataArray addObject:lock];
        }
        
        [self.tableView reloadData];
        
    } err:^(NSError *error) {
        
    }];
    // Do any additional setup after loading the view.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 52;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XMSelectDeviceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XMSelectDeviceCell" ];
    if(!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"XMSelectDeviceCell" owner:self options:nil]lastObject];
    }
    // Configure the cell...
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    if(![self.selectDic objectForKey:[NSString stringWithFormat:@"%ld",indexPath.row+1]] ){
        [cell.selectButton setImage:[UIImage imageNamed:@"select_no"] forState:UIControlStateNormal];

    }
    else{
        [cell.selectButton setImage:[UIImage imageNamed:@"select_yes"] forState:UIControlStateNormal];

    }
    
    cell.selectButton.tag = indexPath.row+1;
    [cell.selectButton addTarget:self action:@selector(onSelectButton:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.lock = self.dataArray[indexPath.row];
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
    
    [bottom.confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [bottom.confirmButton addTarget:self action:@selector(onConfirm) forControlEvents:UIControlEventTouchUpInside];
    return bottom;
}

-(void)getBackResult:(blockResult)result{
    self.backResult = result;
}
-(void)onConfirm{
    
    if(!self.selectDic || self.selectDic.count==0){
        [XMMethod alertErrorMessage:@"您还没有选择"];
        return;
    }
    NSMutableArray * seleArr = [[NSMutableArray alloc] init];
    for(int i=0;i<[[self.selectDic allKeys]count];i++){
       [seleArr addObject:[self.dataArray objectAtIndex:[[self.selectDic allKeys][i] integerValue]-1]] ;
    }
    self.backResult(seleArr);
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)onSelectButton:(UIButton*)btn{
    [self selectIndex:btn.tag];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self selectIndex:indexPath.row+1];
    
}

-(void)selectIndex:(NSInteger)row{
    XMSelectDeviceCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row-1 inSection:0]];
    if(![self.selectDic objectForKey:[NSString stringWithFormat:@"%ld",row]] ){
        //如果存在
        [self.selectDic setObject:@"ok" forKey:[NSString stringWithFormat:@"%ld",row]];
        [cell.selectButton setImage:[UIImage imageNamed:@"select_yes"] forState:UIControlStateNormal];
    }
    else{
        [self.selectDic removeObjectForKey:[NSString stringWithFormat:@"%ld",row]];
        [cell.selectButton setImage:[UIImage imageNamed:@"select_no"] forState:UIControlStateNormal];
        
    }
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
