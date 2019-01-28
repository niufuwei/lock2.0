//
//  XMRequestNetWork.m
//  xmjr
//
//  Created by laoniu on 2016/11/8.
//  Copyright © 2016年 xiaoma. All rights reserved.
//

#import "XMRequestNetWork.h"
#import "AFNetworking.h"
#import "UIProgressView+AFNetworking.h"

@interface XMRequestNetWork ()<NSURLConnectionDelegate,NSURLConnectionDataDelegate>

@property (nonatomic,strong) NSURLSessionDataTask *operation; //post请求的队列链接
@property (nonatomic,strong) NSMutableArray * requestArray;
@property (nonatomic,assign) BOOL isRequested;//是否正在请求
@property (nonatomic,assign) requestType type;
@property (nonatomic, strong) AFSecurityPolicy *securityPolicy;
@end

@implementation XMRequestNetWork


static XMRequestNetWork * request = nil;

+(instancetype)shareRequest
{
    @synchronized (self) {
        if(!request){
            request = [[self alloc] init];
            request.securityPolicy = [AFSecurityPolicy defaultPolicy];
            request.securityPolicy.allowInvalidCertificates = YES;
            //            [AFHTTPRequestOperationManager manager].securityPolicy = securityPolicy;
            [XMRequestNetWork shareRequest].requestArray = [[NSMutableArray alloc] init];
            
           
            
//            [XMRequestNetWork shareRequest].custompro.hidden = YES;
        }
    }
    return request;
}

+(void)writeData:(NSDictionary*)data method:(requestType)method resultS:(result)resultS err:(error)err
{
    //        [[BARequestNetWork shareRequest] netWorkStatus];
    [XMRequestNetWork shareRequest].back_success = resultS;
    [XMRequestNetWork shareRequest].back_error = err;
    [XMRequestNetWork shareRequest].type = method;
//    [[XMRequestNetWork shareRequest].requestArray addObject:data];
//    if([XMRequestNetWork shareRequest].isRequested) {
//        [self cancelRequestNetWork];
//    }
//    [[XMRequestNetWork shareRequest].requestArray removeObjectAtIndex:0];
    switch ([XMRequestNetWork shareRequest].type) {
        case POST:
            [XMRequestNetWork postData:[data objectForKey:@"type"]
                             parameter:[data objectForKey:@"obj"] isPOST:YES];
            break;
        case GET:
            //                [XMRequestNetWork getData:[data objectForKey:@"type"] parameter:[data objectForKey:@"obj"]];
            [XMRequestNetWork getData:[data objectForKey:@"type"]
                             parameter:[data objectForKey:@"obj"]];
            break;
        default:
            break;
    }
//    [self checkRequest];

}

+(void)checkRequest{
    
    //    if(![BARequestNetWork shareRequest].isRequested){
    if([[XMRequestNetWork shareRequest].requestArray count]!=0){
        NSDictionary * data = [[XMRequestNetWork shareRequest].requestArray firstObject];
        [[XMRequestNetWork shareRequest].requestArray removeObjectAtIndex:0];
        switch ([XMRequestNetWork shareRequest].type) {
            case POST:
                [XMRequestNetWork postData:[data objectForKey:@"type"]
                                 parameter:[data objectForKey:@"obj"] isPOST:YES];
                break;
            case GET:
//                [XMRequestNetWork getData:[data objectForKey:@"type"] parameter:[data objectForKey:@"obj"]];
                [XMRequestNetWork postData:[data objectForKey:@"type"]
                                 parameter:[data objectForKey:@"obj"] isPOST:NO];
                break;
            default:
                break;
        }
        
    }
    
    //    }
    //    else{
    ////        [BARequestNetWork cancelRequestNetWork];
    //    }
}

+(BOOL)isFileCheckParamer:(id)parmer{
    if([parmer isKindOfClass:[NSString class]]){
        return NO;
    }
    if([parmer isKindOfClass:[NSArray class]]){
        return NO;
    }
    for(NSString * key in [parmer allKeys]){
        if([key isEqualToString:@"filePost"])
            return YES;
    }
    return NO;
}

/**
 *  post请求
 */

