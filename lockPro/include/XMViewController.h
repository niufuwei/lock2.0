//
//  XMViewController.h
//  xmjr
//
//  Created by laoniu on 16/5/23.
//  Copyright © 2016年 xiaoma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMNavCustom.h"

@interface XMViewController : UIViewController

@property (nonatomic,strong) UIView * baseView;

//隐藏导航栏
-(void)hidenNavigationWithAnimation:(BOOL)animation;

//隐藏tabbar
-(void)hidenTabbarWithAnimation:(BOOL)animation;

//显示导航栏
-(void)showNavigationWithAnimation:(BOOL)animation;

//显示tabbar
-(void)showTabbarWithAnimation:(BOOL)animation;

@property (nonatomic,strong) UIScrollView * bgScrollview;
@property (nonatomic,strong)  UIImageView * bgView;



@end
