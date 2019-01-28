//
//  XMSelectDeviceCell.h
//  lockPro
//
//  Created by 牛付威 on 2018/5/31.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMSingleLock.h"

@interface XMSelectDeviceCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UIButton * selectButton;
@property (nonatomic,strong) IBOutlet UILabel * titleLabel;
@property (nonatomic,strong)  XMSingleLock * lock;

@end
