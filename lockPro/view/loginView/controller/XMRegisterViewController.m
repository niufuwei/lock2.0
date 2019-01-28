//
//  XMRegisterViewController.m
//  xmjr
//
//  Created by laoniu on 2018/2/5.
//  Copyright © 2018年 xiaoma. All rights reserved.
//

#import "XMRegisterViewController.h"
#import "XMRegisterView.h"
#import "XMCoder.h"

@interface XMRegisterViewController ()
{
    XMRegisterView * registerView;

}
@end

@implementation XMRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新用户注册";
    
    self.bgView.hidden = NO;
    
    registerView = [[XMRegisterView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    [self.bgScrollview addSubview:registerView];
    self.bgScrollview.contentSize = CGSizeMake(kScreen_Width, kScreen_Height+1);
    
    [registerView.nextButton addTarget:self action:@selector(onNextButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [registerView.recoderButton addTarget:self action:@selector(onCodeButton:) forControlEvents:UIControlEventTouchUpInside];

    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
}
-(void)onCodeButton:(id)sender{
    if(![XMMethod isPhone:registerView.phoneTextField.text]){
        [XMMethod alertErrorMessage:@"请输入正确的手机号"];
        return;
    }
    
    XMCoder * coder = [[XMCoder alloc ] initWithDictionary:@{@"account":registerView.phoneTextField.text} error:nil];
    [XMDataManager getCodeRequestManager:coder success:^(id result) {
                                               
                                               [XMMethod alertErrorMessage:@"验证码已发送"];
                                               UIButton * btn = (UIButton*)sender;
                                               btn.enabled = NO;
                                               __block int timeout=120; //倒计时时间
                                               dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                                               dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
                                               dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
                                               dispatch_source_set_event_handler(_timer, ^{
                                                   if(timeout<=0){ //倒计时结束，关闭
                                                       dispatch_source_cancel(_timer);
                                                       dispatch_async(dispatch_get_main_queue(), ^{
                                                           //设置界面的按钮显示 根据自己需求设置
                                                           [btn setTitle:@"重新获取" forState:UIControlStateNormal];
                                                           btn.enabled = YES;
                                                       });
                                                   }else{
                                                       //            int minutes = timeout / 60;
                                                       //            int seconds = timeout % 60;
                                                       NSString *strTime = [NSString stringWithFormat:@"%ds",timeout];
                                                       dispatch_async(dispatch_get_main_queue(), ^{
                                                           //设置界面的按钮显示 根据自己需求设置
                                                           [btn setTitle:strTime forState:UIControlStateNormal];
                                                           [btn setTitleColor:COLOR(25, 173, 104) forState:UIControlStateNormal];
                                                       });
                                                       timeout--;
                                                       
                                                   }
                                               });
                                               dispatch_resume(_timer);
                                               
                                           } err:^(NSError *error) {
                                               
                                           }];
    
    
}
-(void)onNextButtonClick:(id)sender{
    
    if(![XMMethod isPhone:registerView.phoneTextField.text]){
        [XMMethod alertErrorMessage:@"请输入正确的手机号"];
        return;
    }
    else  if([XMMethod isNull:registerView.coderTextField.text]){
        [XMMethod alertErrorMessage:@"请输入验证码"];
        return;
    }
    XMCoder * coder = [[XMCoder alloc ] initWithDictionary:@{@"account":registerView.phoneTextField.text,
                                                             @"code":registerView.coderTextField.text
                                                             } error:nil];

    
    [XMDataManager veryCodeRequestManager:coder success:^(id result) {
        
        [XMMethod runtimePush:@"XMNextRegitserViewController" dic:@{@"phone":registerView.phoneTextField.text}];

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
