//
//  XMDataManagerMethod.h
//  xmjr
//
//  Created by laoniu on 2016/11/9.
//  Copyright © 2016年 xiaoma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMRequestNetWork.h"

typedef void (^backSuccessresult)(id , NSURLResponse * res);
typedef void (^backExcep)(NSError* , NSURLResponse * res);

@interface XMDataManagerMethod : NSObject

@property (nonatomic,strong) backSuccessresult    block_success;
@property (nonatomic,strong) backExcep      backError;

/*!
 * @brief 请求服务器之前进行数据处理，并发起请求
 * @param dic 请求的数据 requestUrl 请求接口 resultString 请求结果成功返回数据 Error错误信息
 * @return
 */
+(void)writeDic:(id)dic requestUrl:(NSString*)requestUrl method:(requestType)method resultString:(backSuccessresult)resultString Error:(backExcep)Error;
/*!
 * @brief 给数据模型赋值
 * @param obj 请求过来的源数据 class_Name类方法名
 * @return 赋值过后的数据模型
 */

+(NSMutableDictionary*)requestDataCheck:(id)obj class_Name:(NSString*)className;

/*!
 * @brief 给请求到的数据模型赋值
 * @param obj 请求到的源数据 class_Name类方法名
 * @return 赋值过后的数据模型
 */
+(id)backDataModelCheck:(id)obj class_Name:(NSString*)class_Name;

/*!
 * @brief 检测请求过来的数据
 * @param data 请求过来的源数据
 * @return 将null值检测出来替换成0
 */
+(id)checkNull:(id)obj;

/*!
 * @brief 判断数据是否为空
 * @param data 请求过来的源数据
 * @return 不为空返回源数据，有null或为空返回空
 */
+(NSMutableArray*)resolveObj:(id)obj;

/*!
 * @brief 数据转换json
 * @param data 请求过来的源数据
 * @return 返回字典
 */
+(id)dataManager:(id)data;

/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;


@end
