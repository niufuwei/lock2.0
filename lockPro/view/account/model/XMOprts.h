//
//  XMOprts.h
//  lockPro
//
//  Created by 牛付威 on 2018/6/6.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "JSONModel.h"


@interface XMOprts : JSONModel
@property (nonatomic,copy) NSString * oprtID;
@property (nonatomic,copy) NSString * oprtWay;//操作方式:1表示密码开锁；2表示授权单用户开锁;3表示授权组用户
@property (nonatomic,copy) NSString * lockID;//操作的锁
@property (nonatomic,copy) NSString * lockName; //铅封名称
@property (nonatomic,copy) NSString * pos;//铅封位置
@property (nonatomic,copy) NSString * lockMac;//锁的MAC地址
@property (nonatomic,copy) NSString * oprtUserID; //谁操作的
@property (nonatomic,copy) NSString * oprtAccount; //操作人帐号
@property (nonatomic,copy) NSString * oprtName; //操作人昵称
@property (nonatomic,copy) NSString * oprtGID;//组ID号
@property (nonatomic,copy) NSString * oprtGName;//组名字
@property (nonatomic,copy) NSString * authoUserID;//谁授权的
@property (nonatomic,copy) NSString * authoAccount; //授权人帐号

@property (nonatomic,copy) NSString * authoName; //授权人昵称
@property (nonatomic,copy) NSString * oprtTime;//操作时间
@property (nonatomic,copy) NSString * oprtSvrTime; //操作时服务器时间，以此为准
@property (nonatomic,assign) double oprtLat;//操作纬度
@property (nonatomic,assign) double oprtLng;//操作经度
@property (nonatomic,copy) NSString * oprtAddr; //操作地址
@property (nonatomic,copy) NSString * oprtStat;//1表示开，2表示关，0表示未知
@property (nonatomic,copy) NSString * cUid; //铅封所在的容器识别号
@property (nonatomic,copy) NSString * markName; //关联点名称
@property (nonatomic,copy) NSString * markAddr; //关联点地址
@property (nonatomic,copy) NSString * relatImg;//关联图片
@property (nonatomic,copy) NSString * devIMEI;//操作设备的ime号

@end
