//
//  XMInstanceIconCheck.h
//  xmjr
//
//  Created by laoniu on 2018/2/2.
//  Copyright © 2018年 xiaoma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMInstanceDataCheck : NSObject


//车辆
+(NSDictionary*)checkCarType:(NSString *)type;

//返回开锁状态
+(NSString*)checkLockStatus:(NSString*)status;
@end
