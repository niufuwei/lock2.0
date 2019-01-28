//
//  XMRequestConfig.m
//  xmjr
//
//  Created by laoniu on 2017/12/13.
//  Copyright © 2017年 xiaoma. All rights reserved.
//

#import "XMRequestConfig.h"
#import "XMRequestPara.h"
#import "XMEncrypt.h"
#import "XMSignature.h"
#import "XMDataResource.h"
#import "AFNetworking.h"

//如果加密，则加密字段的名称
#define XM_HTTP_REQUEST_EN @"info"

#define XM_HTTP_REQUEST_INFO         @"info"
#define XM_HTTP_REQUEST_TOKEN        @"token"
#define XM_HTTP_REQUEST_SIGNNATURE   @"sign"
#define XM_HTTP_REQUEST_RANK         @"rank"
#define XM_HTTP_REQUEST_APPSOURCE    @"appSource"

@implementation XMRequestConfig


//+(AFHTTPRequestOperationManager*)getOperationManager{
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//
//    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone]; //不设置会报-1016或者会有编码问题
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer]; //不设置会报-1016或者会有编码问题
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer]; //不设置会报 error 3840
//    return manager;
//}

+(NSMutableURLRequest*)getRequestWithurl:(NSString *)url parameter:(id)parameter{
    
    //参数进行加密
    NSData * signBody = [self sign:parameter];
    
    //进行请求header和cookie设置
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NET_WORK_CONNECT_ADDR_IP stringByAppendingString:url]]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:60];
    
    //    NSString * strCookie = [NSString stringWithFormat:@"%@",[XMUserInfo currentUserInfo].cookieString];
    //    if([strCookie length] !=0 &&![strCookie isKindOfClass:[NSNull class]] && [strCookie rangeOfString:@"null"].location == NSNotFound)
    //    {
    //        NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
    //        [cookieProperties setObject:[XMUserInfo currentUserInfo].cookieString forKey:@"Cookie"];
    //        NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
    //        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    //    }
    
    [request setHTTPShouldHandleCookies:YES];
    
    [request setValue:@"ios_client" forHTTPHeaderField:@"requestSource"];
    
    request.timeoutInterval= 60;
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu",(unsigned long)[signBody length]] forHTTPHeaderField:@"Content-Length"];
    // 设置body
    [request setHTTPBody:signBody];
    [request setHTTPMethod:@"POST"];
    
    //    NSURLConnection *myConnection = [NSURLConnection connectionWithRequest:request delegate:self];
    //    [myConnection start];
    
    return request;
}



+(NSData *)sign:(NSDictionary*)parasDic{
    
    NSArray *array = [parasDic allKeys];
    NSMutableArray *tempParas = [NSMutableArray array];
    for (NSString *str in array) {
        XMRequestPara *para = [[XMRequestPara alloc]init];
        //        para.needEncrypt = needEncrypt;//是否加密
        [para setParaName:str withParaData:[parasDic objectForKey:str]];
        [tempParas addObject:para];
    }
    
    NSString *urlParaString = [self prepareRequestFromeParasdic: [self checkBeforRequest:tempParas parasDic:parasDic]];
    return  [urlParaString dataUsingEncoding:NSUTF8StringEncoding];
    
}

