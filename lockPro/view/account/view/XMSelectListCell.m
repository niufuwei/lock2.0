//
//  XMSelectListCell.m
//  lockPro
//
//  Created by 牛付威 on 2018/5/31.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "XMSelectListCell.h"

@implementation XMSelectListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setContainer:(XMContainer *)container{
   
    self.carType.text = container.res1;
    [self.carImage setImage:[UIImage imageNamed:[[XMInstanceDataCheck checkCarType:container.cType] objectForKey:@"image"]]];
    self.carNumber.text = container.cUid;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
