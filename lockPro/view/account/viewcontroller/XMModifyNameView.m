//
//  XMModifyNameView.m
//  lockPro
//
//  Created by 牛付威 on 2018/5/31.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "XMModifyNameView.h"

@interface XMModifyNameView ()<NavCustomDelegate>
{
    XMNavCustom * nav;
    UITextField * inputTextField;

}
@end

@implementation XMModifyNameView

- (void)viewDidLoad {
    [super viewDidLoad];
   
    inputTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 45)];
    inputTextField.placeholder = @"请输入新昵称";
    inputTextField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 20)];
    inputTextField.leftViewMode = UITextFieldViewModeAlways;
    inputTextField.backgroundColor = WHITECOLOR;
    [self.bgScrollview addSubview:inputTextField];
    
    nav = [[XMNavCustom alloc] init];
    nav.NavDelegate = self;
    [nav setNavRightBtnTitle:@"保存" mySelf:self width:40 height:20];
    
    // Do any additional setup after loading the view.
}

-(void)NavRightButtononClick {
    
    if([XMMethod isNull:inputTextField.text]){
        [XMMethod alertErrorMessage:@"请输入用户名"];
        return;
    }
    
    
    [XMDataManager modifyNicknameManager:@{@"nickName":inputTextField.text,@"userID":[XMUserModel shareInstance].userID} success:^(id result) {
        [XMMethod alertErrorMessage:@"修改成功!"];
        _backModifyName(inputTextField.text);
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    } err:^(NSError *error) {
        
    }];
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setBackModifyName:(void (^)(NSString *))backModifyName{
    _backModifyName = backModifyName;
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
