//
//  XMModifyNameView.h
//  lockPro
//
//  Created by 牛付威 on 2018/5/31.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "XMViewController.h"


@interface XMModifyNameView : XMViewController

@property (nonatomic,copy,nullable) void(^backModifyName)(NSString*nickName);

@end
