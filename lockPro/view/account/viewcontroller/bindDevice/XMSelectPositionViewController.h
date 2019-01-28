//
//  XMSelectDeviceListViewController.h
//  lockPro
//
//  Created by 牛付威 on 2018/5/31.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "XMViewController.h"
#import "XMSingleLock.h"

typedef void (^blockPostitionResult) (id result);

@interface XMSelectPositionViewController : XMViewController
@property (nonatomic,strong) blockPostitionResult backResult;
@property (nonatomic,strong) XMSingleLock * lock;


-(void)getBackResult:(blockPostitionResult)result;
@end
