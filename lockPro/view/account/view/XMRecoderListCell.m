//
//  XMRecoderListCell.m
//  lockPro
//
//  Created by 牛付威 on 2018/6/1.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "XMRecoderListCell.h"

@implementation XMRecoderListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setOpers:(XMOprts *)opers{
    
    NSString * start = @"未知操作";

    if([opers.oprtStat intValue]==1){
        start = @"开启";
    }else if([opers.oprtStat intValue]==2){
        start = @"关闭";

    }
    
    if([opers.oprtStat intValue]==1){
        [self.nameLabel setAttributedText:[XMMethod stringToAttributedStringWithColor_Font:[NSString stringWithFormat:@"%@%@%@",opers.oprtName,start,opers.pos] key:start CustomColor:COLOR(77, 170,109)]];
    }else if([opers.oprtStat intValue]==2){
        [self.nameLabel setAttributedText:[XMMethod stringToAttributedStringWithColor_Font:[NSString stringWithFormat:@"%@%@%@",opers.oprtName,start,opers.pos] key:start CustomColor:COLOR(237, 103,120)]];

    }else if([opers.oprtStat intValue]==0){
        [self.nameLabel setAttributedText:[XMMethod stringToAttributedStringWithColor_Font:[NSString stringWithFormat:@"%@%@%@",opers.oprtName,start,opers.pos] key:start CustomColor:REDCOLOR]];

    }
    NSString * oprtStat =opers.oprtStat;
    if([opers.oprtStat integerValue]==0){
        oprtStat = @"2";
    }
    
    UIImage * image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_%@",opers.pos,oprtStat]];
    if(!image){
        image = [UIImage imageNamed:[NSString stringWithFormat:@"%@_2",opers.pos]];
    }else{
    }
    [self.carImage setImage:image];
    self.device.text = opers.lockName;
    self.time.text = opers.oprtTime;
    self.address.text = opers.oprtAddr;
    self.relatImg.hidden = [XMMethod isNull:opers.relatImg];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
