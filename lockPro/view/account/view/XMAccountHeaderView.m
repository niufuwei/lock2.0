//
//  XMAccountHeaderView.m
//  lockPro
//
//  Created by 牛付威 on 2018/5/29.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "XMAccountHeaderView.h"

@implementation XMAccountHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.nameImage.layer.cornerRadius = 69/2;
    self.nameImage.layer.masksToBounds = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
