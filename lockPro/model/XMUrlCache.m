//
//  XMUrlCache.m
//  xmjr
//
//  Created by laoniu on 2016/11/16.
//  Copyright © 2016年 xiaoma. All rights reserved.
//

#import "XMUrlCache.h"

@implementation BAUrlCache

-(void)XM_Cache
{
    self.urlCache = [NSURLCache sharedURLCache];
    [self.urlCache setMemoryCapacity:1*1024*1024];
    
    //创建一个nsurl
    self.url = [NSURL URLWithString:self.requestUrl];
    //创建一个请求
    self.request=[NSMutableURLRequest requestWithURL:self.url
                                         cachePolicy:NSURLRequestReloadRevalidatingCacheData
                                     timeoutInterval:30.0f];
}


-(void)XM_readCacheMemory
{
    //从请求中获取缓存输出
    NSCachedURLResponse *response =[self.urlCache cachedResponseForRequest:self.request];
    //判断是否有缓存
    if (response != nil){
        NSLog(@"如果有缓存输出，从缓存中获取数据");
        [self.request setCachePolicy:NSURLRequestReturnCacheDataDontLoad];
    }
}

@end
