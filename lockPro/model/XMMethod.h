//
//  XMMethod.h
//  xmjr
//
//  Created by laoniu on 2016/11/8.
//  Copyright © 2016年 xiaoma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XMViewController.h"

@interface XMMethod : NSObject

/*!
* @brief 判断字符串是否为空
* @param obj 要检测的字符串
* @return 是则返回true，反之false
*/
+(BOOL)stringIsEmpty:(id)obj;


/*!
 * @brief 将数组内某些数据替换
 * @param dataArray 要检测的数组
 * @return keyValue 定位keyValue   replacKey要替换的key，replacValue要替换的value
 */
+(NSMutableArray*)checkArray:(NSMutableArray*)dataArray keyValue:(NSDictionary*)keyValue replacKey:(NSString*)replacKey replacValue:(NSString *)replacValue;

/*!
 * @brief 对数据进行处理
 * @param obj 要检测的字符串
 * @return null返回空，否则返回本身
 */
+(id)stringManager:(id)obj;

//检查是否有字母
+(BOOL)isHaveZimu:(NSString*)strFrom;
//检查是否有特殊字符
+ (BOOL)isHaveTeshuzifu:(NSString *)content;

//获取section
+(NSInteger)tagWithindexRow:(NSInteger)indexRow tag:(NSInteger)tag;

+(NSNumber*)stringToInt:(id)str;

//从数组中删除一些数据
+(NSMutableArray*)removeData:(NSArray*)dataArray sourceArray:(NSMutableArray*)sourceArray sectionIndex:(NSInteger)sectionIndex;

//插入一些数据到数组之中
+(NSMutableArray*)insertData:(NSArray*)dataArray sourceArray:(NSMutableArray*)sourceArray sectionIndex:(NSInteger)sectionIndex;

//取出tag对应的key值
+(NSString*)getVAlueFromArray:(NSMutableArray*)dataArray keyValue:(NSDictionary*)keyValue getKey:(NSString*)getKey;
/*!
 * @brief 信息弹框
 * @param obj 弹出的文本
 * @return 无
 */
+(void)alertErrorMessage:(id)obj;

//button加下划线
+(NSMutableAttributedString*)buttonAddLine:(NSString*)string;

/*!
 * @brief 判断是不是字符串
 * @param obj 要检测的obj
 * @return 是返回true，否则返回false
 */
+(BOOL)isString:(id)obj;

/*!
 * @brief 判断是不是字符串
 * @param obj 要检测的obj
 * @return 是返回true，否则返回false
 */
+(BOOL)isDictionary:(id)obj;


/*!
 * @brief 字典转成字符串
 * @param obj 要转换的obj
 * @return 返回转换成功的字符串
 */
+(NSString*)dictionaryToString:(id)obj;


/*!
 * @brief 字符串转成字典
 * @param obj 要转换的obj
 * @return 返回转换成功的字典
 */
+(NSDictionary*)stringTodictionary:(id)obj;

//tag设置
+(NSInteger)tagWithIndexSection:(NSInteger)section indexRow:(NSInteger)indexRow;

//获取row
+(NSInteger)getRowWithTagSection:(NSInteger)section tag:(NSInteger)tag;
/*!
 * @brief push控制器
 * @param vcName 要跳转的控制器 dic要传的参数
 * @return 无
 */
+ (void)runtimePush:(NSString *)vcName dic:(NSDictionary *)dic;

//获取设备uuid
+(NSString *)getUUID;


+(void)hidenRequestText;
+(void)loadRequestText:(NSString*)text;

//获得设备型号
+ (NSString *)getCurrentDeviceModel;

//获取系统版本号
+(NSString *)getAppVersion;


//获取token
+(NSString *)currentUserToken;

//设置token
+(void)setUserToken:(NSString *)token;

//清空token
+(void)cleanUserToken;

//判断数据是否为空
+(BOOL)isNull:(NSString *)str;


//md5加密
+(NSString*)md5Encrypt:(NSString *)target;

//3des加密
+(NSString*)get3DESKey;

//字典和key值检验
+(NSArray *)arrayFromDictionary:(NSDictionary *)dic withKeyRank:(NSArray *)rankKeys;

//画线
+(void)drawLine:(float)fromX fromY:(float)fromY toX:(float)toX  toY:(float)toY lineWidth:(NSInteger)lineWidth lineColor:(UIColor*)lineColor;

//获取当前viewcontroller
+(XMViewController *)getCurrentVC;

//修改视图圆角
+(void)modifyViewRoundView:(UIView*)view corners:(UIRectCorner)corners;

//判断手机号码格式是否正确
+ (BOOL)isPhone:(NSString *)mobile;

//将所有对象转成string
+(NSString*)checkParam:(id)str;

//更改view属性
+(void)viewMove:(id)x
              y:(id)y
          wdith:(id)wdith
         height:(id)height
           view:(UIView*)view;

//拨打电话
+(void)telPhone:(NSString*)phoneNumber;
//从数组中删除一些数据
+(NSMutableArray*)removeData2:(NSArray*)dataArray sourceArray:(NSMutableArray*)sourceArray sectionIndex:(NSInteger)sectionIndex;

//获取文件名字
+(NSMutableArray*)namePicFromDir:(NSString*)dir section:(NSString*)section;
//日期加横杠
+(NSMutableString*)dateStringAdd:(NSString*)str;

//判断文件是否存在存在返回true。否则返回false
+(BOOL)imageIsExit:(NSString*)imageUrl;

//创建文件地址
+(NSString *)urlWithSection:(NSInteger)section indexRow:(NSInteger)indexRow dirName:(NSString*)dirName imagetype:(NSString*)imagetype;

//检查文件是否存在，存在则返回图片，否则返回nil
+(id)checkImageUrl:(NSInteger)section row:(NSInteger)row dirName:(NSString*)dirName imagetype:(NSString*)imagetype;

//查询当前文件夹下有几个文件
+(NSMutableArray*)numberPicFromDir:(NSString*)dir section:(NSString*)section;

//改变颜色，并且改变大小
+(NSMutableAttributedString*)stringToAttributedStringWithColor_Font:(NSString*)string key:(NSString*)key CustomColor:(UIColor*)CustomColor;

//替换字典内的一些值
+(NSMutableDictionary*)replaceVAlueFromDic:(NSDictionary*)data shouldReplaceValue:(NSString*)shouldReplaceValue value:(NSString*)value;
@end
