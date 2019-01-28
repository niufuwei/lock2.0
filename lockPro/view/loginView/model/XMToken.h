//
//  XMToken.h
//  lockPro
//
//  Created by 牛付威 on 2018/6/2.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMToken : JSONModel

@property (nonatomic,copy) NSString * tokenID;
@property (nonatomic,copy) NSString * userID;// 用户id号
@property (nonatomic,copy) NSString * account;//用户帐号
@property (nonatomic,copy) NSString * oldToken;//以前的令牌
@property (nonatomic,copy) NSString * nToken;//现在的令牌
@property (nonatomic,copy) NSString * devToken;// 用户手机的mac地址
@property (nonatomic,copy) NSString * userImei;// ͷ用户手机的IMEI号
@property (nonatomic,copy) NSString * ip;//ip地址
@property (nonatomic,copy) NSString * tokenTime;//令牌更新时间
@property (nonatomic,copy) NSString * outOfTime;//令牌过期时间
@property (nonatomic,copy) NSString * pcToken;//PC端令牌

+(instancetype)shareInstance;

@end
