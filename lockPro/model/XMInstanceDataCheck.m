//
//  XMInstanceIconCheck.m
//  xmjr
//
//  Created by laoniu on 2018/2/2.
//  Copyright © 2018年 xiaoma. All rights reserved.
//

#import "XMInstanceDataCheck.h"

@implementation XMInstanceDataCheck
//车辆
+(NSDictionary*)checkCarType:(NSString *)type{
    if([type isEqualToString:@"0"]){
        return @{@"name":@"厢式车",@"image":@"xsCar"};
    }
    return nil;
}

//返回开锁状态
+(NSString*)checkLockStatus:(NSString*)status
{
    if([status integerValue]==1)
    {
        return @"find_openStatus";
    }
    else if([status integerValue]==2)
    {
        return @"find_scan_close";
    }
    else
    {
//        if([status integerValue]==0||[status integerValue]==3)
        return @"find_normalStatus";
    }
    return @"find_normalStatus";

}
@end
