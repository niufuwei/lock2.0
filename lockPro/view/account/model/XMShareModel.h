//
//  XMShareModel.h
//  lockPro
//
//  Created by laoniu on 2018/6/6.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "JSONModel.h"

@interface XMShareModel : JSONModel

@property (nonatomic,copy) NSString * authoID;
@property (nonatomic,copy) NSString * authoType; //授权类型：01：单个铅封对个人授权；02：单个铅封对用户组授权；03：铅封载体对个人授权；04：铅封载体对用户组授权
@property (nonatomic,copy) NSString * locksID;//铅封ID号
@property (nonatomic,copy) NSString * containerID;// 铅封载体ID号
@property (nonatomic,copy) NSString * posID; //授权人ID
@property (nonatomic,copy) NSString * pasID; //被授权人ID
@property (nonatomic,copy) NSString * lockName; //铅封名称
@property (nonatomic,copy) NSString * macAddr ;//铅封MAC地址
@property (nonatomic,copy) NSString * authoStTime; //授权开始时间

@property (nonatomic,copy) NSString * authoTime ;//授权时间
@property (nonatomic,copy) NSString * authoSpTime; //授权结束时间
@property (nonatomic,copy) NSString * latLngs; //位置范围字符集，为了限制铅封开启位置的条件
@property (nonatomic,copy) NSString * timesOfOprt; //允许操作的次数-1表示无限次
@property (nonatomic,copy) NSString * pasAccount ;// 被授权人用户账号
@property (nonatomic,copy) NSString * posAccount ;// 授权人用户账号
@property (nonatomic,copy) NSString * pasName; // 被授权人用户昵称
@property (nonatomic,copy) NSString * posName;// 授权人用户昵称
@property (nonatomic,copy) NSString * lockStat; // 1表示开，2表示关，3表示中间状态，0表示未知
@property (nonatomic,copy) NSString * cUid; // 容器唯一识别号
@property (nonatomic,copy) NSString * pos;// 铅封位置
@property (nonatomic,copy) NSString * SN;// 铅封唯一编号
@property (nonatomic,copy) NSString * elec; // 铅封电量
@property (nonatomic,copy) NSString * OTP;//一次性动态密码


@end
