//
//  XMRecoderListCell.h
//  lockPro
//
//  Created by 牛付威 on 2018/6/1.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMOprts.h"

@interface XMRecoderListCell : UITableViewCell

@property (nonatomic,strong) XMOprts * opers;

@property (nonatomic,strong) IBOutlet UILabel * nameLabel;
@property (nonatomic,strong) IBOutlet UILabel * device;
@property (nonatomic,strong) IBOutlet UILabel * time;
@property (nonatomic,strong) IBOutlet UILabel * address;
@property (nonatomic,strong) IBOutlet UIImageView * carImage;
@property (nonatomic,strong) IBOutlet UIImageView * lockImage;
@property (nonatomic,strong) IBOutlet UIButton * relatImg;

@end
