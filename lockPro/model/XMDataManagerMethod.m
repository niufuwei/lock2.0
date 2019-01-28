//
//  XMDataManagerMethod.m
//  xmjr
//
//  Created by laoniu on 2016/11/9.
//  Copyright © 2016年 xiaoma. All rights reserved.
//

#import "XMDataManagerMethod.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>

@implementation XMDataManagerMethod

// 字典转json字符串方法

+(NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}
/*!
 * @brief 请求服务器之前进行数据处理，并发起请求
 * @param dic 请求的数据 type 请求接口 resultString 请求结果成功返回数据 Error错误信息
 * @return
 */
+(void)writeDic:(id)dic requestUrl:(NSString*)requestUrl method:(requestType)method resultString:(backSuccessresult)resultString Error:(backExcep)Error
{
    
    id model = dic;
    if([dic isKindOfClass:JSONModel.class]){
        model = [dic toDictionary];
    }
    
    NSString *cardId2 = [requestUrl substringWithRange:NSMakeRange(2,2)];
    cardId2 = [NSString stringWithFormat:@"%ld",strtoul([cardId2 UTF8String],0,16)];
    XMTransPkt * transPkt = [[XMTransPkt alloc] initWithDictionary:@{@"sfVer":@"1",
                                                                     @"pktNumber":@"0",
                                                                     @"token":[XMMethod isNull:[XMToken shareInstance].nToken]?@"0":[XMToken shareInstance].nToken,
                                                                     @"type":cardId2,
                                                                     @"uid":[XMMethod isNull:[XMUserModel shareInstance].userID]?@"0":[XMUserModel shareInstance].userID,
                                                                     @"obj":model
                                                                     } error:nil];
   
    NSDictionary * WriteDic = @{
                                @"type":NET_WORK_CONNECT_ADDR_IP,//请求地址
                                @"obj":@{@"sMsg":[transPkt toJSONString]},//请求数据
                                };
    
    if(![OSS_POST_RECODER_SERVICE_PROTOCOL isEqualToString:requestUrl]
       &&![OSS_MY_CARD_LIST_SERVICE_PROTOCOL isEqualToString:requestUrl]
       &&![OSS_MY_DEVICE_LIST_SERVICE_PROTOCOL isEqualToString:requestUrl]
       &&![OSS_MY_FRIEND_LIST_SERVICE_PROTOCOL isEqualToString:requestUrl]
       &&![OSS_SHARE_LIST_SERVICE_PROTOCOL isEqualToString:requestUrl]
      && ![OSS_ALL_DEVICE_SERVICE_PROTOCOL isEqualToString:requestUrl]
        && ![OSS_NO_BIND_DEVICE_SERVICE_PROTOCOL isEqualToString:requestUrl]
  ){
        [appDelegate.window makeToastActivity:CSToastPositionCenter];

    }

    [XMRequestNetWork writeData:WriteDic method:method resultS:^(id resultS ,NSURLResponse * response) {
        
        [appDelegate.window  hideToastActivity];

                NSDictionary * resultDictionary = resultS;
//        ;
        //返回结果
        NSLog(@"%@",resultDictionary);

        if([XMMethod stringIsEmpty:resultDictionary])
        {
            NSError * aError = [[NSError alloc] initWithDomain:[resultDictionary objectForKey:@"msg"]  code:404 userInfo:nil];
            Error(aError ,response);
            
            [XMMethod alertErrorMessage:[resultDictionary objectForKey:@"msg"]];
        }
        else{
            if([[resultDictionary objectForKey:@"code"] integerValue] != 1)
            {
                NSError * aError = [[NSError alloc] initWithDomain:[resultDictionary objectForKey:@"msg"]  code:404 userInfo:nil];

                Error(aError,response);
                [XMMethod alertErrorMessage:[resultDictionary objectForKey:@"msg"]];

                
            }else{
                resultString(resultDictionary ,response);
            }
        }
    } err:^(NSError *except , NSURLResponse * response) {
        Error(except,response);
        [appDelegate.window  hideToastActivity];

        [XMMethod alertErrorMessage:except.domain];

    }];
}

/*!
 * @brief 给请求时用到的数据模型赋值
 * @param obj 请求过来的源数据 class_Name类方法名
 * @return 赋值过后的数据模型
 */