+(void)postData:(NSString *)url parameter:(id)parameter isPOST:(BOOL)isPOST
{
    //    NSDictionary *dic = @{@"version_code":@"11",@"phonetype":@"11"};
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.securityPolicy = [XMRequestNetWork shareRequest].securityPolicy;
    [XMRequestNetWork shareRequest].isRequested = true;
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //    manager.requestSerializer.timeoutInterval = 20.0f;
    // 2.设置请求头
    //    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    
    
    AFHTTPResponseSerializer *responseSerializer = [AFHTTPResponseSerializer serializer];
    responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                 @"text/html",
                                                 @"text/json",
                                                 @"text/javascript",
                                                 @"text/plain",
                                                 nil];
    manager.responseSerializer = responseSerializer;
    

    //检查请求类型
//    if([self isFileCheckParamer:parameter]){
//        //如果是文件上传则调用
//        [self postFile:[NET_WORK_CONNECT_ADDR_IP stringByAppendingString:url] parameter:parameter manager:manager];
//    }else{
    
        
        NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:isPOST?@"POST":@"GET" URLString:url parameters:parameter error:nil];
        request.timeoutInterval= 60;
    
    
//        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        // 设置body
//        NSData *data = [NSJSONSerialization dataWithJSONObject:parameter options:NSJSONWritingPrettyPrinted error:nil];
//        [request setHTTPBody:data];
//        if([XMMethod currentUserToken])
//            [request setValue:[XMMethod currentUserToken] forHTTPHeaderField:@"token"];
        //    NSLog(@"%@",[XMMethod currentUserToken]);
        //        [manager.requestSerializer setValue:[XMMethod currentUserToken] forHTTPHeaderField:@"Authorization"];
        
        NSLog(@"发起请求的连接>>%@",request.URL);
           NSURLSessionDataTask * task = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                
                if (!error) {
                    [XMRequestNetWork shareRequest].back_success([XMRequestNetWork toJsonStringFromData:responseObject],response);
                    [XMRequestNetWork shareRequest].isRequested = false;
//                    [self checkRequest];
                    
                } else {
                    [XMRequestNetWork shareRequest].back_error(error,response);
                    //            [MBProgress hideHud];
                    [XMRequestNetWork shareRequest].isRequested = false;
//                    [self checkRequest];
                }
//               dispatch_semaphore_signal(semaphore);

            }];
        
        [task resume];
        

       
//    }
    
}



/**
 *  get请求
 */
+(void)getData:(NSString *)urlPath parameter:(id)parameter
{
    //    NSDictionary *dic = @{@"version_code":@"11",@"phonetype":@"11"};
    
    
    NSString *path = [NET_WORK_CONNECT_ADDR_IP stringByAppendingString:urlPath];
    //如果网址中出现了 中文 需要进行URL编码
    path = [path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL *url = [NSURL URLWithString:path];
    //创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    if([XMMethod currentUserToken])
        [request setValue:[XMMethod currentUserToken] forHTTPHeaderField:@"token"];
    //创建网络会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    //创建数据任务  系统会自动开启一个子线程
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
           
            dispatch_async(dispatch_get_main_queue(), ^{
                [XMRequestNetWork shareRequest].back_success([XMRequestNetWork toJsonStringFromData:data],response);
                [XMRequestNetWork shareRequest].isRequested = false;
                //                    [self checkRequest];
            });
            
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [XMRequestNetWork shareRequest].back_error(error,response);
                //            [MBProgress hideHud];
                [XMRequestNetWork shareRequest].isRequested = false;
                //                    [self checkRequest];
            });
        }
    }];
    //开始任务
    [dataTask resume];
    
    
}

