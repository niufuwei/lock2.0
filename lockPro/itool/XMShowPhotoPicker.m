//
//  XMShowPhotoPicker.m
//  xmjr
//
//  Created by laoniu on 2018/3/4.
//  Copyright © 2018年 xiaoma. All rights reserved.
//

#import "XMShowPhotoPicker.h"
#import <AVFoundation/AVCaptureDataOutputSynchronizer.h>
#import "RITLPhotos.h"
#import<AVFoundation/AVCaptureDevice.h>

#import <AVFoundation/AVMediaFormat.h>

#import<AssetsLibrary/AssetsLibrary.h>

#import<CoreLocation/CoreLocation.h>
@interface XMShowPhotoPicker ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,RITLPhotoBridgeDelegate,UIActionSheetDelegate,UIPickerViewDelegate>
@end

@implementation XMShowPhotoPicker

static XMShowPhotoPicker * data = nil;

+(instancetype)shareInstance
{
    @synchronized (self) {
        if(!data){
            data = [[self alloc] init];
        }
    }
    return data;
}

+(void)showPhotoPickerView:(XMViewController*)vc backImage:(photo)backImage{
    
    [XMShowPhotoPicker shareInstance].backPhoto = backImage;
    [XMShowPhotoPicker shareInstance].vc = vc;

    //自定义消息框
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:data cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
    //显示消息框
    [sheet showInView:vc.view];
    
}

#pragma mark -消息框代理实现-
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {

    NSUInteger sourceType = 0;
    //相机权限
    
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if (authStatus ==AVAuthorizationStatusRestricted ||//此应用程序没有被授权访问的照片数据。可能是家长控制权限
        
        authStatus ==AVAuthorizationStatusDenied)  //用户已经明确否认了这一照片数据的应用程序访问
        
    {
        
        // 无权限 引导去开启
        
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        
        if ([[UIApplication sharedApplication]canOpenURL:url]) {
            
            [[UIApplication sharedApplication]openURL:url];
            
        }
        
    }
    
    
    
    //相册权限
    
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    
    if (author ==kCLAuthorizationStatusRestricted || author ==kCLAuthorizationStatusDenied){
        
        //无权限 引导去开启
        
        NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            
            [[UIApplication sharedApplication] openURL:url];
            
        }
        
    }
    
    
    // 判断系统是否支持相机
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerController.delegate = data; //设置代理
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType; //图片来源
        if (buttonIndex == 0) {
            return;
        }else if (buttonIndex == 1) {
            //拍照
            sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePickerController.sourceType = sourceType;
            [[XMShowPhotoPicker shareInstance].vc presentViewController:imagePickerController animated:YES completion:nil];
        }else if (buttonIndex == 2){
            //相册
//            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//            imagePickerController.sourceType = sourceType;
//            [[XMShowPhotoPicker shareInstance].vc presentViewController:imagePickerController animated:YES completion:nil];
            
            RITLPhotoNavigationViewModel * viewModel = [RITLPhotoNavigationViewModel new];
            
            viewModel.bridgeDelegate = self;//优先级高于block回调
            
            __weak typeof(self) weakSelf = self;

            //设置需要图片剪切的大小，不设置为图片的原比例大小
            viewModel.imageSize = CGSizeMake(kScreen_Width,  kScreen_Height-60);
            
            viewModel.RITLBridgeGetImageBlock = ^(NSArray <UIImage *> * images){
                
                //获得图片
                [XMShowPhotoPicker shareInstance].backPhoto(images);
                
            };
           
            
            RITLPhotoNavigationViewController * viewController = [RITLPhotoNavigationViewController photosViewModelInstance:viewModel];
            
            [self.vc presentViewController:viewController animated:true completion:^{}];
            
            
        }
    }else {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePickerController.sourceType = sourceType;
        [[XMShowPhotoPicker shareInstance].vc presentViewController:imagePickerController animated:YES completion:nil];
    }
}

#pragma mark -实现图片选择器代理-（上传图片的网络请求也是在这个方法里面进行，这里我不再介绍具体怎么上传图片）
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage]; //通过key值获取到图片
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        [XMShowPhotoPicker shareInstance].backPhoto(@[[self addText:image text:@""]]);
        
    });
    
//    ......
}

// 改变图像的尺寸，方便上传服务器
+(UIImage *) scaleFromImage: (UIImage *) image toSize: (CGSize) size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
//压缩图片
+(UIImage *)compressImage:(UIImage *)image {
    CGFloat maxSize = 1024.0f;
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    
    UIImage *smallImage;
    if (width > maxSize || height > maxSize) {
        if (width > height) {
            width = maxSize;
            height = floor((height*maxSize)/image.size.width);
        } else {
            height = maxSize;
            width = floor((width*maxSize)/image.size.height);
        }
    }
    CGRect rect = CGRectMake(0, 0, width, height);
    UIGraphicsBeginImageContext(rect.size);
    [image drawInRect:rect];
    smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return smallImage;
}


#pragma mark - 添加水印
-(UIImage *)addText:(UIImage *)img text:(NSString *)mark {
    if (mark.length != 0) {
    } else {
        //将时间戳转换成时间
        NSDate *date = [NSDate date];
        //    限定格式
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@" yyyy-MM-dd  hh:mm:ss SS"];
        [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
        NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"china"];//时区名字或地区名字
        [formatter setTimeZone:timeZone];
        mark = [self getDateStringWithTimeStr:[formatter stringFromDate:date]];
    }
    
    int w = img.size.width;
    int h = img.size.height;
    UIGraphicsBeginImageContext(img.size);
    [img drawInRect:CGRectMake(0, 0, w, h)];
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:25],
                                NSParagraphStyleAttributeName: paragraphStyle,
                                NSForegroundColorAttributeName : [UIColor redColor],
                                NSTextEffectAttributeName: NSTextEffectLetterpressStyle
                                };
    [mark drawInRect:CGRectMake(0, h - 40, w , 40) withAttributes:attribute];
    UIImage *aImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return aImage;
}

// 时间戳转时间,时间戳为13位是精确到毫秒的，10位精确到秒
- (NSString *)getDateStringWithTimeStr:(NSString *)str{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // 创建一个时间格式化对象
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SS"];
    //设定时间的格式
    NSDate *tempDate = [dateFormatter dateFromString:str];
    //将字符串转换为时间对象
    NSString *timeStr = [NSString stringWithFormat:@"%ld", (long)[tempDate timeIntervalSince1970]*1000];
    //字符串转成时间戳,精确到毫秒*1000
    return timeStr;
    
    
}



@end
