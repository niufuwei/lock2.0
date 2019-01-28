//
//  XMNextRegitserViewController.m
//  lockPro
//
//  Created by 牛付威 on 2018/5/27.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "XMNextRegitserViewController.h"
#import "XMNextRegisterView.h"

@interface XMNextRegitserViewController (){
    XMNextRegisterView * nextRegisterView;
}

@end

@implementation XMNextRegitserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"完善信息";

    self.bgView.hidden = NO;

    nextRegisterView = [[XMNextRegisterView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    [self.bgScrollview addSubview:nextRegisterView];
    self.bgScrollview.contentSize = CGSizeMake(kScreen_Width, kScreen_Height+1);
    
    
    [nextRegisterView.nextButton addTarget:self action:@selector(onNextButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

-(void)onNextButtonClick:(id)sender{
    if([XMMethod isNull:nextRegisterView.nameTextField.text]){
        [XMMethod alertErrorMessage:@"请输入用户名"];
        return;
    }
    
    if([XMMethod isNull:nextRegisterView.passwordTextField.text]){
        [XMMethod alertErrorMessage:@"请输入密码"];
        return;
    }
    
    if(![nextRegisterView.rePasswordTextField.text isEqualToString:nextRegisterView.passwordTextField.text]){
        [XMMethod alertErrorMessage:@"请确认您输入的密码是否正确"];
        return;
    }
    
    
    XMUserModel * user = [[XMUserModel alloc] init];
    user.account = self.phone;
    user.password = nextRegisterView.passwordTextField.text;
    user.nickName = nextRegisterView.nameTextField.text;
    user.accountImei = @"11";
    user.ip = @"11";
    user.devToken = [XMMethod getUUID];
    
    
    [XMDataManager registerRequestManager:user success:^(id result) {
        [XMMethod alertErrorMessage:@"注册成功"];
        
        [[XMUserModel shareInstance] setValuesForKeysWithDictionary:result[@"obj"][@"mUser"]];
        [[XMToken shareInstance] setValuesForKeysWithDictionary:result[@"obj"][@"mToken"]] ;

        [[NSUserDefaults standardUserDefaults] setObject:result[@"obj"][@"mToken"] forKey:@"userModel"];

        [appDelegate setTabbar:nil];

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
