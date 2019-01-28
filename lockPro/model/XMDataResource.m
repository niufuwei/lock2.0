//
//  XMDataResource.m
//  XM_Bank
//
//  Created by admin on 14-4-10.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "XMDataResource.h"
#import <objc/runtime.h>
#import "XMEncrypt.h"

@implementation XMDataResource

-(void)dealloc{

    
}

//处理所有的数据
+(id)processRequestData2222:(NSData *)data needDecrypt:(BOOL)needDecrypt{
    
    
    return needDecrypt ? [XMDataResource jsonValueFromString:[XMDataResource processDecryptionData2222:data]] :  [XMDataResource jsonValueFromData:data];
}

//解密NSData
+(NSString *)processDecryptionData2222:(NSData *)data{
    
    NSString *key = [XMEncrypt get3DESKey];
    NSString *dataString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    if ([XMMethod isNull:dataString]) {
        dataString = nil;
        @throw [NSException exceptionWithName:@"错误" reason:@"服务器无响应，请重试" userInfo:nil];
    }
    NSString *decryptString = [XMEncrypt decrypt3DES:dataString key:key];
    NSLog(@"解密后的报文为:%@",decryptString);
    
    if ([XMMethod isNull:decryptString]) {
        decryptString = nil;
        @throw [NSException exceptionWithName:@"提示" reason:@"网络请求异常" userInfo:nil];
        //@throw [NSException exceptionWithName:@"错误" reason:@"解密后数据为空" userInfo:nil];
    }
    
    NSLog(@"%@",decryptString);
    return decryptString;
}


//解密NSString
+(NSString *)processDecryptionString2222:(NSString *)encryptString{
    
    if ([XMMethod isNull:encryptString]) {
        @throw [[NSException alloc]initWithName:@"错误" reason:@"服务器无响应，请重试" userInfo:nil];
    }
    NSString *key = [XMEncrypt get3DESKey];
    NSString *decryptString = [XMEncrypt decrypt3DES:encryptString key:key];
    NSLog(@"解密后的报文为:%@",decryptString);
    if ([XMMethod isNull:decryptString]) {
        decryptString = nil;
        @throw [NSException exceptionWithName:@"提示" reason:@"网络请求异常" userInfo:nil];
        //@throw [NSException exceptionWithName:@"错误" reason:@"解密后数据为空" userInfo:nil];
    }
    return decryptString;
}


//处理所有的数据
+(id)processRequestData:(NSData *)data needDecrypt:(BOOL)needDecrypt{

    
    return needDecrypt ? [XMDataResource jsonValueFromString:[XMDataResource processDecryptionData:data]] :  [XMDataResource jsonValueFromData:data];
}

//解密NSData
+(NSString *)processDecryptionData:(NSData *)data{

    NSString *key = [XMEncrypt get3DESKey];
    NSString *dataString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    if ([XMMethod isNull:dataString]) {
        dataString = nil;
        @throw [NSException exceptionWithName:@"错误" reason:@"服务器无响应，请重试" userInfo:nil];
    }
    NSString *decryptString = [XMEncrypt decrypt3DES:dataString key:key];

    if ([XMMethod isNull:decryptString]) {
        decryptString = nil;
        @throw [NSException exceptionWithName:@"提示" reason:@"网络请求异常" userInfo:nil];
        //@throw [NSException exceptionWithName:@"错误" reason:@"解密后数据为空" userInfo:nil];
    }
    
    return decryptString;
}


//解密NSString
+(NSString *)processDecryptionString:(NSString *)encryptString{
    
    if ([XMMethod isNull:encryptString]) {
        @throw [[NSException alloc]initWithName:@"错误" reason:@"服务器无响应，请重试" userInfo:nil];
    }
    NSString *key = [XMEncrypt get3DESKey];
    NSString *decryptString = [XMEncrypt decrypt3DES:encryptString key:key];
    NSLog(@"解密后的报文为:%@",decryptString);
    if ([XMMethod isNull:decryptString]) {
        decryptString = nil;
        @throw [NSException exceptionWithName:@"提示" reason:@"网络请求异常" userInfo:nil];
        //@throw [NSException exceptionWithName:@"错误" reason:@"解密后数据为空" userInfo:nil];
    }
    return decryptString;
}


//json解析json字符串
+(id)jsonValueFromString:(NSString *)jsonString{

    NSError *error;
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    if (nil == data) {
        data = [NSData data];
    }
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error) {
        result = nil;
        @throw [NSException exceptionWithName:error.domain reason:@"网络请求异常"  userInfo:nil];
    }
    if (nil == result) {
        result = [[NSDictionary alloc]init];
    }
    return result;
}

//json解析jsonData
+(id)jsonValueFromData:(NSData *)jsonData{

    NSError *error;
    if (nil == jsonData) {
        jsonData = [NSData data];
    }
    id result = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    if (error) {
        result = nil;
        @throw [NSException exceptionWithName:error.domain reason:@"网络请求异常" userInfo:nil];
    }
    if (nil == result) {
        result = [[NSDictionary alloc]init];
    }

    return result;
}

+(NSString *)jsonDataFrom:(NSDictionary *)dic{

    NSError *error;
    NSString *jsonStr = nil;
    if (nil == dic) {
        dic = [NSDictionary dictionary];
    }
    if (dic) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
        if (error) {
            jsonData = nil;
            @throw [NSException exceptionWithName:error.domain reason:@"JSON转换出错" userInfo:nil];
        }else
            jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonStr;
}

@end