//
//
//+(void)postFile:(NSString *)url parameter:(id)parameter manager:(AFHTTPSessionManager*)manager{
//    if([parameter objectForKey:@"typeName"] && [[parameter objectForKey:@"typeName"] isEqualToString:@"youyangCard"]){
//        NSMutableDictionary * tempImageDic = [[NSMutableDictionary alloc] initWithDictionary:parameter];
//
//        [tempImageDic removeObjectForKey:@"fronBase64"];
//        [tempImageDic removeObjectForKey:@"backBase64"];
//        [tempImageDic removeObjectForKey:@"filePost"];
//        [tempImageDic removeObjectForKey:@"typeName"];
//
//
//
//        NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:tempImageDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//
//            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//            // 设置时间格式
//            [formatter setDateFormat:@"yyyyMMddHHmmss"];
//
//            NSString *dateString = [formatter stringFromDate:[NSDate date]];
//            NSString *fileName = [NSString  stringWithFormat:@"%@.jpg", dateString];
//
//            [formData appendPartWithFileData:parameter[@"fronBase64"] name:@"fronBase64" fileName:fileName mimeType:@"image/jpeg"]; //
//
//
//            NSString *dateString2 = [formatter stringFromDate:[NSDate date]];
//            NSString *fileName2 = [NSString  stringWithFormat:@"%@.jpg", dateString2];
//
//            [formData appendPartWithFileData:parameter[@"backBase64"] name:@"backBase64" fileName:fileName2 mimeType:@"image/jpeg"]; //
//
//
//        } error:nil];
//
//        NSProgress *progress = nil;
//        [[XMMethod getCurrentVC].view hideToastActivity];
//        [appDelegate.progress showProgress];
//        appDelegate.progress.progress = 2;
//
//        NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:&progress completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
//
//            [appDelegate.progress hideProgress];
//
//            if(!error){
//                [XMRequestNetWork shareRequest].back_success([XMRequestNetWork toJsonStringFromData:responseObject],response);
//                [XMRequestNetWork shareRequest].isRequested = false;
//                [self checkRequest];
//            }else{
//                [XMRequestNetWork shareRequest].back_error(error,response);
//                //            [MBProgress hideHud];
//                [XMRequestNetWork shareRequest].isRequested = false;
//                [self checkRequest];
//            }
//
//        }];
//        [uploadTask resume];
//
//
//        [progress addObserver:[XMRequestNetWork shareRequest] forKeyPath:@"fractionCompleted" options:NSKeyValueObservingOptionNew context:nil];
//
//    }
//    else if([parameter objectForKey:@"type"]){
//        NSMutableDictionary * tempImageDic = [[NSMutableDictionary alloc] initWithDictionary:parameter];
//
//        [tempImageDic removeObjectForKey:@"imageData"];
//
//
//        NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:tempImageDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//
//            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//            // 设置时间格式
//            [formatter setDateFormat:@"yyyyMMddHHmmss"];
//
//            NSString *dateString = [formatter stringFromDate:[NSDate date]];
//            NSString *fileName = [NSString  stringWithFormat:@"%@.jpg", dateString];
//
//            [formData appendPartWithFileData:parameter[@"imageData"] name:@"upload" fileName:fileName mimeType:@"image/jpeg"]; //
//
//
//        } error:nil];
//
//        NSProgress *progress = nil;
//        [[XMMethod getCurrentVC].view hideToastActivity];
//        [appDelegate.progress showProgress];
//        appDelegate.progress.progress = 2;
//
//        NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:&progress completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
//
//            [appDelegate.progress hideProgress];
//
//            if(!error){
//                [XMRequestNetWork shareRequest].back_success([XMRequestNetWork toJsonStringFromData:responseObject],response);
//                [XMRequestNetWork shareRequest].isRequested = false;
//                [self checkRequest];
//            }else{
//                [XMRequestNetWork shareRequest].back_error(error,response);
//                //            [MBProgress hideHud];
//                [XMRequestNetWork shareRequest].isRequested = false;
//                [self checkRequest];
//            }
//
//        }];
//        [uploadTask resume];
//
//
//        [progress addObserver:[XMRequestNetWork shareRequest] forKeyPath:@"fractionCompleted" options:NSKeyValueObservingOptionNew context:nil];
//
//    }
//    else if([parameter objectForKey:@"loanImageArray"]){
//        //调查上传多张图片
//
//        NSMutableDictionary * tempImageDic = [[NSMutableDictionary alloc] initWithDictionary:parameter];
//
//        [tempImageDic removeObjectForKey:@"loanImageArray"];
//
//        [manager POST:url parameters:tempImageDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//
//
//            for(int i =0;i< [[parameter objectForKey:@"loanImageArray"] count] ;i++){
//                NSData *reader = [NSData dataWithContentsOfFile:[parameter objectForKey:@"loanImageArray"][i]];
//
//                NSString * imageName = @"";
//                if([[parameter objectForKey:@"loanImageArray"][i] rangeOfString:@".jpg"].location!=NSNotFound)
//                {
//
//                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//                    // 设置时间格式
//                    [formatter setDateFormat:@"yyyyMMddHHmmss"];
//
//                    NSString *dateString = [formatter stringFromDate:[NSDate date]];
//
//
//                    imageName = [NSString stringWithFormat:@"%@%d.jpg",dateString,i];
//                }
//
//
//
//                [formData appendPartWithFileData:reader name:[NSString stringWithFormat:@"%@%d",[parameter objectForKey:@"loanImageArray"][i],i] fileName:imageName mimeType:@"image/jpeg"]; //
//
//            }
//
//        } success:^(NSURLSessionDataTask *task, id responseObject) {
//            [XMRequestNetWork shareRequest].back_success([XMRequestNetWork toJsonStringFromData:responseObject],task.response);
//            [XMRequestNetWork shareRequest].isRequested = false;
//            [self checkRequest];
//
//        } failure:^(NSURLSessionDataTask *task, NSError *error) {
//
//            [XMRequestNetWork shareRequest].back_error(error,task.response);
//            //            [MBProgress hideHud];
//            [XMRequestNetWork shareRequest].isRequested = false;
//            [self checkRequest];
//        }];
//    }
//    else if([parameter objectForKey:@"imageArray"]){
//        //调查上传多张图片
//
//        NSMutableDictionary * tempImageDic = [[NSMutableDictionary alloc] initWithDictionary:parameter];
//
//        [tempImageDic removeObjectForKey:@"imageArray"];
//
//
//        NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:tempImageDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//
//            for(int i =0;i< [[parameter objectForKey:@"imageArray"] count] ;i++){
//                NSData *reader = [NSData dataWithContentsOfFile:[parameter objectForKey:@"imageArray"][i][@"imageUrl"]];
//
//                NSString * imageName = @"";
//                if([[parameter objectForKey:@"imageArray"][i][@"fileName"] rangeOfString:@".jpg"].location!=NSNotFound)
//                {
//                    imageName = [parameter objectForKey:@"imageArray"][i][@"fileName"];
//                    imageName = [imageName stringByReplacingOccurrencesOfString:@".jpg"withString:@""];
//                    imageName = [NSString stringWithFormat:@"%@%@.jpg",[parameter objectForKey:@"imageArray"][i][@"postName"],imageName];
//                }
//
//
//
//                [formData appendPartWithFileData:reader name:[NSString stringWithFormat:@"%@%d",[parameter objectForKey:@"imageArray"][i][@"postName"],i+1] fileName:imageName mimeType:@"image/jpeg"]; //
//
//            }
//
//
//
//        } error:nil];
//
//        NSProgress *progress = nil;
//        [[XMMethod getCurrentVC].view hideToastActivity];
//        [appDelegate.progress showProgress];
//        appDelegate.progress.progress = 2;
//
//        NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:&progress completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
//
//           [appDelegate.progress hideProgress];
//
//            if(!error){
//                [XMRequestNetWork shareRequest].back_success([XMRequestNetWork toJsonStringFromData:responseObject],response);
//                [XMRequestNetWork shareRequest].isRequested = false;
//                [self checkRequest];
//            }else{
//                [XMRequestNetWork shareRequest].back_error(error,response);
//                //            [MBProgress hideHud];
//                [XMRequestNetWork shareRequest].isRequested = false;
//                [self checkRequest];
//            }
//
//        }];
//        [uploadTask resume];
//
//
//
//        [progress addObserver:[XMRequestNetWork shareRequest] forKeyPath:@"fractionCompleted" options:NSKeyValueObservingOptionNew context:nil];
//
//
////        [manager POST:url parameters:tempImageDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
////
////
////            for(int i =0;i< [[parameter objectForKey:@"imageArray"] count] ;i++){
////                NSData *reader = [NSData dataWithContentsOfFile:[parameter objectForKey:@"imageArray"][i][@"imageUrl"]];
////
////                NSString * imageName = @"";
////               if([[parameter objectForKey:@"imageArray"][i][@"fileName"] rangeOfString:@".jpg"].location!=NSNotFound)
////               {
////                   imageName = [parameter objectForKey:@"imageArray"][i][@"fileName"];
////                  imageName = [imageName stringByReplacingOccurrencesOfString:@".jpg"withString:@""];
////                   imageName = [NSString stringWithFormat:@"%@%@.jpg",[parameter objectForKey:@"imageArray"][i][@"postName"],imageName];
////               }
////
////
////
////                [formData appendPartWithFileData:reader name:[NSString stringWithFormat:@"%@%d",[parameter objectForKey:@"imageArray"][i][@"postName"],i+1] fileName:imageName mimeType:@"image/jpeg"]; //
////
////            }
////
////        } success:^(NSURLSessionDataTask *task, id responseObject) {
////            [XMRequestNetWork shareRequest].back_success([XMRequestNetWork toJsonStringFromData:responseObject],task.response);
////            [XMRequestNetWork shareRequest].isRequested = false;
////            [self checkRequest];
////
////        } failure:^(NSURLSessionDataTask *task, NSError *error) {
////
////            [XMRequestNetWork shareRequest].back_error(error,task.response);
////            //            [MBProgress hideHud];
////            [XMRequestNetWork shareRequest].isRequested = false;
////            [self checkRequest];
////        }];
//
//    }
//    else{
//        NSMutableDictionary * tempImageDic = [[NSMutableDictionary alloc] initWithDictionary:parameter];
//
//        NSString * image1;
//        NSString * image2;
//        if(tempImageDic[@"fbase64Img"]){
//            image1 = @"fbase64Img";
//        }
//        if(tempImageDic[@"zbase64Img"]){
//            image2 = @"zbase64Img";
//        }
//
//        if(tempImageDic[@"creditImg"])
//        {
//            image1 = @"creditImg";
//        }
//        if(tempImageDic[@"headportraitImg"])
//        {
//            image2 = @"headportraitImg";
//        }
//
//        [tempImageDic removeObjectForKey:image1];
//        [tempImageDic removeObjectForKey:image2];
//
//
//        NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:url parameters:tempImageDic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//
//            NSMutableDictionary * imageDic = [[NSMutableDictionary alloc] initWithDictionary:parameter];
//
//            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//            // 设置时间格式
//            [formatter setDateFormat:@"yyyyMMddHHmmss"];
//
//            NSString *dateString = [[formatter stringFromDate:[NSDate date]] stringByAppendingString:image1];
//            NSString *fileName = [NSString  stringWithFormat:@"%@.jpg", dateString];
//            [formData appendPartWithFileData:imageDic[image1] name:@"upload" fileName:fileName mimeType:@"image/jpeg"]; //
//            [imageDic removeObjectForKey:image1];
//
//
//            NSString *dateString2 = [[formatter stringFromDate:[NSDate date]] stringByAppendingString:image2];
//            NSString *fileName2 = [NSString  stringWithFormat:@"%@.jpg", dateString2];
//            [formData appendPartWithFileData:imageDic[image2] name:@"upload2" fileName:fileName2 mimeType:@"image/jpeg"]; //
//            [imageDic removeObjectForKey:image2];
//
//
//
//        } error:nil];
//
//        NSProgress *progress = nil;
//        [[XMMethod getCurrentVC].view hideToastActivity];
//        [appDelegate.progress showProgress];
//        appDelegate.progress.progress = 2;
//
//        NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:&progress completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
//
//            [appDelegate.progress hideProgress];
//
//            if(!error){
//                [XMRequestNetWork shareRequest].back_success([XMRequestNetWork toJsonStringFromData:responseObject],response);
//                [XMRequestNetWork shareRequest].isRequested = false;
//                [self checkRequest];
//            }else{
//                [XMRequestNetWork shareRequest].back_error(error,response);
//                //            [MBProgress hideHud];
//                [XMRequestNetWork shareRequest].isRequested = false;
//                [self checkRequest];
//            }
//
//        }];
//        [uploadTask resume];
//
//
//        [progress addObserver:[XMRequestNetWork shareRequest] forKeyPath:@"fractionCompleted" options:NSKeyValueObservingOptionNew context:nil];
//
//    }
//}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    NSProgress *progress = nil;
    if ([object isKindOfClass:[NSProgress class]]) {
        progress = (NSProgress *)object;
    }
    if (progress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // 在主线程中更新 UI
            NSLog(@"%f",progress.fractionCompleted);
            appDelegate.progress.progress = progress.fractionCompleted*100;
        });
    }
}

+(id)toJsonStringFromData:(NSData *)receiveData{
    NSString *receiveStr = [[NSString alloc]initWithData:receiveData encoding:NSUTF8StringEncoding];
    NSData * data = [receiveStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    return jsonDict;
}

+(void)cancelRequestNetWork{
    [[XMRequestNetWork shareRequest].operation cancel];

}


@end


