//
//  XMAddFriendList.m
//  lockPro
//
//  Created by 牛付威 on 2018/5/29.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "XMAddFriendList.h"

@implementation XMAddFriendList

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.addFriend.layer.cornerRadius = 20;
    self.addBG.layer.cornerRadius = 20;
    self.addBG.layer.masksToBounds = YES;
    
    // Initialization code
}

-(void)setModel:(XMFriendModel *)model{
    self.name.text = model.nickName;
    self.phone.text = model.account;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
