//
//  XMButton.h
//  XM_Bank
//
//  Created by admin on 14-6-13.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMBarButtonItem.h"

@interface XMButton : UIButton
@property (nonatomic, assign) XMBarButtonItem *item;
@property (nonatomic, assign) NSUInteger index;
@end
