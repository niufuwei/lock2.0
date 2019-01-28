//
//  XMSelectListViewController.h
//  lockPro
//
//  Created by 牛付威 on 2018/5/31.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "XMViewController.h"

@class XMContainer;
typedef NS_ENUM(NSInteger , type) {
    FROM_ACCOUNT_LIS,//从账户中心进入
    ADD_SHARE_SELECT_CAR,//分享设备时，选择汽车
    RECODER,//查看汽车被分享记录
    BIND_DEVICE,//绑定设备
};
typedef void (^blockResult) (XMContainer * result);

@interface XMSelectListViewController : XMViewController


@property (nonatomic,assign) type pageType;
@property (nonatomic,strong) blockResult backResult;

-(void)getBackResult:(blockResult)result;
@end
