//
//  XMUserInfo.m
//  xmjr
//
//  Created by laoniu on 2018/2/8.
//  Copyright © 2018年 xiaoma. All rights reserved.
//

#import "XMUserModel.h"

@implementation XMUserModel

static XMUserModel * info =nil;

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
