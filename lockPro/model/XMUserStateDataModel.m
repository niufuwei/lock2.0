//
//  BAUserStateDataModel.m
//  borrowApp
//
//  Created by laoniu on 2016/11/23.
//  Copyright © 2016年 xiaoma. All rights reserved.
//

#import "XMUserStateDataModel.h"

@implementation XMUserStateDataModel

static XMUserStateDataModel * stateDataModel;

+(instancetype)shareInstance
{
    @synchronized (self) {
        if(!stateDataModel)
        {
            stateDataModel = [[self alloc] init];
        }
    }
    return stateDataModel;
}

@end
