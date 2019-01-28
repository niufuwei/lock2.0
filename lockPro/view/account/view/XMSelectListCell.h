//
//  XMSelectListCell.h
//  lockPro
//
//  Created by 牛付威 on 2018/5/31.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMContainer.h"

@interface XMSelectListCell : UITableViewCell

@property (nonatomic,strong) XMContainer * container;

@property (nonatomic,strong) IBOutlet UIImageView * carImage;
@property (nonatomic,strong) IBOutlet UILabel * carNumber;
@property (nonatomic,strong) IBOutlet UILabel * carType;
@end
