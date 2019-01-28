//
//  XMRequestParas.h
//  XM_Bank
//
//  Created by admin on 14-4-4.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMRequestPara : NSObject
@property (nonatomic, copy) NSString *paraName;
@property (nonatomic, copy) NSString *paraData;

-(void)setParaName:(NSString *)paraName withParaData:(NSString *)paraData;

@end
