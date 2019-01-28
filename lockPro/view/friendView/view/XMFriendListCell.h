//
//  XMFriendListCell.h
//  lockPro
//
//  Created by 牛付威 on 2018/5/28.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMFriendModel.h"

@interface XMFriendListCell : UITableViewCell

@property (nonatomic,strong) XMFriendModel * model;

@property (nonatomic,strong) IBOutlet UILabel * name;
@property (nonatomic,strong) IBOutlet UILabel * phone;

@end
