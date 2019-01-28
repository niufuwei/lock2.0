//
//  XMMethod.m
//  xmjr
//
//  Created by laoniu on 2016/11/8.
//  Copyright © 2016年 xiaoma. All rights reserved.
//

#import "XMMethod.h"
#import "JSON.h"
#import <objc/runtime.h>
#include <sys/sysctl.h>
#import <CommonCrypto/CommonDigest.h>
#import "XMEncrypt.h"


@implementation XMMethod

+(id)stringManager:(id)obj
{
    if([XMMethod stringIsEmpty:obj])
    {
        return @"";
    }
    return obj;
}

+(BOOL)stringIsEmpty:(id)obj
{
    if(!obj)
    {
        return YES;
    }
    if([obj isKindOfClass:[NSString class]])
    {
        if([obj length] ==0)
        {
            
            return YES;
        }
        return NO;
    }
    else if([obj isKindOfClass:[NSNumber class]])
    {
        return NO;
    }
    else
    {
        if(obj ==nil || [obj isKindOfClass:[NSNull class]])
        {
            return YES;
        }
        return NO;
    }
}
+(void)alertErrorMessage:(id)obj
{
    [appDelegate.window makeToast:obj duration:2 position:CSToastPositionCenter];
}


+(BOOL)isString:(id)obj
{
    if (obj == nil) {
        return false;
    }
    if([obj isKindOfClass:[NSString class]])
    {
        return true;
    }
    return false;
}

/*!
 * @brief 判断是不是字符串
 * @param obj 要检测的obj
 * @return 是返回true，否则返回false
 */
+(BOOL)isDictionary:(id)obj
{
    if (obj == nil) {
        return false;
    }
    if([obj isKindOfClass:[NSDictionary class]])
    {
        return true;
    }
    return false;
}

+(void)hidenRequestText{
    [appDelegate.window hideToastActivity];
}
+(void)loadRequestText:(NSString*)text{
    [appDelegate.window makeToastActivity:nil];
    
    
}

/*!
 * @brief 字典转成字符串
 * @param obj 要转换的obj
 * @return 返回转换成功的字符串
 */
+(NSString*)dictionaryToString:(id)obj
{
    if (obj == nil) {
        return @"";
    }
    if([obj isKindOfClass:[NSString class]]){
        return obj;
    }
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

}

/*!
 * @brief 字符串转成字典
 * @param obj 要转换的obj
 * @return 返回转换成功的字典
 */
+(NSDictionary*)stringTodictionary:(id)obj
{
    if (obj == nil) {
        return nil;
    }
    
    NSData *jsonData = [obj dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return @{};
    }
    
//    NSMutableDictionary *
//    for(NSString * key in dic){
//        if([XMMethod isDictionary:dic[key]]){
//
//        }
//    }
    return dic;
}

+(NSString*)checkParam:(id)str
{
    if([self isNull:str]){
        return @"";
    }
    return [NSString stringWithFormat:@"%@",str];
}

+(NSNumber*)stringToInt:(id)str
{
    if([self isNull:str]){
        return [[NSNumber alloc] initWithInt:0];
    }
    return [[NSNumber alloc] initWithInt:[str integerValue]];
}




//改变颜色，并且改变大小
+(NSMutableAttributedString*)stringToAttributedStringWithColor_Font:(NSString*)string key:(NSString*)key CustomColor:(UIColor*)CustomColor
{
    NSMutableAttributedString * AttrString = [XMMethod stringToAttributedString:string key:key];
    NSRange range = [string rangeOfString:key];
    if(range.location != NSNotFound)
    {
        [AttrString addAttribute:NSForegroundColorAttributeName
                           value:CustomColor
                           range:NSMakeRange(range.location, range.length)];
    }
    
    
    return AttrString;
    
}

+(NSMutableAttributedString*)stringToAttributedString:(NSString*)str key:(NSString*)key
{
    NSString * temp_moneyString = str;
    NSMutableAttributedString * moneyString = [[NSMutableAttributedString alloc] initWithString:temp_moneyString];
    
    //设置字体属性
    NSRange range = [temp_moneyString rangeOfString:key];
    UIFont * font = [UIFont systemFontOfSize:14];
    if(range.location != NSNotFound)
    {
        [moneyString addAttribute:NSFontAttributeName value:(id)font range:NSMakeRange(range.location, str.length - range.location)];
        
    }
    
    return moneyString;
}

