//
//  XMTransPkt.h
//  lockPro
//
//  Created by 牛付威 on 2018/6/2.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "JSONModel.h"

@interface XMTransPkt : JSONModel

@property (nonatomic,copy) NSString * pktNumber; //包的序列号
@property (nonatomic,copy) NSString * token;
@property (nonatomic,copy) NSString * type;//类型
@property (nonatomic,copy) NSString * uid;//用户id
@property (nonatomic,copy) NSString * sfVer;
@property (nonatomic,strong) NSDictionary * obj;

@end
