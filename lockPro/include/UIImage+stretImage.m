//
//  UIImage+stretImage.m
//  xmjr
//
//  Created by laoniu on 2017/12/25.
//  Copyright © 2017年 xiaoma. All rights reserved.
//

#import "UIImage+stretImage.h"

@implementation UIImage (stretImage)

+(UIImage*)imageStretWithName:(NSString*)nameStr{
//    UIImage *image = [UIImage imageNamed:nameStr];
//    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height ];
    
    // 加载图片
    UIImage *image = [UIImage imageNamed:nameStr];
    
    // 设置端盖的值
    CGFloat top = image.size.height * 0.5;
    CGFloat left = image.size.width * 0.5;
    CGFloat bottom = image.size.height * 0.5;
    CGFloat right = image.size.width * 0.5;
    
    // 设置端盖的值
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(top, left, bottom, right);
    // 设置拉伸的模式
    UIImageResizingMode mode = UIImageResizingModeStretch;
    
    // 拉伸图片
    UIImage *newImage = [image resizableImageWithCapInsets:edgeInsets resizingMode:mode];
    return newImage;
}

@end
