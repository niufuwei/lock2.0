//
//  XMSingleLock.h
//  lockPro
//
//  Created by laoniu on 2018/6/6.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "JSONModel.h"

@interface XMSingleLock : JSONModel

@property (nonatomic,copy) NSString * lockID;//id号
@property (nonatomic,copy) NSString *lockName;
@property (nonatomic,copy) NSString *SN;
@property (nonatomic,copy) NSString *macAddr;
@property (nonatomic,copy) NSString *lastWorkTime;
@property (nonatomic,copy) NSString *imgUrl;// 图标编码号
@property (nonatomic,copy) NSString *cUid;
@property (nonatomic,copy) NSString * elec;
@property (nonatomic,copy) NSString * lockStat;
@property (nonatomic,copy) NSString * lockProp;
@property (nonatomic,copy) NSString *pos;
@property (nonatomic,copy) NSString * containerID;


@end
