//
//  openCheck.m
//  xmjr
//
//  Created by laoniu on 2017/8/7.
//  Copyright © 2017年 xiaoma. All rights reserved.
//

#import "openCheck.h"
#import "XMDataManager.h"
#import "AFNetworkReachabilityManager.h"
#import "XMLoginDataModel.h"

@implementation openCheck


+(void)openCheckRequest
{
    
    NSDictionary * login;
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"userModel"] isKindOfClass:NSDictionary.class]){
        login = [[NSUserDefaults standardUserDefaults] objectForKey:@"userModel"];
    }
    else{
        login =[NSJSONSerialization JSONObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"userModel"] options:NSJSONReadingMutableLeaves error:nil];
    }
    
    if(login && [login isKindOfClass:NSDictionary.class])
    {
        [[XMUserModel shareInstance] setValuesForKeysWithDictionary:login[@"obj"][@"mUser"]];
        
        [[XMToken shareInstance] setValuesForKeysWithDictionary:login[@"obj"][@"mToken"]] ;
        [appDelegate setTabbar:nil];

    }

  
    
    //请求自动登录
//    [XMDataManager autoLoginRequestManager:@{@"newToken":model.nToken,
//                                             @"userID":model.userID,
//                                             @"devToken":model.devToken,
//                                             @"userImei":model.userImei
//                                             } success:^(id success) {
//        [[XMUserModel shareInstance] setValuesForKeysWithDictionary:success[@"obj"][@"mUser"]];
//
//        [[XMToken shareInstance] setValuesForKeysWithDictionary:success[@"obj"][@"mToken"]] ;
//
//        [appDelegate setTabbar:nil];
//
//        [[NSUserDefaults standardUserDefaults] setObject:[XMToken shareInstance] forKey:@"userModel"];
//
//
//    } err:^(NSError * error) {
//
//    }];
    
//    [XMDataManager loginRequestManager:login success:^(id resultString) {
//
//
//        [[XMUserModel shareInstance] setValuesForKeysWithDictionary:resultString[@"obj"][@"mUser"]];
//
//        [[XMToken shareInstance] setValuesForKeysWithDictionary:resultString[@"obj"][@"mToken"]] ;
//
//        [appDelegate setTabbar:nil];
//
//        [[NSUserDefaults standardUserDefaults] setObject:login forKey:@"userModel"];
//
//        NSLog(@"%@",resultString);
//    } err:^(NSError * error) {
//        NSLog(@"%@",error);
//
//    }];
}



/**
 *  检测网络环境
 */
+(void)netWorkStatus
{
    // 如果要检测网络状态的变化,必须用检测管理器的单例的startMonitoring
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSString *str = nil;
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                str = @"未知";
                [XMMethod alertErrorMessage:@"网络出现异常"];
                break;
            case AFNetworkReachabilityStatusNotReachable:
                [XMMethod alertErrorMessage:@"网络出现异常"];
                str = @"无连接";
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                str = @"wifi环境";
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                str = @"2G/3G/4G网络";
                break;
            default:
                [XMMethod alertErrorMessage:@"网络出现异常"];
                str = @"未知";
                break;
        }
        NSLog(@"当前网络环境：%@",str);
    }];
}


@end
