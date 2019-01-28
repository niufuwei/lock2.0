//
//  XMContainer.h
//  lockPro
//
//  Created by 牛付威 on 2018/6/5.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "JSONModel.h"

@interface XMContainer : JSONModel

@property (nonatomic,copy) NSString * containerID;//容器ID号
@property (nonatomic,copy) NSString * cName;//容器名称
@property (nonatomic,copy) NSString * cUid;//容器唯一编号，如车牌号
@property (nonatomic,copy) NSString * cType;//容器类型，如厢式车、集装车、罐车、房子等
@property (nonatomic,copy) NSString * cGroup;//容器组号
@property (nonatomic,copy) NSString * cDesc;//容器I描述
@property (nonatomic,copy) NSString * entID;//容器所属企业单位编号
@property (nonatomic,copy) NSString * adminsID; //容器管理员id号集合
@property (nonatomic,copy) NSString * contacts; //联系人
@property (nonatomic,copy) NSString * tel; //联系电话
@property (nonatomic,copy) NSString * res1; //
@property (nonatomic,copy) NSString * res2; //
@property (nonatomic,copy) NSString * lng ;//经度
@property (nonatomic,copy) NSString * lat ;//纬度
@property (nonatomic,copy) NSString * time; //容器最后定位时间
@property (nonatomic,copy) NSString * addr; //位置
@property (nonatomic,copy) NSString * posInfo ;//哪些位置有铅封
@property (nonatomic,copy) NSString * statInfo ;//对应位置的铅封开关状态
@property (nonatomic,copy) NSString * authoCnt ;//每辆车的铅封授权次数

@end
