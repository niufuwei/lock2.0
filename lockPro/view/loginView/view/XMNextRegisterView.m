//
//  XMNextRegisterView.m
//  lockPro
//
//  Created by 牛付威 on 2018/5/27.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "XMNextRegisterView.h"

@implementation XMNextRegisterView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
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
    
    
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(30);
        make.top.mas_equalTo(50);
        make.right.equalTo(self).offset(-30);
        make.height.equalTo(@45);
    }];
    
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(30);
        make.top.equalTo(self.nameTextField.mas_bottom).offset(15);
        make.right.equalTo(self).offset(-30);
        make.height.equalTo(@45);
    }];
    
    [self.rePasswordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(30);
        make.top.equalTo(self.passwordTextField.mas_bottom).offset(15);
        make.right.equalTo(self).offset(-30);
        make.height.equalTo(@45);
    }];
    
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(30);
        make.top.equalTo(self.rePasswordTextField.mas_bottom).offset(100);
        make.right.equalTo(self).offset(-30);
        make.height.equalTo(@45);
        
    }];
    
    //
}

-(void)loadView{
    [self addSubview:self.nameTextField];
    [self addSubview:self.passwordTextField];
    
    [self addSubview:self.rePasswordTextField];
    [self addSubview:self.nextButton];
    
    //    [XMMethod drawLine:kScreen_Width/2-0.5 fromY:kScreen_Height-205 toX:kScreen_Width/2-0.5 toY:kScreen_Height-100 lineWidth:1 lineColor:LIGHTGRAY];
}



-(XMTextField*)nameTextField{
    if(!_nameTextField){
        _nameTextField = [[XMTextField alloc] init];
        _nameTextField.placeholder = @"请输入用户名";
        [_nameTextField.layer setCornerRadius:20];
        _nameTextField.backgroundColor = COLOR(66, 71, 77);
        _nameTextField.text = @"";
        _nameTextField.textColor = WHITECOLOR;
        [_nameTextField setValue:UIColorFromRGB(0xA9A9A9) forKeyPath:@"_placeholderLabel.textColor"];
        _nameTextField.clearButtonMode = UITextFieldViewModeAlways;
        _nameTextField.font = [UIFont systemFontOfSize:14];
        
        UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 15)];
        image.contentMode = UIViewContentModeScaleAspectFit;
        [image setImage:[UIImage imageNamed:@"userIcon"]];
        _nameTextField.leftView = image;
        _nameTextField.leftViewMode = UITextFieldViewModeAlways;
        
        //                _userNameTextField.text = @"C0119010";
        
        UIImageView * imageShu = [[UIImageView alloc] initWithFrame:CGRectMake(50, 15, 1, 15)];
        [imageShu setBackgroundColor:UIColorFromRGB(0xA9A9A9)];
        [_nameTextField addSubview:imageShu];
    }
    return _nameTextField;
}


-(XMTextField*)passwordTextField{
    if(!_passwordTextField){
        _passwordTextField = [[XMTextField alloc] init];
        _passwordTextField.placeholder = @"请输入密码";
        [_passwordTextField.layer setCornerRadius:20];
        _passwordTextField.backgroundColor = COLOR(66, 71, 77);
        _passwordTextField.text = @"";
        _passwordTextField.textColor = WHITECOLOR;
        [_passwordTextField setValue:UIColorFromRGB(0xA9A9A9) forKeyPath:@"_placeholderLabel.textColor"];
        _passwordTextField.clearButtonMode = UITextFieldViewModeAlways;
        _passwordTextField.font = [UIFont systemFontOfSize:14];
        _passwordTextField.secureTextEntry = YES;

        UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 15)];
        image.contentMode = UIViewContentModeScaleAspectFit;
        [image setImage:[UIImage imageNamed:@"passwrodIcon"]];
        _passwordTextField.leftView = image;
        _passwordTextField.leftViewMode = UITextFieldViewModeAlways;
        
        //                _userNameTextField.text = @"C0119010";
        
        UIImageView * imageShu = [[UIImageView alloc] initWithFrame:CGRectMake(50, 15, 1, 15)];
        [imageShu setBackgroundColor:UIColorFromRGB(0xA9A9A9)];
        [_passwordTextField addSubview:imageShu];
    }
    return _passwordTextField;
}


-(XMTextField*)rePasswordTextField{
    if(!_rePasswordTextField){
        _rePasswordTextField = [[XMTextField alloc] init];
        _rePasswordTextField.placeholder = @"请再次输入密码";
        [_rePasswordTextField.layer setCornerRadius:20];
        _rePasswordTextField.backgroundColor = COLOR(66, 71, 77);
        _rePasswordTextField.text = @"";
        _rePasswordTextField.textColor = WHITECOLOR;
        [_rePasswordTextField setValue:UIColorFromRGB(0xA9A9A9) forKeyPath:@"_placeholderLabel.textColor"];
        _rePasswordTextField.clearButtonMode = UITextFieldViewModeAlways;
        _rePasswordTextField.font = [UIFont systemFontOfSize:14];
        _rePasswordTextField.secureTextEntry = YES;

        UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 15)];
        image.contentMode = UIViewContentModeScaleAspectFit;
        [image setImage:[UIImage imageNamed:@"passwrodIcon"]];
        _rePasswordTextField.leftView = image;
        _rePasswordTextField.leftViewMode = UITextFieldViewModeAlways;
        
        //                _userNameTextField.text = @"C0119010";
        
        UIImageView * imageShu = [[UIImageView alloc] initWithFrame:CGRectMake(50, 15, 1, 15)];
        [imageShu setBackgroundColor:UIColorFromRGB(0xA9A9A9)];
        [_rePasswordTextField addSubview:imageShu];
    }
    return _rePasswordTextField;
}


-(UIButton*)nextButton{
    if(!_nextButton){
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextButton setBackgroundColor:COLOR(25, 173, 104)];
        _nextButton.layer.cornerRadius = 20.0;
        [_nextButton setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        [_nextButton setTitle:@"开始探索" forState:UIControlStateNormal];
    }
    return _nextButton;
}

@end
