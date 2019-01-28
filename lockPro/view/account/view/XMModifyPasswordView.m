//
//  XMModifyPasswordView.m
//  lockPro
//
//  Created by 牛付威 on 2018/6/1.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "XMModifyPasswordView.h"

@implementation XMModifyPasswordView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.oldPassword.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
     self.oldPassword.leftViewMode = UITextFieldViewModeAlways;
     
     self.nPassword.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
      self.nPassword.leftViewMode = UITextFieldViewModeAlways;
      
      self.reNewPassword.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
       self.reNewPassword.leftViewMode = UITextFieldViewModeAlways;
    
    
    self.modifyConfirm.layer.cornerRadius = 10;
    self.modifyConfirm.layer.masksToBounds = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
