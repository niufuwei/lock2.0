//
//  XMDevice.m
//  lockPro
//
//  Created by laoniu on 2018/6/6.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "XMDevice.h"


@implementation XMDevice

-(NSMutableArray*)rowDataArray{
    if(!_rowDataArray){
        _rowDataArray = [[NSMutableArray alloc] init];
    }
    return _rowDataArray;
}

-(XMContainer*)lsCT{
    if(!_lsCT){
        _lsCT = [[XMContainer alloc] init];
    }
    return _lsCT;
}

-(XMLockRelat*)lsMyLock{
    if(!_lsMyLock){
        _lsMyLock = [[XMLockRelat alloc] init];
    }
    return _lsMyLock;
}

@end
