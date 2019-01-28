//
//  AppDelegate.h
//  xmjr
//
//  Created by laoniu on 16/4/7.
//  Copyright © 2016年 xiaoma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CircularProgressView.h"
#import "XMTabbarViewController.h"


typedef void (^location)(NSDictionary * locationObj);

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) CircularProgressView * progress;
@property (nonatomic,strong) location locationBack;
@property (nonatomic,copy)    NSString *currentCity;//城市
@property (nonatomic,copy)    NSString *cityCode;//城市
@property (nonatomic,strong) XMTabbarViewController * tabbar;

//获取定位当前=地理位置
//-(void)resetUpdateLocation:(location)location;

//位置逆向解析坐标
//-(void)getAddressCode:(NSString*)address backResultCode:(location)backResultCode;

-(void)logout;
@end