//检查是否有特殊字符
+ (BOOL)isHaveTeshuzifu:(NSString *)content{
    //提示 标签不能输入特殊字符
    NSString *str =@"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str];
    if (![emailTest evaluateWithObject:content]) {
        return YES;
    }
    return NO;
}

//检查是否有字母
+(BOOL)isHaveZimu:(NSString*)strFrom
{
    for(int i=0;i<strFrom.length;i++){
        
        unichar c=[strFrom characterAtIndex:i];
        
        if((c>'A'||c<'Z')||(c>'a'||c<'z'))
            
            return YES;
        
    }
    
    return NO;
}

/*!
 * @brief push控制器
 * @param vcName 要跳转的控制器 dic要传的参数
 * @return 无
 */
+ (void)runtimePush:(NSString *)vcName dic:(NSDictionary *)dic{
    //类名(对象名)
    
    NSString *class = vcName;
    
    const char *className = [class cStringUsingEncoding:NSASCIIStringEncoding];
    Class newClass = objc_getClass(className);
    if (!newClass) {
        //创建一个类
        Class superClass = [NSObject class];
        newClass = objc_allocateClassPair(superClass, className, 0);
        //注册你创建的这个类
        objc_registerClassPair(newClass);
    }
    // 创建对象(写到这里已经可以进行随机页面跳转了)
    id instance = [[newClass alloc] init];
    
    //下面是传值－－－－－－－－－－－－－－
    
    [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([self checkIsExistPropertyWithInstance:instance verifyPropertyName:key]) {
            //kvc给属性赋值
            NSLog(@"%@,%@",obj,key);
            [instance setValue:obj forKey:key];
            
            //            objc_getAssociatedObject(obj, (__bridge const void *)(key));
        }else {
            NSLog(@"不包含key=%@的属性",key);
        }
    }];
    
    
    // 获取导航控制器
    UINavigationController *pushClassStance = [XMMethod getCurrentVC].navigationController;

    // 跳转到对应的控制器
    [pushClassStance pushViewController:instance animated:YES];
    //    [nav pushViewController:instance animated:YES];
    
}


//日期加横杠
+(NSMutableString*)dateStringAdd:(NSString*)str{
    NSMutableString * string = [[NSMutableString alloc] initWithString:str];
    [string insertString:@"-" atIndex:4];
    [string insertString:@"-" atIndex:7];
    return string;
}


//更改view属性
+(void)viewMove:(id)x
              y:(id)y
          wdith:(id)wdith
         height:(id)height
           view:(UIView*)view {
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:.1 animations:^{
            CGRect frame = view.frame;
            frame.origin.x = x?[x floatValue]:view.frame.origin.x;
            frame.origin.y = y?[y floatValue]:view.frame.origin.y;
            frame.size.height = height?[height floatValue]:view.frame.size.height;
            frame.size.width = wdith?[wdith floatValue]:view.frame.size.width;
            view.frame = frame;
        }];
    });
    
}
/*!
 * @brief 检测对象是否存在该属性
 * @param instance自身 verifyPropertyName 属性
 * @return 有返回true ，无返回false
 */

+ (BOOL)checkIsExistPropertyWithInstance:(id)instance verifyPropertyName:(NSString *)verifyPropertyName
{
    unsigned int outCount, i;
    
    // 获取对象里的属性列表
    objc_property_t * properties = class_copyPropertyList([instance
                                                           class], &outCount);
    
    for (i = 0; i < outCount; i++) {
        objc_property_t property =properties[i];
        //  属性名转成字符串
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        // 判断该属性是否存在
        if ([propertyName isEqualToString:verifyPropertyName]) {
            free(properties);
            return YES;
        }
    }
    free(properties);
    
    // 再遍历父类中的属性
    Class superClass = class_getSuperclass([instance class]);
    
    //通过下面的方法获取属性列表
    unsigned int outCount2;
    objc_property_t *properties2 = class_copyPropertyList(superClass, &outCount2);
    
    for (int i = 0 ; i < outCount2; i++) {
        objc_property_t property2 = properties2[i];
        //  属性名转成字符串
        NSString *propertyName2 = [[NSString alloc] initWithCString:property_getName(property2) encoding:NSUTF8StringEncoding];
        // 判断该属性是否存在
        if ([propertyName2 isEqualToString:verifyPropertyName]) {
            free(properties2);
            return YES;
        }
    }
    free(properties2); //释放数组
    
    return NO;
}

