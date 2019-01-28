//
//  XMFriendModel.h
//  lockPro
//
//  Created by laoniu on 2018/6/6.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "JSONModel.h"

@interface XMFriendModel : JSONModel

@property (nonatomic,copy) NSString * account;
@property (nonatomic,copy) NSString * gName;
@property (nonatomic,copy) NSString * isBinding;
@property (nonatomic,copy) NSString * logTime;
@property (nonatomic,copy) NSString * nickName;
@property (nonatomic,copy) NSString * regTime;
@property (nonatomic,copy) NSString * userID;
@property (nonatomic,copy) NSString * userRole;
@property (nonatomic,copy) NSString * key;//姓名首字母

@end
