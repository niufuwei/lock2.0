//
//  XMShareSave.h
//  lockPro
//
//  Created by laoniu on 2018/6/6.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "JSONModel.h"

@interface XMShareSave : JSONModel

@property (nonatomic,copy) NSString * authoID;
@property (nonatomic,copy) NSString * authoType;//授权类型：01：单个铅封对个人授权；02：单个铅封对用户组授权；03：铅封载体对个人授权；04：铅封载体对用户组授权
@property (nonatomic,copy) NSString * locksID;//铅封ID号集合
@property (nonatomic,copy) NSString * containerID;//铅封载体ID号
@property (nonatomic,copy) NSString * posID;//授权人ID
@property (nonatomic,copy) NSString * pasID;//被授权人ID
@property (nonatomic,copy) NSString * groupID;//被授权用户组ID号
@property (nonatomic,copy) NSString * authoTime;//授权时间
@property (nonatomic,copy) NSString * authoStTime;//授权开始时间
@property (nonatomic,copy) NSString * authoSpTime;//授权结束时间
@property (nonatomic,copy) NSString * latLngs;//位置范围字符集，为了限制铅封开启位置的条件
@property (nonatomic,copy) NSString * timesOfOprt;//允许操作的次数-1表示无限次
@property (nonatomic,copy) NSString * authoStat;//权限状态：1权限成立；2正在申请；4被拒绝

@end
