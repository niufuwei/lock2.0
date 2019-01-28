//
//  tabbarViewController.h
//  artists
//
//  Created by niufuwei on 13-12-15.
//  Copyright (c) 2013年 niufuwei. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface XMTabbarViewController : UITabBarController
{
//@private
    UIImageView * tabbarBG;
    UIImageView * itemBG;
    UILabel     * countLabel;
    NSInteger     currentPage;
    NSInteger     count;
}

-(void)createCustomTabBar;
-(void)showTabBar;
-(void)hideTabBar;
-(void)hideTabBarWithNoAnimation;
-(void)showTabBarWithNoAnimation;
-(void)updateTabbar:(NSArray*)arr;
-(void)setButtonIndex:(NSInteger)index;
@end
