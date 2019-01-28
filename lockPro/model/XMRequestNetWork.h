//
//  XMRequestNetWork.h
//  xmjr
//
//  Created by laoniu on 2016/11/8.
//  Copyright © 2016年 xiaoma. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,requestType) {
    GET,
    POST
};

typedef void (^result)(id resultString ,NSURLResponse * response);
typedef void (^error)(NSError * except,NSURLResponse * response);

@interface XMRequestNetWork : NSObject

@property (nonatomic,copy) result back_success;
@property (nonatomic,copy) error back_error;

+(void)writeData:(NSDictionary*)data method:(requestType)method resultS:(result)resultS err:(error)err;
+(void)cancelRequestNetWork;
@end
