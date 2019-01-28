//
//  XMDES.h
//  XM_Bank
//
//  Created by admin on 14-4-10.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMEncrypt : NSObject

//创建DES密钥
+(NSString *)createDESkey;

//获得创建的key
+(NSString *)getDESkey;

//DES加密
+(NSString *)encryptUseDES:(NSString *)clearText key:(NSString *)key;

//DES解密
+(NSString*)decryptUseDES:(NSString*)cipherText key:(NSString*)key;

//MD5加密
+(NSString *)md5Encrypt:(NSString *)target;

//获得3des的密钥
+(NSString *)get3DESKey;

//3des加密
+ (NSString *)encrypt3DES:(NSString *)src key:(NSString *)key;
//3des解密
+ (NSString *)decrypt3DES:(NSString *)src key:(NSString *)key;

//将16进制数据转化成NSData
+ (NSData *)hexStrToNSData:(NSString *)hexStr;

//将NSData转化成16进制数据
+ (NSString *)NSDataToHexString:(NSData *)data;

@end

