//
//  XMUserInfo.h
//  xmjr
//
//  Created by laoniu on 2018/2/8.
//  Copyright © 2018年 xiaoma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMUserModel : JSONModel


@property (nonatomic,copy) NSString*  userID;// 用户id号
@property (nonatomic,copy) NSString * userRole;//用户角色
@property (nonatomic,copy) NSString * account;// 用户账号
@property (nonatomic,copy) NSString * password;// 用户密码
@property (nonatomic,copy) NSString * nickName;// 用户昵称
@property (nonatomic,copy) NSString * isOnline;// 是否在线，1在线，2离线
@property (nonatomic,copy) NSString * entID;
@property (nonatomic,copy) NSString * devToken ;// 用户的手机mac地址
@property (nonatomic,copy) NSString * accountImei ;// ͷ用户手机的IMEI号
@property (nonatomic,copy) NSString * ip ;//ip地址
@property (nonatomic,copy) NSString * port;//端口号
@property (nonatomic,copy) NSString * gsID;//用户分组

@property (nonatomic,copy) NSString * logTime;//最近的登录时间
@property (nonatomic,copy) NSString * nToken;

@property (nonatomic,copy) NSString * regTime;
@property (nonatomic,copy) NSString * prop;
@property (nonatomic,copy) NSString * verifyCode;
@property (nonatomic,copy) NSString * personality;
@property (nonatomic,copy) NSString * isBinding;//是否绑定；绑定为1，其他设备用此帐号将登陆不了




+(instancetype)shareInstance;
@end
