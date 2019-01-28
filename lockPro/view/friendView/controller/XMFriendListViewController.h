//
//  XMFriendListViewController.h
//  lockPro
//
//  Created by 牛付威 on 2018/5/28.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMFriendModel.h"

typedef NS_ENUM(NSInteger , friendType) {
    TABBAR_LIST,
    SELECT_FRIEND
};
@interface XMFriendListViewController : XMViewController


@property (nonatomic,assign) friendType friendPageType;

@property (nonatomic,copy,nullable) void(^blockBack)(XMFriendModel * Result);

@end