//获取系统版本号
+(NSString *)getAppVersion{
    
    NSDictionary * dict = [[NSBundle mainBundle] infoDictionary];
    return [dict objectForKey:@"CFBundleShortVersionString"];
}

//获得设备型号
+ (NSString *)getCurrentDeviceModel
{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G (A1203)";
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G (A1241/A1324)";
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS (A1303/A1325)";
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4 (A1349)";
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S (A1387/A1431)";
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5 (A1428)";
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (A1429/A1442)";
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (A1456/A1532)";
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (A1453/A1533)";
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6 (A1549/A1586)";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G (A1213)";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421/A1509)";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G (A1432)";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G (A1454)";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G (A1455)";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    return platform;
}


+(NSString *)uuid{
    
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    NSString *cfuuidString = (NSString*)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, uuid));
    return cfuuidString;
}

+(void)saveUUID{
    
    [[NSUserDefaults standardUserDefaults]setObject:[XMMethod uuid] forKey:@"UUID"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

+(NSString *)getUUID{
    
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"UUID"];
    if ([XMMethod isNull:str])
        [XMMethod saveUUID];
    return str;
}

+(BOOL)isNull:(NSString *)str{
    str = [NSString stringWithFormat:@"%@",str];
    if(nil == str || [str isEqualToString:@""] || [str isEqualToString:@" "] || str ==NULL || !str || [str length]==0 || [str rangeOfString:@"(null)"].location !=NSNotFound|| [str rangeOfString:@"<null>"].location !=NSNotFound)
    {
        
        return YES;
    }
    
    return NO;
}


+(void)telPhone:(NSString*)phoneNumber{
    if([XMMethod isNull:phoneNumber]){
        
    }else{
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",phoneNumber];
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
        });
    }
   
}

#pragma mark-
#pragma mark------token methods------


+(NSString *)currentUserToken{
    
    //return  [NSString stringWithFormat:@"%@,%@,%@",@"1727",[XMMethods dateToStrLong:[NSDate date]],[XMBankMethods getUUID]];
    
    NSString *currentToken = [[NSUserDefaults standardUserDefaults]objectForKey:@"currentUserToken"];
    if ([XMMethod isNull:currentToken]) {
//        return  [NSString stringWithFormat:@"%@,%@,%@",@"",[XMMethod dateToStrLong:[NSDate date]],[XMMethod getUUID]];
        return nil;
    }
    return currentToken;
}

