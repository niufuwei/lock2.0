//
//  NAPushFile.h
//  lockPro
//
//  Created by laoniu on 2018/8/1.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NAPushFile : NSObject
@property (nonatomic,strong) UIViewController * vc;
@property (nonatomic,copy) NSString * oprtId;

@property (nonatomic,copy) NSDictionary * pushDic;

@end
