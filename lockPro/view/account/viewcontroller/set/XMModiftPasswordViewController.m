//
//  XMModiftPasswordViewController.m
//  lockPro
//
//  Created by 牛付威 on 2018/6/1.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "XMModiftPasswordViewController.h"
#import "XMModifyPasswordView.h"

@interface XMModiftPasswordViewController ()
{
    XMModifyPasswordView * modify;
}
@end

@implementation XMModiftPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    modify = [[[NSBundle mainBundle] loadNibNamed:@"XMModifyPasswordView" owner:self options:nil]lastObject];
    
    modify.frame=  CGRectMake(0, 0, kScreen_Width, 335);
    [modify.modifyConfirm addTarget:self action:@selector(modifyPassowrd) forControlEvents:UIControlEventTouchUpInside];
    [self.bgScrollview addSubview:modify];
    // Do any additional setup after loading the view.
}

-(void)modifyPassowrd{

    if([XMMethod isNull:modify.oldPassword.text]){
        [XMMethod alertErrorMessage:@"请输入原密码"];
        return;
    }

    if([XMMethod isNull:modify.nPassword.text]){
        [XMMethod alertErrorMessage:@"请输入新的密码"];
        return;
    }
    
    if(![modify.nPassword.text isEqualToString:modify.reNewPassword.text]){
        [XMMethod alertErrorMessage:@"请再次确认新的密码"];
        return;
    }
    
    [XMDataManager modifyPasswordManager:@{@"Account":[XMUserModel shareInstance].account,@"oldPsd":modify.oldPassword.text,@"nowPsd":modify.nPassword.text,@"userImei":@""} success:^(id result) {
        [XMMethod alertErrorMessage:@"修改成功!"];
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
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
