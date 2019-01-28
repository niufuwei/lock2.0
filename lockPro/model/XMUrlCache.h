//
//  XMUrlCache.h
//  xmjr
//
//  Created by laoniu on 2016/11/16.
//  Copyright © 2016年 xiaoma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BAUrlCache : NSObject
@property (strong, nonatomic) NSURLCache *urlCache;
@property (strong, nonatomic) NSURL *url;
@property (copy, nonatomic) NSString *requestUrl;
@property (strong, nonatomic) NSMutableURLRequest *request;

@end
