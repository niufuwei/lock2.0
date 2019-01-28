//
//  XMLoginDataModel.m
//  xmjr
//
//  Created by laoniu on 2016/11/8.
//  Copyright © 2016年 xiaoma. All rights reserved.
//

#import "XMLoginDataModel.h"

@implementation XMLoginDataModel

static XMLoginDataModel * login = nil;

+(instancetype)shareInstance
{
    @synchronized (self) {
        if(!login)
        {
            login = [[self alloc] init];
        }
    }
    return login;
}


@end
