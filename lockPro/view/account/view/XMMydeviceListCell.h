//
//  XMMydeviceListCell.h
//  lockPro
//
//  Created by 牛付威 on 2018/6/1.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLockRelat.h"

@interface XMMydeviceListCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UILabel * lockName;
@property (nonatomic,strong) IBOutlet UILabel * mac;
@property (nonatomic,strong) IBOutlet UILabel * cuidPos;
@property (nonatomic,strong) IBOutlet UILabel * number;
@property (nonatomic,strong) IBOutlet UIImageView * lockImage;
@property (nonatomic,strong) IBOutlet UIView * progress;
@property (nonatomic,strong) IBOutlet UIImageView * progressBGView;

@property (nonatomic,strong) XMLockRelat * lockRelat;

@end
