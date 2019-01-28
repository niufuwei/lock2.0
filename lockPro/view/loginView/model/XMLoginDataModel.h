//
//  XMLoginDataModel.h
//  xmjr
//
//  Created by laoniu on 2016/11/8.
//  Copyright © 2016年 xiaoma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLoginDataModel : JSONModel

@property (nonatomic,copy) NSString * username;
@property (nonatomic,copy) NSString * password;
@property (nonatomic,copy) NSString * appTokenKey;

+(instancetype)shareInstance;

@end
