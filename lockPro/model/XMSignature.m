//
//  XMSignature.m
//  XM_Bank
//
//  Created by admin on 14-6-24.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "XMSignature.h"
#import "XMMethod.h"
#import "XMEncrypt.h"

/**需要签名的请求，传的参数顺序必须要规定好，和后台保持一致，不然会导致sign的值不正确。
 *
 *
 *
 */

@implementation XMSignature

+(NSString *)signNatureWithInfo:(NSDictionary *)info andRankArray:(NSArray *)array{

    NSString *currentToken = [XMMethod currentUserToken];
    NSArray *targetArray = [XMMethod arrayFromDictionary:info withKeyRank:array];
    
    if ([XMMethod isNull:currentToken]) {
        currentToken = [XMEncrypt md5Encrypt:[XMEncrypt encrypt3DES:[XMEncrypt get3DESKey] key:[XMEncrypt get3DESKey]]];
        return currentToken;
    }else{
    
        NSString *targetString = [targetArray  componentsJoinedByString:@""];
        NSString *temp = [NSString stringWithFormat:@"%@%@",targetString,currentToken];
        NSLog(@"%@",temp);
        NSString *signature = [XMEncrypt md5Encrypt:[XMEncrypt encrypt3DES:[NSString stringWithFormat:@"%@%@",targetString,currentToken] key:[XMEncrypt get3DESKey]]];
        NSLog(@"signature is %@",signature);
        return signature;
    }
}

@end