+(void)setUserToken:(NSString *)token{
    
    //[[NSUserDefaults standardUserDefaults]setObject:[XMEncrypt encrypt3DES:token key:[XMEncrypt get3DESKey]] forKey:@"currentUserToken"];
    [[NSUserDefaults standardUserDefaults]setObject:token forKey:@"currentUserToken"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

+(void)cleanUserToken{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"currentUserToken"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

+(BOOL)checkCurrentToken{
    NSString *currentToken = [self currentUserToken];
    NSArray *array = [currentToken componentsSeparatedByString:@","];
    
    NSString *str = [array firstObject];
    if ([self isNull:str]) {
        return NO;
    }
    return YES;
}


//button加下划线
+(NSMutableAttributedString*)buttonAddLine:(NSString*)string{
    NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:string];
    
    //设置下划线...
    /*
     NSUnderlineStyleNone                                    = 0x00, 无下划线
     NSUnderlineStyleSingle                                  = 0x01, 单行下划线
     NSUnderlineStyleThick NS_ENUM_AVAILABLE(10_0, 7_0)      = 0x02, 粗的下划线
     NSUnderlineStyleDouble NS_ENUM_AVAILABLE(10_0, 7_0)     = 0x09, 双下划线
     */
    [tncString addAttribute:NSUnderlineStyleAttributeName
                      value:@(NSUnderlineStyleSingle)
                      range:(NSRange){0,[tncString length]}];
    //此时如果设置字体颜色要这样
    [tncString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor]  range:NSMakeRange(0,[tncString length])];
    
    //设置下划线颜色...
    [tncString addAttribute:NSUnderlineColorAttributeName value:[UIColor blueColor] range:(NSRange){0,[tncString length]}];
    
    return tncString;
}

//判断手机号码格式是否正确
+ (BOOL)isPhone:(NSString *)mobile
{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
    {
        return NO;
    }else{
        
        return YES;
//        /**
//         * 移动号段正则表达式
//         */
//        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(170)\\d{8}$";
//        /**
//         * 联通号段正则表达式
//         */
//        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(170)\\d{8}$";
//        /**
//         * 电信号段正则表达式
//         */
//        NSString *CT_NUM = @"^((133)|(153)|(177)|(198)|(18[0,1,9]))\\d{8}$";
//        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
//        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
//        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
//        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
//        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
//        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
//
//        if (isMatch1 || isMatch2 || isMatch3) {
//            return YES;
//        }else{
//            return NO;
//        }
    }
}


+(NSString *)dateToStrLong:(NSDate *)date{
    return [self dateToStr:date withFormat:@"yyyy-MM-dd HH:mm:ss"];
}

+(NSString *)dateToStr:(NSDate *)date withFormat:(NSString *)format{
    if (nil == date)
        return nil;
    if (nil == format)
        format = @"yyyy-MM-dd";
    NSDateFormatter *f = [[NSDateFormatter alloc]init];
    [f setDateFormat:format];
    NSString *str = [f stringFromDate:date];
    return str;
}


+(NSArray *)arrayFromDictionary:(NSDictionary *)dic withKeyRank:(NSArray *)rankKeys{
    
    if (rankKeys.count > [dic allKeys].count) {
        return nil;
    }
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0; i < rankKeys.count; i++) {
        NSString *obj = [dic objectForKey:[rankKeys objectAtIndex:i]];
        [array addObject:obj];
    }
    return [NSArray arrayWithArray:array];
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


+(void)drawLine:(float)fromX fromY:(float)fromY toX:(float)toX  toY:(float)toY lineWidth:(NSInteger)lineWidth lineColor:(UIColor*)lineColor{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, lineWidth);  //线宽
    CGContextSetAllowsAntialiasing(context, true);
    CGContextSetRGBStrokeColor(context, 70.0 / 255.0, 241.0 / 255.0, 241.0 / 255.0, 1.0);  //线的颜色
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, fromX, fromY);  //起点坐标
    CGContextAddLineToPoint(context, toX, toY);   //终点坐标
    
    CGContextStrokePath(context);
}


//获取当前屏幕显示的viewcontroller
+(XMViewController *)getCurrentVC
{
    XMViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    XMViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    
    return currentVC;
}

//获取section
+(NSInteger)tagWithindexRow:(NSInteger)indexRow tag:(NSInteger)tag{    
    return (tag-indexRow)/100-1;
}

//获取row
+(NSInteger)getRowWithTagSection:(NSInteger)section tag:(NSInteger)tag{
    return tag - (section+1)*100;
}

//tag设置
+(NSInteger)tagWithIndexSection:(NSInteger)section indexRow:(NSInteger)indexRow{
    return (section+1)*100+indexRow;
}

//将数组内某些数据替换
+(NSMutableArray*)checkArray:(NSMutableArray*)dataArray keyValue:(NSDictionary*)keyValue replacKey:(NSString*)replacKey replacValue:(NSString *)replacValue
{
    NSMutableArray * tempArrayAll = [[NSMutableArray alloc] init];

    for(int i=0;i<[dataArray count];i++){
        NSLog(@"%ld",[dataArray[i] count]);
        NSLog(@"%@",dataArray[i]);
        NSMutableArray * tempArraySingle = [[NSMutableArray alloc] init];

        for(int j=0;j<[dataArray[i]count];j++){
            NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithDictionary:dataArray[i][j]];
            if([[dic objectForKey:[keyValue allKeys][0]] isEqualToString:keyValue[[keyValue allKeys][0]]]){
                [dic setObject:replacValue forKey:replacKey];
            }
            
            [tempArraySingle addObject:dic];
        }
        [tempArrayAll addObject:tempArraySingle];
    }
    
    return tempArrayAll;
}



