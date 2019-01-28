//
//  BAButtonCustom.h
//  borrowApp
//
//  Created by laoniu on 2016/11/22.
//  Copyright © 2016年 xiaoma. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^btnClick)(UIButton*btn);

@interface XMButtonCustom : NSObject

@property (nonatomic,strong) btnClick btn_click;

+(UIButton*)createBlockButtonWithFrame:(CGRect)frame titleLabel:(NSString*)titleLabel backGroundColor:(UIColor*)backGroundColor titleColor:(UIColor*)titleColor titleFont:(NSInteger)titleFont tag:(NSInteger)tag target:(id)target buttonClick:(btnClick)buttonClick;


+(UIButton*)createSelButtonWithFrame:(CGRect)frame titleLabel:(NSString*)titleLabel backGroundColor:(UIColor*)backGroundColor titleColor:(UIColor*)titleColor titleFont:(NSInteger)titleFont tag:(NSInteger)tag target:(id)target btnClick:(SEL)btnClick;

@end
