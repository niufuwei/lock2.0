//
//  BAUserInfoDataModel
//  xmjr
//
//  Created by laoniu on 2016/11/10.
//  Copyright © 2016年 xiaoma. All rights reserved.
//

#import "XMUserInfoDataModel.h"

@implementation XMUserInfoDataModel

static XMUserInfoDataModel * userInfo = nil;

+(instancetype)shareInstance
{
    @synchronized (self) {
        if(!userInfo)
        {
            userInfo = [[self alloc] init];
        }
    }
    return userInfo;
}


@end
