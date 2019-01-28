//
//  XMInfomationListCell.m
//  lockPro
//
//  Created by laoniu on 2018/5/30.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "XMInfomationListCell.h"

@implementation XMInfomationListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.txButton.layer.cornerRadius = 55/2;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
