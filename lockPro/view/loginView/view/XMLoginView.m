//
//  BALoginView.m
//  borrowApp
//
//  Created by laoniu on 2016/11/24.
//  Copyright © 2016年 xiaoma. All rights reserved.
//

#import "XMLoginView.h"
#import "UIImage+stretImage.h"

@implementation XMLoginView

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self loadView];
        [self checkFrame];
    }
    return self;
}


-(void)checkFrame{
    
    [self.logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo((kScreen_Width-80)/2);
        make.top.equalTo(self).offset(50);
        make.width.equalTo(@80);
        make.height.equalTo(@80);

    }];
    
    [self.userNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(30);
        make.top.mas_equalTo(self.logoImage.mas_bottom).offset(70);
        make.right.equalTo(self).offset(-30);
        make.height.equalTo(@45);
    }];
    
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(30);
        make.top.mas_equalTo(self.userNameTextField.mas_bottom).offset(15);
        make.right.equalTo(self).offset(-30);
        make.height.equalTo(@45);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(30);
        make.top.mas_equalTo(self.passwordTextField.mas_bottom).offset(100);
        make.right.equalTo(self).offset(-30);
        make.height.equalTo(@45);
    }];
    
    [self.registButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-40);
        make.width.equalTo(@100);
        make.height.equalTo(@30);
        make.top.mas_equalTo(self.passwordTextField.mas_bottom).offset(15);

    }];

    [self.forgetPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(30);
        make.width.equalTo(@100);
        make.height.equalTo(@30);
        make.top.mas_equalTo(self.passwordTextField.mas_bottom).offset(15);
    }];
    
    [self.protocolButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset((kScreen_Width-150)/2);
        make.width.equalTo(@150);
        make.height.equalTo(@20);
        make.bottom.mas_equalTo(self).offset(20);
    }];
//
//
}

-(void)loadView{

    [self addSubview:self.logoImage];
    [self addSubview:self.userNameTextField];
    [self addSubview:self.passwordTextField];

    [self addSubview:self.loginButton];
    [self addSubview:self.registButton];
    
    [self addSubview:self.forgetPasswordButton];
    
    [self addSubview:self.protocolButton];

//    [XMMethod drawLine:kScreen_Width/2-0.5 fromY:kScreen_Height-205 toX:kScreen_Width/2-0.5 toY:kScreen_Height-100 lineWidth:1 lineColor:LIGHTGRAY];
}




-(UIButton*)forgetPasswordButton{
    if(!_forgetPasswordButton){
        _forgetPasswordButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetPasswordButton setTitle:@"忘记密码?" forState:UIControlStateNormal];
        [_forgetPasswordButton setTitleColor:COLOR(25, 173, 104) forState:UIControlStateNormal];
        [_forgetPasswordButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        _forgetPasswordButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
    }
    return _forgetPasswordButton;
}

-(UIButton*)registButton{
    if(!_registButton){
        _registButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_registButton setTitle:@"新用户注册" forState:UIControlStateNormal];
        [_registButton setTitleColor:COLOR(25, 173, 104) forState:UIControlStateNormal];
        [_registButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        _registButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        
        
    }
    return _registButton;
}


-(XMTextField*)userNameTextField{
    if(!_userNameTextField){
        _userNameTextField = [[XMTextField alloc] init];
        _userNameTextField.placeholder = @"请输入手机号";
        [_userNameTextField.layer setCornerRadius:20];
        _userNameTextField.backgroundColor = COLOR(66, 71, 77);
        _userNameTextField.text = @"15267111709";
        _userNameTextField.textColor = WHITECOLOR;
        [_userNameTextField setValue:UIColorFromRGB(0xA9A9A9) forKeyPath:@"_placeholderLabel.textColor"];
        _userNameTextField.clearButtonMode = UITextFieldViewModeAlways;
        _userNameTextField.font = [UIFont systemFontOfSize:14];

        
        UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 15)];
        [image setImage:[UIImage imageNamed:@"userIcon"]];
        image.contentMode = UIViewContentModeScaleAspectFit;
        _userNameTextField.leftView = image;
  
        UIImageView * imageShu = [[UIImageView alloc] initWithFrame:CGRectMake(50, 15, 1, 15)];
        [imageShu setBackgroundColor:UIColorFromRGB(0xA9A9A9)];
        [_userNameTextField addSubview:imageShu];
        _userNameTextField.leftViewMode = UITextFieldViewModeAlways;
//                _userNameTextField.text = @"C0119010";


    }
    return _userNameTextField;
}

-(XMTextField*)passwordTextField{
    if(!_passwordTextField){
        _passwordTextField = [[XMTextField alloc] init];
        _passwordTextField.placeholder = @"请输入密码";
        [_passwordTextField.layer setCornerRadius:20];
        _passwordTextField.backgroundColor = COLOR(66, 71, 77);
        _passwordTextField.text = @"111111";
        _passwordTextField.textColor = WHITECOLOR;
        _passwordTextField.font = [UIFont systemFontOfSize:14];
        _passwordTextField.secureTextEntry = YES;
        [_passwordTextField setValue:UIColorFromRGB(0xA9A9A9) forKeyPath:@"_placeholderLabel.textColor"];
        _passwordTextField.clearButtonMode = UITextFieldViewModeAlways;

        UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 15)];
        image.contentMode = UIViewContentModeScaleAspectFit;
        [image setImage:[UIImage imageNamed:@"passwrodIcon"]];
        _passwordTextField.leftView = image;
        _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
        
        UIImageView * imageShu = [[UIImageView alloc] initWithFrame:CGRectMake(50, 15, 1, 15)];
        [imageShu setBackgroundColor:UIColorFromRGB(0xA9A9A9)];
        [_passwordTextField addSubview:imageShu];
    }
    return _passwordTextField;
    
}

-(UIButton*)loginButton{
    if(!_loginButton){
        _loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_loginButton setBackgroundColor:COLOR(25, 173, 104)];
        _loginButton.layer.cornerRadius = 20.0;
        [_loginButton setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        [_loginButton setTitle:@"进入App" forState:UIControlStateNormal];
    }
    return _loginButton;
}


-(UIButton*)protocolButton{
    if(!_protocolButton){
        _protocolButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_protocolButton setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        [_protocolButton setTitle:@"䪅好用户协议及隐私政策" forState:UIControlStateNormal];
        _protocolButton.titleLabel.font =[UIFont systemFontOfSize:12];
        
    }
    return _protocolButton;
}



-(UIImageView*)logoImage{
    if(!_logoImage){
        _logoImage = [[UIImageView alloc] init];
        [_logoImage setImage:[UIImage imageNamed:@"logo_180"]];
        _logoImage.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    return _logoImage;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
