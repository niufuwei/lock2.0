//
//  XMLockRelat.h
//  lockPro
//
//  Created by laoniu on 2018/6/6.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "JSONModel.h"

@interface XMLockRelat : JSONModel
@property (nonatomic,copy) NSString *  lockID;
@property (nonatomic,copy) NSString *  containerID;//容器id号
@property (nonatomic,copy) NSString *  posID;//授权人ID号
@property (nonatomic,copy) NSString * lockName;//铅封名称
@property (nonatomic,copy) NSString * macAddr;//铅封mac地址
@property (nonatomic,copy) NSString * account;// 授权人账号
@property (nonatomic,copy) NSString * nickName;// 授权人昵称
@property (nonatomic,copy) NSString *  lockStat;//锁的状态  1表示开，2表示关，3表示中间状态，0表示未知
@property (nonatomic,copy) NSString * pos;//位置
@property (nonatomic,copy) NSString * SN;//编号
@property (nonatomic,copy) NSString *  elec;//电量
@property (nonatomic,copy) NSString *  cUid;
@property (nonatomic,copy) NSString *  authoCnt;//操作次数



@end
