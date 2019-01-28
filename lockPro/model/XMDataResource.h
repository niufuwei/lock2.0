//
//  XMDataResource.h
//  XM_Bank
//
//  Created by admin on 14-4-10.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "XMObject.h"

/*用来管理所有的重网上请求下来的数据
 */

@interface XMDataResource : XMObject{

}

/**处理请求的数据
 *参数：请求完后返回的数据
 *返回：处理完后的数据对象（先进行解密，然后进行json解析）
 */
+(id)processRequestData:(NSData *)data needDecrypt:(BOOL)needDecrypt;


/**处理加密的数据，返回一个解密后的字符串
 *参数：需要进行加密的NSData
 *返回：返回加密后的字符串
 */
+(NSString *)processDecryptionData:(NSData *)data;

/**处理加密的数据，返回一个解密后的字符串
 *参数：需要进行加密的NSString
 *返回：返回加密后的字符串
 */
+(NSString *)processDecryptionString:(NSString *)encryptString;

/**json解析字符串
 *参数：需要进行解析的NSString
 *返回：返回解析后的数据
 */
+(id)jsonValueFromString:(NSString *)jsonString;

/**json解析字符串
 *参数：需要进行解析的NSData
 *返回：返回解析后的数据
 */
+(id)jsonValueFromData:(NSData *)jsonData;

/**将dic转换成json字符串
 *参数：需要进行转换的dic
 *返回：返回转换后的字符串
 */
+(NSString *)jsonDataFrom:(NSDictionary *)dic;


+(id)processRequestData2222:(NSData *)data needDecrypt:(BOOL)needDecrypt;
+(NSString *)processDecryptionData2222:(NSData *)data;
+(NSString *)processDecryptionString2222:(NSString *)encryptString;
@end