+(NSMutableDictionary*)checkBeforRequest:(NSMutableArray *)array parasDic:(NSDictionary*)parasDic
{
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
    
    //处理得到info部分的json数据
    NSMutableDictionary *dic = [@{} mutableCopy];
    [dic removeAllObjects];
    
    //获取当前时间
    NSDate * date = [NSDate date];
    NSString * strTimer = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    NSMutableDictionary * currentDev = [[NSMutableDictionary alloc] init];
    for (XMRequestPara *para in array) {
        
        [dic setObject:[XMEncrypt encrypt3DES:para.paraData key:[XMEncrypt get3DESKey]] forKey:para.paraName];
        
        //设备信息、、渠道统计
        [currentDev setObject:[XMEncrypt encrypt3DES:[XMMethod isNull:[XMMethod getUUID]]?[XMMethod getUUID]:[XMMethod getUUID] key:[XMEncrypt get3DESKey]] forKey:@"hardware_id_imei"];
        [currentDev setObject:[XMEncrypt encrypt3DES:[XMMethod getUUID] key:[XMEncrypt get3DESKey]] forKey:@"hardware_id_mac"];
        [currentDev setObject:[XMEncrypt encrypt3DES:APP_STORE_ID key:[XMEncrypt get3DESKey]] forKey:@"app_channel"];
        [currentDev setObject:[XMEncrypt encrypt3DES:[XMMethod getAppVersion] key:[XMEncrypt get3DESKey]] forKey:@"app_version_code"];
        [currentDev setObject:[XMEncrypt encrypt3DES:@"ios" key:[XMEncrypt get3DESKey]] forKey:@"app_version_name"];
        [currentDev setObject:[XMEncrypt encrypt3DES:strTimer key:[XMEncrypt get3DESKey]] forKey:@"app_installed_timestamp"];
        
        [currentDev setObject:[XMEncrypt encrypt3DES:@"ios" key:[XMEncrypt get3DESKey]] forKey:@"app_source"];
        [currentDev setObject:[XMEncrypt encrypt3DES:[XMMethod getCurrentDeviceModel] key:[XMEncrypt get3DESKey]] forKey:@"phone_branch_model"];
    }
    
    NSString *info = [XMMethod dictionaryToString:dic];
    NSString * statistics = [XMMethod dictionaryToString:currentDev];
    
    
    [tempDic setObject:info forKey:XM_HTTP_REQUEST_INFO];
    [tempDic setObject:statistics forKey:@"statistics"];
    
    
    
    //处理得到token的数据
    NSString *token = [XMMethod currentUserToken];
    if ([XMMethod isNull:token]) {
        token = [XMEncrypt encrypt3DES:[XMEncrypt get3DESKey] key:[XMEncrypt get3DESKey ]];
    }
    [tempDic setObject:[XMEncrypt encrypt3DES:token key:[XMEncrypt get3DESKey]] forKey:XM_HTTP_REQUEST_TOKEN];
    
    
    //处理得到signature的数据
    NSString *sign = [XMSignature signNatureWithInfo:parasDic andRankArray:[parasDic allKeys]];
    [tempDic setObject:sign forKey:XM_HTTP_REQUEST_SIGNNATURE];
    
    //处理得到的rank数据
    if ([parasDic allKeys] && [parasDic allKeys].count) {
        NSString *rank = [[parasDic allKeys] componentsJoinedByString:@","];
        [tempDic setObject:[XMEncrypt encrypt3DES:rank key:[XMEncrypt get3DESKey]] forKey:XM_HTTP_REQUEST_RANK];
    }
    
    //处理来源数据
    
    NSString *systemVersion = [NSString stringWithFormat:@"appleApp"];
    tempDic[XM_HTTP_REQUEST_APPSOURCE] = [XMEncrypt encrypt3DES:systemVersion key:[XMEncrypt get3DESKey]];
    
    
    //判断是否首次启动
    if ([XMMethod isNull:[XMMethod currentUserToken]]) {
        [tempDic setObject:@"1" forKey:@"isFirst"];
    }
    
    
    return tempDic;
}



/**进行最终的requesturl的拼接，包括info，token和签名3个部分
 *dic，默认传入parasDic
 *返回拼接好后的字符串
 */
+(NSString *)prepareRequestFromeParasdic:(NSDictionary *)dic{
    
    if (nil == dic || [dic allKeys].count == 0) {
        
        dic = [NSDictionary dictionary];
    }
    
    NSMutableString *string = [NSMutableString string];
    NSArray *array = [dic allKeys];
    for (int i = 0; i < [dic allKeys].count; i++) {
        NSString *key = [array objectAtIndex:i];
        [string appendFormat:@"%@=%@&",key,[dic objectForKey:key]];
    }
    [string deleteCharactersInRange:NSMakeRange(string.length - 1, 1)];
    
    return [NSString stringWithString:string];
}


/**将url参数中的特殊字符进行相关的转义
 *参数：需要进行过滤的字符串
 *返回：过滤后的字符串
 */
+(NSString *)urlEscape:(NSString *)sourceStr{
    
    /*
     CFStringRef sRef = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
     (__bridge CFStringRef)sourceStr,
     NULL,
     (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
     kCFStringEncodingUTF8);
     
     CFStringRef sRef = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
     (__bridge CFStringRef)sourceStr,
     NULL,
     (CFStringRef)@"!*'\"();:&=+$,/?#[]% ",
     kCFStringEncodingUTF8);
     */
    CFStringRef sRef = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                               (__bridge CFStringRef)sourceStr,
                                                               NULL,
                                                               (CFStringRef)@"+",
                                                               kCFStringEncodingUTF8);
    NSString *targetStr = [(__bridge NSString *)sRef copy];
    CFRelease(sRef);
    return targetStr;
}


@end
