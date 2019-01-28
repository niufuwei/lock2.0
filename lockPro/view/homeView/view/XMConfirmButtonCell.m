//
//  XMConfirmButtonCell.m
//  lockPro
//
//  Created by laoniu on 2018/5/29.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "XMConfirmButtonCell.h"

@implementation XMConfirmButtonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.confirmButton.layer.cornerRadius = 20;
    self.confirmButton.layer.masksToBounds = YES;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
