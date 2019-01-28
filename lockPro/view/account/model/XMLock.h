//
//  XMLock.h
//  lockPro
//
//  Created by 牛付威 on 2018/6/5.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "JSONModel.h"

@interface XMLock : JSONModel

@property (nonatomic,copy) NSString * lockID;//id号
@property (nonatomic,copy) NSString * SN;// 出厂编号
@property (nonatomic,copy) NSString * lockName ;// 锁名   cech000120
@property (nonatomic,copy) NSString * macAddr ;//唯一的MAC地址 78:a5:04:69:88:7E
@property (nonatomic,copy) NSString * lastWorkTime ;// 最后一次工作时间
@property (nonatomic,copy) NSString * imgUrl ;// 图标编码号
@property (nonatomic,copy) NSString * hostID;//所有者ID号
@property (nonatomic,copy) NSString * hostAccount ;// 所有者帐号
@property (nonatomic,copy) NSString * hostNickName ;//所有者昵称
@property (nonatomic,copy) NSString * lockProp;//锁的属性01：支持智能开锁
@property (nonatomic,copy) NSString * lockStat;//锁的状态：01：表示开；02：表示关
@property (nonatomic,copy) NSString * randPsd;//动态随机开锁密码
@property (nonatomic,copy) NSString * res1;
@property (nonatomic,copy) NSString * res2;
@property (nonatomic,copy) NSString * containerID;//承载铅封的对象ID号
@property (nonatomic,copy) NSString * pos;//铅封相对容器的位置
@property (nonatomic,copy) NSString * elec;//锁的电量
@property (nonatomic,copy) NSString * openCnt;
@property (nonatomic,copy) NSString * rssi;
@property (nonatomic,copy) NSString * entID;

//软件参数
@property (nonatomic,copy) NSString * autoLockEn;            /* 自动上锁使能位: 1,标识；0，未标识 */
@property (nonatomic,copy) NSString * autoLockTimeOut;                     /* 自动上锁触发时间,单位分 */
@property (nonatomic,copy) NSString * calibCyc;//时间校准周期
@property (nonatomic,copy) NSString * openTrvTime;//开行程时间
@property (nonatomic,copy) NSString * closeTrvTime;//关行程时间
@property (nonatomic,copy) NSString * faultTimes;//错误累计次数
@property (nonatomic,copy) NSString * refV;//堵转参考电压,设备端会乘10
@property (nonatomic,copy) NSString * psdEn;//密码使能
@property (nonatomic,copy) NSString * closeHandEn;//上锁手动使能
@property (nonatomic,copy) NSString * broadcasterTime;//广播时间，500ms


@end
