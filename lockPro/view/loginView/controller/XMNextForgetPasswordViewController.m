//
//  XMNextForgetPasswordViewController.m
//  lockPro
//
//  Created by 牛付威 on 2018/5/27.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "XMNextForgetPasswordViewController.h"
#import "XMNextForgetPasswordView.h"

@interface XMNextForgetPasswordViewController (){
    XMNextForgetPasswordView * forget ;
}

@end

@implementation XMNextForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置密码";
    
    self.bgView.hidden = NO;
    
    forget = [[XMNextForgetPasswordView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    [self.bgScrollview addSubview:forget];
    self.bgScrollview.contentSize = CGSizeMake(kScreen_Width, kScreen_Height+1);
    
    
    [forget.nextButton addTarget:self action:@selector(onNextButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

-(void)onNextButtonClick:(UIButton*)sender{
    if([XMMethod isNull:forget.passwordTextField.text]){
        [XMMethod alertErrorMessage:@"请输入密码"];
        return;
    }
    
    if(![forget.passwordTextField.text isEqualToString:forget.rePasswordTextField.text]){
        [XMMethod alertErrorMessage:@"请再次确认密码"];
        return;
    }
   
    
 
    [XMDataManager forgetPasswordManager:@{@"Account":self.phone,@"password":forget.passwordTextField.text} success:^(id result) {
        [XMMethod alertErrorMessage:@"修改成功，请重新登录!"];
        
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
