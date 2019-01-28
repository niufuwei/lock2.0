//
//  BAUserStateDataModel.h
//  borrowApp
//
//  Created by laoniu on 2016/11/23.
//  Copyright © 2016年 xiaoma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMUserStateDataModel : NSObject

typedef NS_ENUM(NSInteger,userLoginState) {
    USER_LOGIN_SUCCESS_STATE = 1,
    USER_LOGIN_FAILD_STATE = 0
};


+(instancetype)shareInstance;

//是否登录
@property (nonatomic,assign) BOOL isLogin;


@end