+(NSMutableDictionary*)requestDataCheck:(id)obj class_Name:(NSString*)class_Name
{
    unsigned int numberObj = 0;
    id obj_class = NSClassFromString(class_Name);

    Ivar * vars = class_copyIvarList(obj_class, &numberObj);
    
    NSMutableArray * nameArray = [[NSMutableArray alloc] init];
    NSMutableArray * valueArray = [[NSMutableArray alloc] init];
    if(numberObj == 0)
    {
        return [@{}mutableCopy];
    }
    for(int i= 0;i<numberObj;i++)
    {
        Ivar thisIvar = vars[i];
        NSString * name = [NSString stringWithUTF8String:ivar_getName(thisIvar)];
        if([[name substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"_"])
        {
            [nameArray addObject:[name substringWithRange:NSMakeRange(1, [name length]-1)]];
            
        }
        else{
            [nameArray addObject:[name substringWithRange:NSMakeRange(0, [name length])]];
            
        }
        if(![obj valueForKey:name])
        {
            [valueArray addObject:@"0"];
            
        }
        else
        {
            [valueArray addObject:[XMMethod stringManager:[obj valueForKey:name]]];
            
        }
    }
    free(vars);
    
    NSMutableDictionary * dic =[[NSMutableDictionary alloc] init];
    for(int i = 0; i<[nameArray count] ; i++)
    {
        [dic setObject:valueArray[i] forKey:nameArray[i]];
    }
    
    return dic;
}
/*!
 * @brief 检测请求过来的数据
 * @param data 请求过来的源数据
 * @return 将null值检测出来替换成0
 */
+(id)checkNull:(id)obj
{
    NSString * jsonStr = @"";
    if(![XMMethod isString:obj])
    {
        jsonStr = [XMMethod dictionaryToString:obj];
    }
    else{
        jsonStr = obj;
    }
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"/null" withString:@"/"];
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"null" withString:@"\"\""];
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"Null" withString:@"\"\""];
    jsonStr = [jsonStr stringByReplacingOccurrencesOfString:@"NULL" withString:@"\"\""];

    return jsonStr;
    
}

/*!
 * @brief 判断数据是否为空
 * @param data 请求过来的源数据
 * @return 不为空返回源数据，有null或为空返回空
 */
+(NSMutableArray*)resolveObj:(id)obj
{
    if([XMMethod stringIsEmpty:obj])
    {
        return [@[]mutableCopy];
    }
    return obj;
}

/*!
 * @brief 数据转换json
 * @param data 请求过来的源数据
 * @return 返回字典
 */
+(id)dataManager:(id)data
{
    return [self dictionaryWithJsonString:data];
    
}

/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

/*!
 * @brief 给请求到的数据模型赋值
 * @param obj 请求到的源数据 class_Name类方法名
 * @return 赋值过后的数据模型
 */
+(id)backDataModelCheck:(id)obj class_Name:(NSString*)class_Name
{
    id obj_class = [[[NSClassFromString(class_Name) class] alloc ]init];
    
    unsigned int numberObj = 0;
    Ivar * thisIvarArray = class_copyIvarList([obj_class class], &numberObj);
    
    NSArray * propertArr = [XMDataManagerMethod allPropertyNames:class_Name];
    if(!obj_class)
    {
        return nil;
    }
    for (int i = 0; i < propertArr.count; i ++) {
        
        Ivar thisIvar = thisIvarArray[i];
        NSString * name = [NSString stringWithUTF8String:ivar_getName(thisIvar)];
        
        NSString * resultString = @"";
        if([[name substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"_"])
        {
            resultString = [name substringWithRange:NSMakeRange(1, [name length]-1)];
            
        }
        else{
            resultString = [name substringWithRange:NSMakeRange(0, [name length])];
            
        }
        
        //        // 获得成员变量的类型
        //        NSString *type = [NSString stringWithUTF8String:ivar_getTypeEncoding(thisIvar)];
        //
        //        // 如果属性是对象类型
        //        NSRange range = [type rangeOfString:@"@"];
        //        if (range.location != NSNotFound) {
        //            // 那么截取对象的名字
        //            type = [type substringWithRange:NSMakeRange(2, type.length - 3)];
        //            // 排除系统的对象类型
        //            if (![type hasPrefix:@"NS"]) {
        //                // 将对象名转换为对象的类型，将新的对象字典转模型（递归）
        ////                Class class = NSClassFromString(type);
        //                [self backDataModelCheck:obj class_Name:type];
        //            }
        //        }
        
        //获取变量名称
        const char *memberName = ivar_getName(thisIvar);
        Ivar ivar = class_getInstanceVariable([obj_class class], memberName);
        
        object_setIvar(obj_class, ivar, [obj objectForKey:resultString]);
    }
    return obj_class;
}

/*!
 * @brief 通过运行时获取当前对象的所有属性的名称，以数组的形式返回
 * @param class_name 类方法名
 * @return 包含所有属性的数组
 */
+(NSArray *) allPropertyNames:(NSString*)class_name{
    ///存储所有的属性名称
    NSMutableArray *allNames = [[NSMutableArray alloc] init];
    
    ///存储属性的个数
    unsigned int propertyCount = 0;
    
    id obj_class = NSClassFromString(class_name);

    ///通过运行时获取当前类的属性
    objc_property_t *propertys = class_copyPropertyList(obj_class, &propertyCount);
    
    //把属性放到数组中
    for (int i = 0; i < propertyCount; i ++) {
        ///取出第一个属性
        objc_property_t property = propertys[i];
        
        const char * propertyName = property_getName(property);
        
        [allNames addObject:[NSString stringWithUTF8String:propertyName]];
    } 
    
    ///释放 
    free(propertys); 
    
    return allNames; 
}


@end
