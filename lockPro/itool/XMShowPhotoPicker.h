//
//  XMShowPhotoPicker.h
//  xmjr
//
//  Created by laoniu on 2018/3/4.
//  Copyright © 2018年 xiaoma. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^photo)( NSArray<UIImage *>*images);

@interface XMShowPhotoPicker : NSObject

@property (nonatomic,strong)photo backPhoto;
@property (nonatomic,strong)XMViewController * vc;

+(void)showPhotoPickerView:(XMViewController*)vc backImage:(photo)backImage;
//压缩图片
+(UIImage *)compressImage:(UIImage *)image;
@end
