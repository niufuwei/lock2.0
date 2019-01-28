//
//  XMBindDeviceListCell.h
//  lockPro
//
//  Created by 牛付威 on 2018/6/1.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMSingleLock.h"

@interface XMBindDeviceListCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UILabel * lockName;
@property (nonatomic,strong) IBOutlet UILabel * mac;
@property (nonatomic,strong) IBOutlet UILabel * time;
@property (nonatomic,strong) IBOutlet UIImageView * icon;
@property (nonatomic,strong) IBOutlet XMSingleLock * lock;

@end
