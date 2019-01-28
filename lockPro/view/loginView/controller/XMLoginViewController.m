//
//  XMLogin2ViewController.m
//  XM_Bank
//
//  Created by laoniu on 14/11/22.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "XMLoginViewController.h"
#import "XMLoginDataModel.h"
#import "XMUserInfoDataModel.h"
#import "XMLoginView.h"
#import "XMNavigationController.h"
#import "XMUserModel.h"
#import "XMHomeViewController.h"
#import "XMTabbarViewController.h"

@interface XMLoginViewController ()
{
    XMLoginView * loginView;
}

@end

@implementation XMLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"登录";
    
    
    self.bgView.hidden = NO;
    
    loginView = [[XMLoginView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    [self.bgScrollview addSubview:loginView];
    self.bgScrollview.contentSize = CGSizeMake(kScreen_Width, kScreenHeight+1);

    [loginView.loginButton addTarget:self action:@selector(onLoginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [loginView.registButton addTarget:self action:@selector(onRegister) forControlEvents:UIControlEventTouchUpInside];
    [loginView.forgetPasswordButton addTarget:self action:@selector(forgetPassword) forControlEvents:UIControlEventTouchUpInside];

    
    //检查是否已经登录了
    if([XMMethod currentUserToken]){
    
//        [XMDataManager autoLoginRequestManager:@{@"appTokenKey":[XMMethod getUUID]} success:^(id result) {
//
////            XMHomeViewController * homeView = [[XMHomeViewController alloc] init];
////            XMNavigationController * homeViewNav = [[XMNavigationController alloc] initWithRootViewController:homeView];
//
//            [XMMethod alertErrorMessage:@"自动登录成功"];
////            [appDelegate.window setRootViewController:homeViewNav];
//
//
//
//
//        } err:^(NSError *error) {
//
//        }];
    }
    
      // Do any additional setup after loading the view.
}

#pragma mark --
#pragma mark 登录事件
-(void)onLoginButtonClick{
//    [XMMethod runtimePush:@"XMHomeViewController" dic:nil];
    if([self checkParm]){
        XMUserModel * login = [[XMUserModel alloc] init];
        login.account = loginView.userNameTextField.text;
        login.devToken = [XMMethod getUUID];
        login.password = loginView.passwordTextField.text;
        login.accountImei = @"11";
        [XMDataManager loginRequestManager:login success:^(id resultString) {

            
            [[XMUserModel shareInstance] setValuesForKeysWithDictionary:resultString[@"obj"][@"mUser"]];
            
            [[XMToken shareInstance] setValuesForKeysWithDictionary:resultString[@"obj"][@"mToken"]] ;
            
            [appDelegate setTabbar:nil];
            NSData *data= [NSJSONSerialization dataWithJSONObject:resultString options:NSJSONWritingPrettyPrinted error:nil];
            
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"userModel"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            NSLog(@"%@",resultString);
        } err:^(NSError * error) {
            NSLog(@"%@",error);

        }];
        
    }
   
}

-(BOOL)checkParm{
    if([XMMethod isNull:loginView.userNameTextField.text]){
        [XMMethod alertErrorMessage:@"请输入正确的手机号"];
        return NO;
    }
    if([XMMethod isNull:loginView.passwordTextField.text]){
        [XMMethod alertErrorMessage:@"请输入正确的密码"];
        return NO;
    }
    return YES;
}

#pragma mark --
#pragma mark 注册事件
-(void)onRegister{
    [XMMethod runtimePush:@"XMRegisterViewController" dic:nil];
}

#pragma mark --
#pragma mark 忘记密码事件
-(void)forgetPassword{
    [XMMethod runtimePush:@"XMForgetPasswordViewController" dic:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self hidenNavigationWithAnimation:YES];
    [self hidenTabbarWithAnimation:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

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
