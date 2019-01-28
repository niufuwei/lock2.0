//
//  XMLogOutView.m
//  xmjr
//
//  Created by laoniu on 2018/2/9.
//  Copyright © 2018年 xiaoma. All rights reserved.
//

#import "XMLogOutView.h"
#import "XMUserModel.h"

@interface XMLogOutView ()

@property (nonatomic,strong) UIImageView * logoImage;
@property (nonatomic,strong) UILabel * nameLable;
@property (nonatomic,strong) UILabel * channalLable;
@property (nonatomic,strong) UILabel * jobLable;
@property (nonatomic,strong) UILabel * modifyPasswordLable;
@property (nonatomic,strong) UITextField * password;


@end

@implementation XMLogOutView


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self loadView];
        [self viewFrame];
    }
    return self;
}

-(void)loadView{
    [self addSubview: self.logoImage];
    [self addSubview: self.nameLable];
    [self addSubview: self.exitButton];

}

-(void)viewFrame{
    [self.logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kScreen_Width/2-50);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(100);
        make.top.mas_equalTo(20);
    }];
    
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(self.logoImage.mas_bottom).offset(20);
        make.width.mas_equalTo(kScreen_Width-40);
        make.height.mas_equalTo(40);
    }];
    
    
    [self.exitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-20);
        make.height.mas_equalTo(55);
    }];
    
//    [self.channalLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@20);
//        make.top.equalTo(self.nameLable.mas_bottom).offset(5);
//        make.width.mas_equalTo(kScreen_Width-40);
//        make.height.mas_equalTo(40);
//    }];
//
//    [self.jobLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(@20);
//        make.top.equalTo(self.channalLable.mas_bottom).offset(5);
//        make.width.mas_equalTo(kScreen_Width-40);
//        make.height.mas_equalTo(40);
//    }];
    
    
}

-(UIImageView*)logoImage{
    if(!_logoImage){
        _logoImage = [[UIImageView alloc] init];
        [_logoImage setImage:[UIImage imageNamed:@"lockHeadImage"]];
    }
    return _logoImage;
}

-(UILabel*)nameLable{
    if(!_nameLable){

        _nameLable = [[UILabel alloc] init];
        
        _nameLable.font = [UIFont systemFontOfSize:14];
        _nameLable.textColor =GRAYCOLOR;
        _nameLable.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLable;
}

-(UIButton*)exitButton{
    if(!_exitButton){
        _exitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_exitButton setTitle:@"退出" forState:UIControlStateNormal];
        [_exitButton setBackgroundColor:[UIColor orangeColor]];
        
        [_exitButton.layer setCornerRadius:5];
        [_exitButton setTitleColor:WHITECOLOR forState:UIControlStateNormal];
    }
    return _exitButton;
}

//-(UILabel*)channalLable{
//    if(!_channalLable){
//        _channalLable = [[UILabel alloc] init];
//        _channalLable.text = [NSString stringWithFormat:@"机构：  %@",[XMEmpInfo shareInstance].empInfo.empName];
//        _channalLable.font = [UIFont systemFontOfSize:14];
//        _channalLable.textColor =GRAYCOLOR;
//    }
//    return _channalLable;
//}
//
//-(UILabel*)jobLable{
//    if(!_jobLable){
//        _jobLable = [[UILabel alloc] init];
//        _jobLable.text = [NSString stringWithFormat:@"职务：  %@",[XMEmpInfo shareInstance].empInfo.empName];
//        _jobLable.font = [UIFont systemFontOfSize:14];
//        _jobLable.textColor =GRAYCOLOR;
//    }
//    return _jobLable;
//}

@end
