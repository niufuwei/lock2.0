//
//  XMInfomationViewController.m
//  lockPro
//
//  Created by laoniu on 2018/5/30.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "XMInfomationViewController.h"
#import "XMInfomationListCell.h"
#import "XMShowPhotoPicker.h"
#import "XMModifyNameView.h"

@interface XMInfomationViewController ()
{
    NSArray * dataArray;
    __block NSMutableArray * valueArray;
}

@end

@implementation XMInfomationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [appDelegate.tabbar hideTabBar];
    
    dataArray = @[@"头像",@"昵称",@"手机号"];
    
    self.title = @"个人信息";
    
    valueArray = [[NSMutableArray alloc] init];
    [valueArray addObject:@"tx"];
    [valueArray addObject:[XMUserModel shareInstance].nickName];
    [valueArray addObject:[XMUserModel shareInstance].account];


    
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    [appDelegate.tabbar hideTabBar];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [dataArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        return 71;
    }
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row==0){
        XMInfomationListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XMInfomationIconListCell"];
        
        if(!cell){
            cell = [[[NSBundle mainBundle] loadNibNamed:@"XMInfomationIconListCell" owner:self options:nil]lastObject];
        }
        // Configure the cell...
        
        //    [cell.txButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        cell.titleLabel.text = dataArray[indexPath.row];
        cell.txButton.tag = indexPath.row+1;
        [cell.txButton addTarget:self action:@selector(onTxButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
    }
    else{
        XMInfomationListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XMInfomationListCell"];
        
        if(!cell){
            cell = [[[NSBundle mainBundle] loadNibNamed:@"XMInfomationListCell" owner:self options:nil]lastObject];
        }
        // Configure the cell...
        
        //    [cell.txButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.titleLabel.text = dataArray[indexPath.row];
        cell.inputLabel.tag = indexPath.row+1;
        cell.inputLabel.text = valueArray[indexPath.row];
        if(indexPath.row==1){
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头

        }
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==1){
        XMModifyNameView *  modify = [[XMModifyNameView alloc] init];
        modify.backModifyName = ^(NSString *nickName) {
            
            [XMUserModel shareInstance].nickName = nickName;
            [valueArray replaceObjectAtIndex:1 withObject:nickName];
            [self.tableView reloadData];
        };
        [self.navigationController pushViewController:modify animated:YES];

    }
    else if(indexPath.row ==2){
        
    }
}

-(void)onTxButtonClick:(UIButton*)btn{
    [XMShowPhotoPicker showPhotoPickerView:(XMViewController*)self backImage:^(NSArray<UIImage *> *images) {
        
        [btn setImage:images[0] forState:UIControlStateNormal];
        
    }];
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
