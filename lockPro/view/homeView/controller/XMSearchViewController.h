//
//  XMSearchViewController.h
//  lockPro
//
//  Created by 牛付威 on 2018/5/28.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "XMTableViewController.h"

typedef NS_ENUM(NSInteger, searchType){
    SEARCH_FRIEND,//搜索好友
    SEARCH_ADD_FRIEND//添加好友
};

@interface XMSearchViewController : UIViewController

@property (nonatomic,assign) searchType type;

@end
