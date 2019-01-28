//
//  XMDES.m
//  XM_Bank
//
//  Created by admin on 14-4-10.
//  Copyright (c) 2014年 admin. All rights reserved.
//
//#import "XMEncrypt.h"

#import "GTMBase64.h"
#import <CommonCrypto/CommonCryptor.h>
#import "XMEncrypt.h"
#import <CommonCrypto/CommonDigest.h>

//#define XM_MD5_DIGEST_LENGTH 16
static NSString *keyString = @"ABCDEFGHIJK123JHAZDEG";

@implementation XMEncrypt

+(NSString *)createDESkey{

    NSString *str = @"ABCDEFGHIJK123JHAZDEG";
    keyString = str;
    return str;
}

+(NSString *)getDESkey{
    
    if ([XMMethod  isNull:keyString]) {
        [self getDESkey];
    }
    return  keyString;
}

+(NSString*) decryptUseDES:(NSString*)cipherText key:(NSString*)key {
    // 利用 GTMBase64 解碼 Base64 字串
    NSData* cipherData = [GTMBase64 decodeString:cipherText];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    
    // IV 偏移量不需使用
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          nil,
                                          [cipherData bytes],
                                          [cipherData length],
                                          buffer,
                                          1024,
                                          &numBytesDecrypted);
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData* data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plainText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return plainText;
}
+(NSString *) encryptUseDES:(NSString *)clearText key:(NSString *)key
{
    NSData *data = [clearText dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    //NSData *data = [clearText dataUsingEncoding:enc allowLossyConversion:YES];
    unsigned char buffer[1024];
    memset(buffer, 0, sizeof(char));
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          nil,
                                          [data bytes],
                                          [data length],
                                          buffer,
                                          1024,
                                          &numBytesEncrypted);
    
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData *dataTemp = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        plainText = [GTMBase64 stringByEncodingData:dataTemp];
    }else{
        NSLog(@"DES加密失败");
    }
    return plainText;
}


+(NSString *)md5Encrypt:(NSString *)target{

    NSMutableString *result = [NSMutableString string];
    const char *original_str = [target UTF8String];
    unsigned char resultTemp[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (unsigned int)strlen(original_str),resultTemp);
    for (int i = 0; i < 16; ++i) {
        [result appendFormat:@"%02x",resultTemp[i]];
    }
    return result;
}

+(NSString *)get3DESKey{

    return @"C8624D3142FC7728";
}



+ (NSString *)encrypt3DES:(NSString *)src key:(NSString *)key{
	const void *vplainText;
    size_t plainTextBufferSize;
    NSData* data = [src dataUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8)];
	plainTextBufferSize = [data length];
	vplainText = (const void *)[data bytes];
	CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
	
    bufferPtrSize = (plainTextBufferSize + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
	const void *vkey = (const void *)[key UTF8String];
	
	ccStatus = CCCrypt(kCCEncrypt,
                       kCCAlgorithmDES,
                       kCCOptionPKCS7Padding | kCCOptionECBMode,
                       vkey,
                       kCCKeySizeDES,
                       nil,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
	if (ccStatus == kCCSuccess) {
        
    }
	NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    free(bufferPtr);
	return [self NSDataToHexString:myData];
}

+ (NSString *)decrypt3DES:(NSString *)src key:(NSString *)key{
    const void *vplainText;
    size_t plainTextBufferSize;
	NSData *EncryptData = [self hexStrToNSData:src];
	plainTextBufferSize = [EncryptData length];
	vplainText = [EncryptData bytes];
	CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
	
    bufferPtrSize = (plainTextBufferSize + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
	const void *vkey = (const void *)[key UTF8String];
	ccStatus = CCCrypt(kCCDecrypt,
                       kCCAlgorithmDES,
                       kCCOptionPKCS7Padding | kCCOptionECBMode,
                       vkey,
                       kCCKeySizeDES,
                       nil,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    if (ccStatus == kCCSuccess) {
      
    }

    NSData *dataBuf = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    free(bufferPtr);
    return [[NSString alloc] initWithData:dataBuf
                                  encoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8)];
}


+ (NSData *)hexStrToNSData:(NSString *)hexStr{
    NSMutableData* data = [NSMutableData data];
    for (int i = 0; i+2 <= hexStr.length; i+=2) {
        NSRange range = NSMakeRange(i, 2);
        NSString* ch = [hexStr substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:ch];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    return data;
}

+ (NSString *)NSDataToHexString:(NSData *)data{
    if (data == nil) {
        return nil;
    }
    
    NSMutableString* hexString = [NSMutableString string];
    const unsigned char *p = [data bytes];
    for (int i=0; i < [data length]; i++) {
        [hexString appendFormat:@"%02X", *p++];
    }
    return hexString;
}



@end
