//
//  XMRegisterView.m
//  lockPro
//
//  Created by 牛付威 on 2018/5/20.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "XMRegisterView.h"

@implementation XMRegisterView

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
    

    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(30);
        make.top.mas_equalTo(50);
        make.right.equalTo(self).offset(-30);
        make.height.equalTo(@45);
    }];
    
    [self.coderTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(30);
        make.top.mas_equalTo(self.phoneTextField.mas_bottom).offset(15);
        make.right.equalTo(self).offset(-30);
        make.height.equalTo(@45);
    }];
    
    [self.recoderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneTextField.mas_bottom).offset(25);
        make.right.equalTo(self).offset(-50);
        make.width.equalTo(@100);
        make.height.equalTo(@25);
    }];
    
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(30);
        make.top.mas_equalTo(self.coderTextField.mas_bottom).offset(100);
        make.right.equalTo(self).offset(-30);
        make.height.equalTo(@45);
        
    }];
    
    //
}

-(void)loadView{
    [self addSubview:self.phoneTextField];
    [self addSubview:self.coderTextField];
    
    [self addSubview:self.registButton];
    [self addSubview:self.recoderButton];
    
    //    [XMMethod drawLine:kScreen_Width/2-0.5 fromY:kScreen_Height-205 toX:kScreen_Width/2-0.5 toY:kScreen_Height-100 lineWidth:1 lineColor:LIGHTGRAY];
}



-(XMTextField*)phoneTextField{
    if(!_phoneTextField){
        _phoneTextField = [[XMTextField alloc] init];
        _phoneTextField.placeholder = @"请输入手机号";
        [_phoneTextField.layer setCornerRadius:20];
        _phoneTextField.backgroundColor = COLOR(66, 71, 77);
        _phoneTextField.text = @"";
        _phoneTextField.textColor = WHITECOLOR;
        [_phoneTextField setValue:UIColorFromRGB(0xA9A9A9) forKeyPath:@"_placeholderLabel.textColor"];
        _phoneTextField.clearButtonMode = UITextFieldViewModeAlways;
        _phoneTextField.font = [UIFont systemFontOfSize:14];
        _phoneTextField.leftViewMode = UITextFieldViewModeAlways;
        
        
        UILabel * number = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
        number.text=  @"+86";
        number.textColor = WHITECOLOR;
        number.font = [UIFont systemFontOfSize:14];
        number.textAlignment = NSTextAlignmentCenter;
        _phoneTextField.leftView = number;
        

        //                _userNameTextField.text = @"C0119010";
        
        UIImageView * imageShu = [[UIImageView alloc] initWithFrame:CGRectMake(50, 15, 1, 15)];
        [imageShu setBackgroundColor:UIColorFromRGB(0xA9A9A9)];
        [_phoneTextField addSubview:imageShu];
    }
    return _phoneTextField;
}

-(XMTextField*)coderTextField{
    if(!_coderTextField){
        _coderTextField = [[XMTextField alloc] init];
        _coderTextField.placeholder = @"请输入验证码";
        [_coderTextField.layer setCornerRadius:20];
        _coderTextField.backgroundColor = COLOR(66, 71, 77);
        _coderTextField.text = @"";
        _coderTextField.textColor = WHITECOLOR;
        [_coderTextField setValue:UIColorFromRGB(0xA9A9A9) forKeyPath:@"_placeholderLabel.textColor"];
        _coderTextField.clearButtonMode = UITextFieldViewModeAlways;
        _coderTextField.font = [UIFont systemFontOfSize:14];

        UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 15)];
        image.contentMode = UIViewContentModeScaleAspectFit;
        [image setImage:[UIImage imageNamed:@"codeIcon"]];
        _coderTextField.leftView = image;
        _coderTextField.leftViewMode = UITextFieldViewModeAlways;
        
        UIImageView * imageShu = [[UIImageView alloc] initWithFrame:CGRectMake(50, 15, 1, 15)];
        [imageShu setBackgroundColor:UIColorFromRGB(0xA9A9A9)];
        [_coderTextField addSubview:imageShu];
    }
    return _coderTextField;
    
}

-(UIButton*)recoderButton{
    if(!_recoderButton){
        _recoderButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_recoderButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_recoderButton setTitleColor:LIGHTGRAY forState:UIControlStateNormal];
        [_recoderButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        _recoderButton.layer.borderColor = COLORA(0, 0, 0, 0.2).CGColor;
        _recoderButton.layer.borderWidth = 0.5;
        _recoderButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _recoderButton.layer.cornerRadius = 10.0;
    }
    return _recoderButton;
}

-(UIButton*)registButton{
    if(!_nextButton){
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nextButton setBackgroundColor:COLOR(25, 173, 104)];
        _nextButton.layer.cornerRadius = 20.0;
        [_nextButton setTitleColor:WHITECOLOR forState:UIControlStateNormal];
        [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    }
    return _nextButton;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
