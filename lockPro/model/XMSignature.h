//
//  XMSignature.h
//  XM_Bank
//
//  Created by admin on 14-6-24.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "XMObject.h"

@interface XMSignature : XMObject
+(NSString *)signNatureWithInfo:(NSDictionary *)info andRankArray:(NSArray *)array;
@end
