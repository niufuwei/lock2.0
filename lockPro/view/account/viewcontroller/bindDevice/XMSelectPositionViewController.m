//
//  XMSelectDeviceListViewController.m
//  lockPro
//
//  Created by 牛付威 on 2018/5/31.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "XMSelectPositionViewController.h"
#import "XMSelectDeviceCell.h"
#import "XMConfirmButtonCell.h"

@interface XMSelectPositionViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,strong) NSMutableDictionary * selectDic;

@end

@implementation XMSelectPositionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"选择位置";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.backgroundColor = BGCOLOR;
    [self.view addSubview:self.tableView];
    
    
    
    self.selectDic = [[NSMutableDictionary alloc] init];
    self.dataArray = [[NSMutableArray alloc] init];
    
    [self.dataArray addObject:@{@"title":@"后",@"content":@"0x01"}];
    [self.dataArray addObject:@{@"title":@"左后",@"content":@"0x02"}];
    [self.dataArray addObject:@{@"title":@"右后",@"content":@"0x04"}];
    [self.dataArray addObject:@{@"title":@"上",@"content":@"0x08"}];
    [self.dataArray addObject:@{@"title":@"上前",@"content":@"0x10"}];
    [self.dataArray addObject:@{@"title":@"上后",@"content":@"0x20"}];
    [self.dataArray addObject:@{@"title":@"中",@"content":@"0x40"}];

    
    // Do any additional setup after loading the view.
}


-(void)getBackResult:(blockPostitionResult)result{
    self.backResult =  result;
}
#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
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
    cell.titleLabel.text =[[self.dataArray objectAtIndex:indexPath.row] objectForKey:@"title"];
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

-(void)onSelectButton:(UIButton*)btn{
    [self selectIndex:btn.tag];

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self selectIndex:indexPath.row+1];
    
}

-(void)selectIndex:(NSInteger)row{
    XMSelectDeviceCell * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row-1 inSection:0]];
    [self.selectDic removeAllObjects];
    if(![self.selectDic objectForKey:[NSString stringWithFormat:@"%ld",row]] ){
        //如果存在
        [self.selectDic setObject:@"ok" forKey:[NSString stringWithFormat:@"%ld",row]];
        [cell.selectButton setImage:[UIImage imageNamed:@"select_yes"] forState:UIControlStateNormal];
    }
    else{
        [self.selectDic removeObjectForKey:[NSString stringWithFormat:@"%ld",row]];
        [cell.selectButton setImage:[UIImage imageNamed:@"select_no"] forState:UIControlStateNormal];
    }
    
    [self.tableView reloadData];
}

-(void)onConfirm{
    
    if([self.selectDic allKeys].count!=1){
        [XMMethod alertErrorMessage:@"请选择"];
        return;
    }
    NSInteger row = [[self.selectDic allKeys][0] intValue]-1;
    
    self.backResult(self.dataArray[row]);
    [self.navigationController popViewControllerAnimated:YES];

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