+(NSString *)urlWithSection:(NSInteger)section indexRow:(NSInteger)indexRow dirName:(NSString*)dirName imagetype:(NSString*)imagetype{
//    NSString *path_document = NSHomeDirectory();
    //设置一个图片的存储路径
//    NSString *imagePath = [path_document stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@/%@%ld.jpg",dirName,[XMMethod getUUID],(section+1)*100+indexRow]];
    //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
    
    
    // 本地沙盒目录
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 得到本地沙盒中名为"MyImage"的路径，"MyImage"是保存的图片名
    NSString *imageFilePath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@/%@_%@_%ld_%ld.jpg",dirName,[XMMethod getUUID],imagetype,(section+1)*100+indexRow,section]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    

     [fileManager createDirectoryAtPath:[imageFilePath stringByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:nil error:nil];
    return imageFilePath;
}

+(NSMutableArray*)numberPicFromDir:(NSString*)dir section:(NSString*)section{
    // 本地沙盒目录
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 得到本地沙盒中名为"MyImage"的路径，"MyImage"是保存的图片名
    NSString *imageFilePath = [path stringByAppendingPathComponent:dir];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString * setionString ;

    
    NSDirectoryEnumerator<NSString *> * myDirectoryEnumerator;
    
    myDirectoryEnumerator=  [fileManager enumeratorAtPath:imageFilePath];
    
    NSMutableArray * iamgeUrl = [[ NSMutableArray alloc] init];
    
    while (imageFilePath = [myDirectoryEnumerator nextObject]) {
        
        
        for (NSString * namePath in imageFilePath.pathComponents) {
            //截取-后面的section
            if([namePath rangeOfString:@"_" options:NSBackwardsSearch].location !=NSNotFound){
                setionString = [namePath substringWithRange:NSMakeRange([imageFilePath rangeOfString:@"_" options:NSBackwardsSearch].location+1, [namePath length]-[imageFilePath rangeOfString:@"_" options:NSBackwardsSearch].location-1-4)];
                if([setionString isEqualToString:section]){
                    [iamgeUrl addObject:[[path stringByAppendingPathComponent:dir] stringByAppendingPathComponent:namePath]];
                }
            }
            
            NSLog(@"-----AAA-----%@", namePath);
            
        }
        
    }
    
    return iamgeUrl;
    
}

//获取文件名字
+(NSMutableArray*)namePicFromDir:(NSString*)dir section:(NSString*)section{
    // 本地沙盒目录
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 得到本地沙盒中名为"MyImage"的路径，"MyImage"是保存的图片名
    NSString *imageFilePath = [path stringByAppendingPathComponent:dir];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString * setionString ;
    
    
    NSDirectoryEnumerator<NSString *> * myDirectoryEnumerator;
    
    myDirectoryEnumerator=  [fileManager enumeratorAtPath:imageFilePath];
    
    NSMutableArray * iamgeUrl = [[ NSMutableArray alloc] init];
    
    while (imageFilePath = [myDirectoryEnumerator nextObject]) {
        
        
        for (NSString * namePath in imageFilePath.pathComponents) {
            //截取-后面的section
            if([namePath rangeOfString:@"_" options:NSBackwardsSearch].location !=NSNotFound){
                setionString = [namePath substringWithRange:NSMakeRange([imageFilePath rangeOfString:@"_" options:NSBackwardsSearch].location+1, [namePath length]-[imageFilePath rangeOfString:@"_" options:NSBackwardsSearch].location-1-4)];
                if([setionString isEqualToString:section]){
                    [iamgeUrl addObject:namePath];
                }
            }
            
            NSLog(@"-----AAA-----%@", namePath);
            
        }
        
    }
    
    return iamgeUrl;
    
}

+(BOOL)imageIsExit:(NSString*)imageUrl{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:imageUrl]) {
        return YES;
    }
    else {
        return NO;
    }
}

+(id)checkImageUrl:(NSInteger)section row:(NSInteger)row dirName:(NSString*)dirName imagetype:(NSString*)imagetype{
    if([self imageIsExit:[self urlWithSection:section indexRow:row dirName:dirName imagetype:imagetype]]){
        //检查本地如果存在则读取
        return [UIImage imageWithContentsOfFile:[self urlWithSection:section indexRow:row dirName:dirName imagetype:imagetype]];
    }else{
        //没有则返回空
        return nil;
    }
}


