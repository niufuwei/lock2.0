//
//  XMBigCarView.m
//  lockPro
//
//  Created by 牛付威 on 2018/6/1.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "XMBigCarView.h"

@implementation XMBigCarView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    for(UILabel * label in self.contentView.subviews){
        if([label isKindOfClass:UILabel.class]){
            label.layer.cornerRadius = 10;
            label.layer.masksToBounds=  YES;
        }
    }
    
    for(UIButton * btn in self.contentView.subviews){
        if([btn isKindOfClass:UIButton.class]){
            btn.layer.cornerRadius = 20;
            btn.layer.masksToBounds=  YES;
        }
    }
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
