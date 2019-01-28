//
//  NAPushFile.m
//  lockPro
//
//  Created by laoniu on 2018/8/1.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "NAPushFile.h"
#import "OSSService.h"
#import "XMShowPhotoPicker.h"
#import "LCLoadingHUD.h"
@interface NAPushFile ()
{
    NSString * currentDate;
}
@property (strong, nonatomic) OSSClient *client;
@end

@implementation NAPushFile

//
-(void)setPushDic:(NSDictionary *)pushDic
{
    
    _pushDic = pushDic;
//    [pushDic objectForKey:@"accessKeyId"]
//    [pushDic objectForKey:@"accessKeySecret"]
//    [pushDic objectForKey:@"expiration"]
//    [pushDic objectForKey:@"securityToken"]
//    [pushDic objectForKey:@"uptTime"]


    [self ali];
}

- (void)ali

{

//    id<OSSCredentialProvider> credential = [[OSSPlainTextAKSKPairCredentialProvider alloc] initWithPlainTextAccessKey:[self.pushDic objectForKey:@"accessKeyId"] secretKey:[self.pushDic objectForKey:@"accessKeySecret"]];
    


    OSSClientConfiguration * conf = [OSSClientConfiguration new];



    // 网络请求遇到异常失败后的重试次数

    conf.maxRetryCount = 3;



    // 网络请求的超时时间

    conf.timeoutIntervalForRequest =30;



    // 允许资源传输的最长时间

    conf.timeoutIntervalForResource =24 *60 * 60;



    // 你的阿里地址前面通常是这种格式 :http://oss……
    NSString *endpoint = @"https://oss-cn-hangzhou.aliyuncs.com";
    
    id<OSSCredentialProvider> credential = [[OSSStsTokenCredentialProvider alloc] initWithAccessKeyId:[self.pushDic objectForKey:@"accessKeyId"] secretKeyId:[self.pushDic objectForKey:@"accessKeySecret"] securityToken:[self.pushDic objectForKey:@"securityToken"]];
    _client = [[OSSClient alloc] initWithEndpoint:endpoint credentialProvider:credential];
    
    [XMShowPhotoPicker showPhotoPickerView:self.vc backImage:^(NSArray<UIImage *> *images) {
        NSData *ImageData =UIImageJPEGRepresentation(images[0],0.2);
        [self updateToALi:ImageData imageName:@""];
    }];
    
   
}

//5. 在 ImagePicker 方法中

//-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//
//{
//
//    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
//
//    [self performSelector:@selector(saveImage:) withObject:img afterDelay:0.1];
//
//}
//
//- (void)saveImage:(UIImage *)image {
//
//    BOOL success;
//
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//
//    NSError *error;
//
//
//
//    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
//
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//
//    // 图片名
//
//    NSString *imageName = [NSString stringWithFormat:@"%@.jpg", [self.pushDic objectForKey:@"lockMac"]];
//
//    NSString *imageFilePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", imageName]];
//
//    success = [fileManager fileExistsAtPath:imageFilePath];
//
//    if(success) {
//
//        [fileManager removeItemAtPath:imageFilePath error:&error];
//
//    }
//
//
//    UIImage *smallImage = [self thumbnailWithImageWithoutScale:image size:CGSizeMake(93,93)];
//
//
//
//    [UIImageJPEGRepresentation(smallImage,0.3) writeToFile:imageFilePath atomically:YES];
//
//    UIImage *selfPhoto = [UIImage imageWithContentsOfFile:imageFilePath];//读取图片文件
//
//
//
//
//
//    NSData *ImageData =UIImagePNGRepresentation(selfPhoto);
//
//    [self updateToALi:ImageData imageName:imageName];
//
//}

// 改变图片尺寸

-(UIImage *)thumbnailWithImageWithoutScale:(UIImage *)image size:(CGSize)asize

{



    UIImage *newimage;



    if (nil == image) {



        newimage = nil;



    }



    else{



        CGSize oldsize = image.size;



        CGRect rect;



        if (asize.width/asize.height > oldsize.width/oldsize.height) {



            rect.size.width = asize.height*oldsize.width/oldsize.height;



            rect.size.height = asize.height;



            rect.origin.x = (asize.width - rect.size.width)/2;



            rect.origin.y =0;



        }



        else{



            rect.size.width = asize.width;



            rect.size.height = asize.width*oldsize.height/oldsize.width;



            rect.origin.x =0;



            rect.origin.y = (asize.height - rect.size.height)/2;



        }



        UIGraphicsBeginImageContext(asize);



        CGContextRef context =UIGraphicsGetCurrentContext();



        CGContextSetFillColorWithColor(context, [[UIColor clearColor]CGColor]);



        UIRectFill(CGRectMake(0,0, asize.width, asize.height));//clear background



        [image drawInRect:rect];



        newimage = UIGraphicsGetImageFromCurrentImageContext();



        UIGraphicsEndImageContext();



    }



    return newimage;



}


//5. 上传图片

- (void)updateToALi:(NSData *)data imageName:(NSString *)imageName

{

    [LCLoadingHUD showLoading:@"正在上传图片..."];
    
    
    OSSPutObjectRequest * put = [OSSPutObjectRequest new];

    //    [pushDic objectForKey:@"expiration"]
    //    [pushDic objectForKey:@"securityToken"]
    //    [pushDic objectForKey:@"uptTime"]

    put.bucketName = @"block-image";

    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"YYYYMMddHHmmsssss";
    currentDate =[fmt stringFromDate:[NSDate date]];
    NSLog(@"%@", currentDate);
    
    
    put.objectKey = currentDate;



    put.uploadingData = data; // 直接上传NSData



    put.uploadProgress = ^(int64_t bytesSent,int64_t totalByteSent,int64_t totalBytesExpectedToSend) {

        NSLog(@"%lld, %lld, %lld", bytesSent, totalByteSent, totalBytesExpectedToSend);

    };



    OSSTask * putTask = [_client putObject:put];



    // 上传阿里云

    [putTask continueWithBlock:^id(OSSTask *task) {

        dispatch_async(dispatch_get_main_queue(), ^{
            [LCLoadingHUD hideInKeyWindow];
            if (!task.error) {
                
                NSLog(@"upload object success!");
                
                [XMDataManager updatePicRequestManager:@{@"oprtID":self.oprtId,@"imgUrl":currentDate} success:^(id result) {
                    [XMMethod alertErrorMessage:@"上传成功"];

                } err:^(NSError *error) {
                    [XMMethod alertErrorMessage:@"上传失败"];

                }];
                
                
            } else {
                
                [XMMethod alertErrorMessage:@"上传失败"];
                
                
                NSLog(@"upload object failed, error: %@" , task.error);
                
            }
        });

        return nil;

    }];

}


@end
