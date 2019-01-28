//
//  XMSelectDeviceListViewController.h
//  lockPro
//
//  Created by 牛付威 on 2018/5/31.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "XMViewController.h"
#import "XMContainer.h"
typedef void (^blockResult) (id result);

@interface XMSelectDeviceListViewController : XMViewController
@property (nonatomic,strong) blockResult backResult;
@property (nonatomic,strong) XMContainer * container;

-(void)getBackResult:(blockResult)result;
@end