//插入一些数据到数组之中
+(NSMutableArray*)insertData:(NSArray*)dataArray sourceArray:(NSMutableArray*)sourceArray sectionIndex:(NSInteger)sectionIndex
{
    NSMutableArray * tempArraySingle = [[NSMutableArray alloc] init];

    for(int i=0;i<[sourceArray count];i++){
        
        if(i==sectionIndex){
            
            NSMutableArray * tempArrayAllAdd = [[NSMutableArray alloc] initWithArray:sourceArray[sectionIndex]];
            
            for(id data in dataArray){
                [tempArrayAllAdd addObject:data];
            }
          
            [tempArraySingle addObject:tempArrayAllAdd];
        }else{
            [tempArraySingle addObject:sourceArray[i]];
        }
        
    }
    
    return tempArraySingle;
}


//从数组中删除一些数据
+(NSMutableArray*)removeData:(NSArray*)dataArray sourceArray:(NSMutableArray*)sourceArray sectionIndex:(NSInteger)sectionIndex
{
    NSMutableArray * tempArraySingle = [[NSMutableArray alloc] init];
    
    for(int i=0;i<[sourceArray count];i++){
        
        if(i==sectionIndex){
            
            NSMutableArray * tempArrayAllAdd = [[NSMutableArray alloc] initWithArray:sourceArray[sectionIndex]];
            
            if([tempArrayAllAdd count]!=1)
            {
                
                [tempArrayAllAdd removeObjectsInRange:NSMakeRange(1, [dataArray count])];
            }
            
            [tempArraySingle addObject:tempArrayAllAdd];
        }else{
            [tempArraySingle addObject:sourceArray[i]];
        }
        
    }
    
    return tempArraySingle;
}

//从数组中删除一些数据
+(NSMutableArray*)removeData2:(NSArray*)dataArray sourceArray:(NSMutableArray*)sourceArray sectionIndex:(NSInteger)sectionIndex
{
    NSMutableArray * tempArraySingle = [[NSMutableArray alloc] init];
    
    for(int i=0;i<[sourceArray count];i++){
        
        if(i==sectionIndex){
            
            NSMutableArray * tempArrayAllAdd = [[NSMutableArray alloc] initWithArray:sourceArray[sectionIndex]];
            
            if([tempArrayAllAdd count]!=1)
            {
                
                [tempArrayAllAdd removeObjectsInRange:NSMakeRange(2, [dataArray count])];
            }
            
            [tempArraySingle addObject:tempArrayAllAdd];
        }else{
            [tempArraySingle addObject:sourceArray[i]];
        }
        
    }
    
    return tempArraySingle;
}


//取出tag对应的key值
+(NSString*)getVAlueFromArray:(NSMutableArray*)dataArray keyValue:(NSDictionary*)keyValue getKey:(NSString*)getKey
{
    NSString * value = @"";
    BOOL next = false;
    
    for(int i=0;i<[dataArray count];i++){
        
        for(int j=0;j<[dataArray[i]count];j++){
            NSMutableDictionary * dic = [[NSMutableDictionary alloc] initWithDictionary:dataArray[i][j]];
            if([[dic objectForKey:[keyValue allKeys][0]] isEqualToString:keyValue[[keyValue allKeys][0]]]){
//                [dic setObject:replacValue forKey:replacKey];
                value = dic[getKey];
                next = false;
                break;
            }
            value = @"";
            next = true;
        }
        if(!next)
            break;
    }
    
    return value;
}

//替换字典内的一些值
+(NSMutableDictionary*)replaceVAlueFromDic:(NSDictionary*)data shouldReplaceValue:(NSString*)shouldReplaceValue value:(NSString*)value
{
    BOOL next = false;
    NSMutableDictionary * dataDic = [[NSMutableDictionary alloc] init];
    
    for(NSString*key in [data allKeys]){
        if( [[data objectForKey:key] isEqualToString:shouldReplaceValue]){
            [dataDic setObject:value forKey:key];
        }
        else{
            [dataDic setObject:data[key] forKey:key];
        }
    }
    
    return dataDic;
}

+(XMViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    XMViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        // 根视图为非导航类
        
        currentVC = rootVC;
    }
    
    return currentVC;
}

+(void)modifyViewRoundView:(UIView*)view corners:(UIRectCorner)corners{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(7,7)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}
@end
