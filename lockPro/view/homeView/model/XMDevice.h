//
//  XMDevice.h
//  lockPro
//
//  Created by laoniu on 2018/6/6.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "JSONModel.h"
#import "XMContainer.h"
#import "XMLockRelat.h"
@interface XMDevice : JSONModel

@property (nonatomic,strong) XMContainer * lsCT;
@property (nonatomic,strong) XMLockRelat * lsMyLock;

@property (nonatomic,strong) NSMutableArray * rowDataArray;
@end
