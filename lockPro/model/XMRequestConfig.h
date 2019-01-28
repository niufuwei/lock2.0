//
//  XMRequestConfig.h
//  xmjr
//
//  Created by laoniu on 2017/12/13.
//  Copyright © 2017年 xiaoma. All rights reserved.
//

#import <Foundation/Foundation.h>

//@class AFHTTPRequestOperationManager;

@interface XMRequestConfig : NSObject

//+(AFHTTPRequestOperationManager*)getOperationManager;
+(NSMutableURLRequest*)getRequestWithurl:(NSString *)url parameter:(id)parameter;
@end
