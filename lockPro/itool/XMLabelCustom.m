//
//  BALabelCustom.m
//  borrowApp
//
//  Created by laoniu on 2016/11/23.
//  Copyright © 2016年 xiaoma. All rights reserved.
//

#import "XMLabelCustom.h"

@implementation XMLabelCustom

//带点击事件的label
+(UILabel*)createClickLabelWithFrame:(CGRect)frame titleLabel:(NSString*)titleLabel backGroundColor:(UIColor*)backGroundColor titleColor:(UIColor*)titleColor textAlignment:(NSTextAlignment)textAlignment titleFont:(NSInteger)titleFont tag:(NSInteger)tag target:(id)target labelClick:(SEL)labelClick
{
    UILabel * lab = [[UILabel alloc] initWithFrame:frame];
    lab.text = titleLabel;
    lab.textColor = titleColor;
    lab.font = [UIFont systemFontOfSize:titleFont];
    lab.backgroundColor = backGroundColor;
    lab.tag = tag;
    lab.userInteractionEnabled = YES;
    lab.textAlignment = textAlignment;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:labelClick];
    [lab addGestureRecognizer:tap];
    return lab;
}

//不带点击事件
+(UILabel*)createLabelWithFrame:(CGRect)frame titleLabel:(NSString*)titleLabel backGroundColor:(UIColor*)backGroundColor titleColor:(UIColor*)titleColor textAlignment:(NSTextAlignment)textAlignment titleFont:(NSInteger)titleFont
{
    UILabel * lab = [[UILabel alloc] initWithFrame:frame];
    lab.text = titleLabel;
    lab.textColor = titleColor;
    lab.font = [UIFont systemFontOfSize:titleFont];
    lab.backgroundColor = backGroundColor;
    lab.userInteractionEnabled = YES;
    lab.textAlignment = textAlignment;
    return lab;
}

@end
