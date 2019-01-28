//
//  XMToken.m
//  lockPro
//
//  Created by 牛付威 on 2018/6/2.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "XMToken.h"

@implementation XMToken
static XMToken * info =nil;

+(instancetype)shareInstance{
    @synchronized (self) {
        if(!info)
        {
            info = [[self alloc] init];
        }
    }
    return info;
}

@end
