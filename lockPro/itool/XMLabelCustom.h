//
//  BALabelCustom.h
//  borrowApp
//
//  Created by laoniu on 2016/11/23.
//  Copyright © 2016年 xiaoma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLabelCustom : NSObject

//带点击事件的label
+(UILabel*)createClickLabelWithFrame:(CGRect)frame titleLabel:(NSString*)titleLabel backGroundColor:(UIColor*)backGroundColor titleColor:(UIColor*)titleColor textAlignment:(NSTextAlignment)textAlignment titleFont:(NSInteger)titleFont tag:(NSInteger)tag target:(id)target labelClick:(SEL)labelClick;

//不带点击事件
+(UILabel*)createLabelWithFrame:(CGRect)frame titleLabel:(NSString*)titleLabel backGroundColor:(UIColor*)backGroundColor titleColor:(UIColor*)titleColor textAlignment:(NSTextAlignment)textAlignment titleFont:(NSInteger)titleFont;

@end
