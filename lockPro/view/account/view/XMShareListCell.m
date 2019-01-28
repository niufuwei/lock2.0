//
//  XMShareListCell.m
//  lockPro
//
//  Created by 牛付威 on 2018/5/31.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "XMShareListCell.h"

@implementation XMShareListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.bgView.layer.cornerRadius = 10;
    self.bgView.layer.masksToBounds = YES;
    // Initialization code
}

-(void)setShareModel:(XMShareModel *)shareModel{

    self.pos.text = shareModel.pos;
    self.lockName.text = shareModel.cUid;
    self.fromPerson.text = [NSString stringWithFormat:@"授权人:%@",shareModel.posName];
    self.startTime.text = shareModel.authoStTime;
    self.endTime.text = shareModel.authoSpTime;
    self.nickName.text = shareModel.pasName;
    NSString * image =[shareModel.timesOfOprt isEqualToString:@"-1"]?@"wuxianICon":@"ycIcon";
    [self.type setImage:[UIImage imageNamed:image]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
