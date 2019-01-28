//
//  XMSelectDeviceCell.m
//  lockPro
//
//  Created by 牛付威 on 2018/5/31.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "XMSelectDeviceCell.h"

@implementation XMSelectDeviceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setLock:(XMSingleLock *)lock{
    self.titleLabel.text = [lock.pos stringByAppendingFormat:@"（%@）",lock.lockName];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
