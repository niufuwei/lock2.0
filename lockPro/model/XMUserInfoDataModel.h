//
//  XMUserInfoDataModel.h
//  xmjr
//
//  Created by laoniu on 2016/11/10.
//  Copyright © 2016年 xiaoma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMUserInfoDataModel : NSObject

@property (nonatomic,copy) NSString * token;
@property (nonatomic,copy) NSString * userId;
@property (nonatomic,copy) NSString * userName;
@property (nonatomic,copy) NSString * userNameNo;
@property (nonatomic,copy) NSString * empName;
@property (nonatomic,copy) NSString * empNo;

@property (nonatomic,copy) NSString * hasGesturePassword;//是否有手势密码
@property (nonatomic,copy) NSString * availableAmount;//账户余额
@property (nonatomic,copy) NSString * isInvite;//1不能生成邀请码
@property (nonatomic,copy) NSString * lenderId;
@property (nonatomic,copy) NSString * realnamestatus;//认证状态
@property (nonatomic,copy) NSString * userMark;//推送标签

@property (nonatomic,assign) BOOL isModify;//cell可不可点击
@property (nonatomic,assign) BOOL currentSearchPage;//是不是从搜索页面进去的

@property (nonatomic,copy) NSString * parameRequest;

@property (nonatomic,assign) BOOL haveQuertFunC;//有没有快捷方式

+(instancetype)shareInstance;

@end
