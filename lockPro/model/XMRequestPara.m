//
//  XMRequestParas.m
//  XM_Bank
//
//  Created by admin on 14-4-4.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "XMRequestPara.h"
#import <objc/runtime.h>

@interface XMRequestPara ()
@end

@implementation XMRequestPara

-(id)init{
    self = [super init];
    if (self) {
 
    }
    return self;
}

-(void)setParaName:(NSString *)paraName withParaData:(id)paraData{
    
    if ( [XMMethod stringIsEmpty:paraName]) {
        NSLog(@"%@",@"请求参数名称不能为空");
    }
    if ([XMMethod stringIsEmpty:paraData]) {
        NSLog(@"%@",@"请求参数内容不能为空");
    }

    _paraName = paraName;
    _paraData = paraData;
}

@end
