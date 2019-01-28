//
//  XMDataManager.m
//  xmjr
//
//  Created by laoniu on 16/5/23.
//  Copyright © 2016年 xiaoma. All rights reserved.
//

#import "XMDataManager.h"
#import "XMRequestNetWork.h"
#import "XMDataManagerMethod.h"
#import "XMLoginDataModel.h"

@implementation XMDataManager

static XMDataManager * manager = nil;
+(instancetype)shareInstance
{
    @synchronized (self ) {
        if(!manager)
        {
            manager = [[self alloc] init];
        }
    }
    return manager;
}

//判断当前请求结果是否是当前发起的请求
+(BOOL)checkResultUrl:(NSString*)url  response:( NSURLResponse *)response{
    if([response.URL.absoluteString rangeOfString:url].location != NSNotFound){
        return YES;
    }
    return NO;
}


/*!
 * brief 自动登录
 * param dic 登录数据模型
 * return
 */
+(void)autoLoginRequestManager:(id)dic success:(backSuccess)success err:(backError)err{
    [XMDataManagerMethod writeDic:dic requestUrl:OSS_AUTO_LOGIN_SERVICE_PROTOCOL method:POST resultString:^(id resultS,NSURLResponse * response) {
        
        success(resultS);
        
    } Error:^(id error,NSURLResponse * response) {
        
        err(error);
        
    }];
}

/*!
 * brief 通知图片更新
 * param
 * return
 */
+(void)updatePicRequestManager:(id)dic success:(backSuccess)success err:(backError)err{
    [XMDataManagerMethod writeDic:dic requestUrl:OSS_NOTIFY_IMAGE_UPDATE_SERVICE_PROTOCOL method:POST resultString:^(id resultS,NSURLResponse * response) {
        
        success(resultS);
        
    } Error:^(id error,NSURLResponse * response) {
        
        err(error);
        
    }];
}

/*!
 * brief 获取上传文件key
 * param dic 获取上传文件key
 * return
 */
+(void)getKeyServiceManager:(id)dic success:(backSuccess)success err:(backError)err{
    [XMDataManagerMethod writeDic:dic requestUrl:OSS_GET_KEY_SERVICE_PROTOCOL method:POST resultString:^(id resultS,NSURLResponse * response) {
        
        success(resultS);
        
    } Error:^(id error,NSURLResponse * response) {
        
        err(error);
        
    }];
}

/*!
 * brief 发送登录请求
 * param loginModel 登录的数据模型 success 请求结果成功返回数据 err错误信息
 * return 成功
 */
+(void)loginRequestManager:(id)dic success:(backSuccess)success err:(backError)err
{
    [XMDataManagerMethod writeDic:dic requestUrl:OSS_LOGIN_SERVICE_PROTOCOL method:POST resultString:^(id resultS,NSURLResponse * response) {
        
        success(resultS);
        
    } Error:^(id error,NSURLResponse * response) {
        
        err(error);
        
    }];
}


/*!
 * brief 获取验证码
 *param  success 请求结果成功返回数据 err错误信息
 * return 成功
 */
+(void)getCodeRequestManager:(id)dic success:(backSuccess)success err:(backError)err{
    
    [XMDataManagerMethod writeDic:dic requestUrl:OSS_GET_CODER_SERVICE_PROTOCOL method:POST resultString:^(id resultS,NSURLResponse * response) {
        
        success(resultS);

    } Error:^(id error,NSURLResponse * response) {
        
        err(error);

    }];
}

/*!
 * brief 校验验证码
 * param  success 请求结果成功返回数据 err错误信息
 * return 成功
 */
+(void)veryCodeRequestManager:(id)dic success:(backSuccess)success err:(backError)err{
    
    [XMDataManagerMethod writeDic:dic requestUrl:OSS_VERIFY_CODER_SERVICE_PROTOCOL method:POST resultString:^(id resultS,NSURLResponse * response) {
        
        success(resultS);

    } Error:^(id error,NSURLResponse * response) {
        
        err(error);

    }];
}

+(void)postRecoderRequestManager:(id)dic success:(backSuccess)success err:(backError)err{
    [XMDataManagerMethod writeDic:dic requestUrl:OSS_POST_RECODER_SERVICE_PROTOCOL method:POST resultString:^(id resultS,NSURLResponse * response) {
        
        success(resultS);
        
    } Error:^(id error,NSURLResponse * response) {
        
        err(error);
        
    }];
}

/*!
 * brief 注册
 * param  success 请求结果成功返回数据 err错误信息
 * return 成功
 */
+(void)registerRequestManager:(id)dic success:(backSuccess)success err:(backError)err{
    [XMDataManagerMethod writeDic:dic requestUrl:OSS_REGISTER_SERVICE_PROTOCOL method:POST resultString:^(id resultS,NSURLResponse * response) {
        
        success(resultS);
        
    } Error:^(id error,NSURLResponse * response) {
        
        err(error);
        
    }];
}

/*!
 * brief 忘记密码
 * param  success 请求结果成功返回数据 err错误信息
 * return 成功
 */
+(void)forgetPasswordManager:(id)dic success:(backSuccess)success err:(backError)err{
    [XMDataManagerMethod writeDic:dic requestUrl:OSS_FORGET_PASSWORD_SERVICE_PROTOCOL method:POST resultString:^(id resultS,NSURLResponse * response) {
        
        success(resultS);
        
    } Error:^(id error,NSURLResponse * response) {
        
        err(error);
        
    }];
}

/*!
 * brief 修改密码
 * param  success 请求结果成功返回数据 err错误信息
 * return 成功
 */
+(void)modifyPasswordManager:(id)dic success:(backSuccess)success err:(backError)err{
    [XMDataManagerMethod writeDic:dic requestUrl:OSS_MODIFY_PASSWORD_SERVICE_PROTOCOL method:POST resultString:^(id resultS,NSURLResponse * response) {
        
        success(resultS);
        
    } Error:^(id error,NSURLResponse * response) {
        
        err(error);
        
    }];
}

/*!
 * brief 修改用户昵称
 * param  success 请求结果成功返回数据 err错误信息
 * return 成功
 */
+(void)modifyNicknameManager:(id)dic success:(backSuccess)success err:(backError)err{
    [XMDataManagerMethod writeDic:dic requestUrl:OSS_MODIFY_NICKNAME_SERVICE_PROTOCOL method:POST resultString:^(id resultS,NSURLResponse * response) {
        
        success(resultS);
        
    } Error:^(id error,NSURLResponse * response) {
        
        err(error);
        
    }];
}


/*!
 * brief 搜索好友
 * param  success 请求结果成功返回数据 err错误信息
 * return 成功
 */
+(void)searchFriendManager:(id)dic success:(backSuccess)success err:(backError)err{
    [XMDataManagerMethod writeDic:dic requestUrl:OSS_SEARCH_FRIEND_SERVICE_PROTOCOL method:POST resultString:^(id resultS,NSURLResponse * response) {
        
        success(resultS);
        
    } Error:^(id error,NSURLResponse * response) {
        
        err(error);
        
    }];
}

/*!
 * brief 我的车辆
 * param  success 请求结果成功返回数据 err错误信息
 * return 成功
 */
+(void)myCarListManager:(id)dic success:(backSuccess)success err:(backError)err{
    [XMDataManagerMethod writeDic:dic requestUrl:OSS_MY_CARD_LIST_SERVICE_PROTOCOL method:POST resultString:^(id resultS,NSURLResponse * response) {
        
        success(resultS);
        
    } Error:^(id error,NSURLResponse * response) {
        
        err(error);
        
    }];
}


/*!
 * brief 获取我的设备
 * param  success 请求结果成功返回数据 err错误信息
 * return 成功
 */
+(void)myDeviceListManager:(id)dic success:(backSuccess)success err:(backError)err{
    [XMDataManagerMethod writeDic:dic requestUrl:OSS_MY_DEVICE_LIST_SERVICE_PROTOCOL method:POST resultString:^(id resultS,NSURLResponse * response) {
        
        success(resultS);
        
    } Error:^(id error,NSURLResponse * response) {
        
        err(error);
        
    }];
}

/*!
 * brief 添加好友
 * param  success 请求结果成功返回数据 err错误信息
 * return 成功
 */
+(void)addFriendManager:(id)dic success:(backSuccess)success err:(backError)err{
    [XMDataManagerMethod writeDic:dic requestUrl:OSS_ADD_FRIEND_SERVICE_PROTOCOL method:POST resultString:^(id resultS,NSURLResponse * response) {
        
        success(resultS);
        
    } Error:^(id error,NSURLResponse * response) {
        
        err(error);
        
    }];
}

/*!
 * brief 我的好友
 * param  success 请求结果成功返回数据 err错误信息
 * return 成功
 */
+(void)myFriendListManager:(id)dic success:(backSuccess)success err:(backError)err{
    [XMDataManagerMethod writeDic:dic requestUrl:OSS_MY_FRIEND_LIST_SERVICE_PROTOCOL method:POST resultString:^(id resultS,NSURLResponse * response) {
        
        success(resultS);
        
    } Error:^(id error,NSURLResponse * response) {
        
        err(error);
        
    }];
}

/*!
 * brief 删除好友
 * param  success 请求结果成功返回数据 err错误信息
 * return 成功
 */
+(void)removeFriendListManager:(id)dic success:(backSuccess)success err:(backError)err{
    [XMDataManagerMethod writeDic:dic requestUrl:OSS_REMOVE_FRIEND_LIST_SERVICE_PROTOCOL method:POST resultString:^(id resultS,NSURLResponse * response) {
        
        success(resultS);
        
    } Error:^(id error,NSURLResponse * response) {
        
        err(error);
        
    }];
}

/*!
 * brief 分享权限
 * param  success 请求结果成功返回数据 err错误信息
 * return 成功
 */
+(void)shareListManager:(id)dic success:(backSuccess)success err:(backError)err{
    [XMDataManagerMethod writeDic:dic requestUrl:OSS_SHARE_LIST_SERVICE_PROTOCOL method:POST resultString:^(id resultS,NSURLResponse * response) {
        
        success(resultS);
        
    } Error:^(id error,NSURLResponse * response) {
        
        err(error);
        
    }];
}

/*!
 * brief 获取车上所有设备
 * param  success 请求结果成功返回数据 err错误信息
 * return 成功
 */
+(void)getCarsAllDeviceManager:(id)dic success:(backSuccess)success err:(backError)err{
    [XMDataManagerMethod writeDic:dic requestUrl:OSS_ALL_DEVICE_SERVICE_PROTOCOL method:POST resultString:^(id resultS,NSURLResponse * response) {
        
        success(resultS);
        
    } Error:^(id error,NSURLResponse * response) {
        
        err(error);
        
    }];
}

/*!
 * brief 确认分享
 * param  success 请求结果成功返回数据 err错误信息
 * return 成功
 */
+(void)confirmShareManager:(id)dic success:(backSuccess)success err:(backError)err{
    [XMDataManagerMethod writeDic:dic requestUrl:OSS_CONFIRM_SHARE_SERVICE_PROTOCOL method:POST resultString:^(id resultS,NSURLResponse * response) {
        
        success(resultS);
        
    } Error:^(id error,NSURLResponse * response) {
        
        err(error);
        
    }];
}

/*!
 * brief 删除分享
 * param  success 请求结果成功返回数据 err错误信息
 * return 成功
 */
+(void)deleteShareManager:(id)dic success:(backSuccess)success err:(backError)err{
    [XMDataManagerMethod writeDic:dic requestUrl:OSS_DELETE_SHARE_SERVICE_PROTOCOL method:POST resultString:^(id resultS,NSURLResponse * response) {
        
        success(resultS);
        
    } Error:^(id error,NSURLResponse * response) {
        
        err(error);
        
    }];
}

/*!
 * brief 查看记录
 * param  success 请求结果成功返回数据 err错误信息
 * return 成功
 */
+(void)catRecoderManager:(id)dic success:(backSuccess)success err:(backError)err{
    [XMDataManagerMethod writeDic:dic requestUrl:OSS_CAT_RECODER_SERVICE_PROTOCOL method:POST resultString:^(id resultS,NSURLResponse * response) {
        
        success(resultS);
        
    } Error:^(id error,NSURLResponse * response) {
        
        err(error);
        
    }];
}

/*!
 * brief 未绑定设备
 * param  success 请求结果成功返回数据 err错误信息
 * return 成功
 */
+(void)noBindDeviceManager:(id)dic success:(backSuccess)success err:(backError)err{
    [XMDataManagerMethod writeDic:dic requestUrl:OSS_NO_BIND_DEVICE_SERVICE_PROTOCOL method:POST resultString:^(id resultS,NSURLResponse * response) {
        
        success(resultS);
        
    } Error:^(id error,NSURLResponse * response) {
        
        err(error);
        
    }];
}

/*!
 * brief 获取设备位置
 * param  success 请求结果成功返回数据 err错误信息
 * return 成功
 */
+(void)editBindDevicePosManager:(id)dic success:(backSuccess)success err:(backError)err{
    [XMDataManagerMethod writeDic:dic requestUrl:OSS_EDIT_BIND_DEVICE_SERVICE_PROTOCOL method:POST resultString:^(id resultS,NSURLResponse * response) {
        
        success(resultS);
        
    } Error:^(id error,NSURLResponse * response) {
        
        err(error);
        
    }];
}

/*!
 * brief 我的设备
 * param  success 请求结果成功返回数据 err错误信息
 * return 成功
 */
+(void)myDeviceManager:(id)dic success:(backSuccess)success err:(backError)err{
    [XMDataManagerMethod writeDic:dic requestUrl:OSS_MY_DEVICE_SERVICE_PROTOCOL method:POST resultString:^(id resultS,NSURLResponse * response) {
        
        success(resultS);
        
    } Error:^(id error,NSURLResponse * response) {
        
        err(error);
        
    }];
}


/*!
 * brief 获取操作锁的动态密码
 * param  success 请求结果成功返回数据 err错误信息
 * return 成功
 */
+(void)checkDevicePasswordManager:(id)dic success:(backSuccess)success err:(backError)err{
    [XMDataManagerMethod writeDic:dic requestUrl:OSS_CHECK_DEVICE_PASSWORD_SERVICE_PROTOCOL method:POST resultString:^(id resultS,NSURLResponse * response) {
        
        success(resultS);
        
    } Error:^(id error,NSURLResponse * response) {
        
        err(error);
        
    }];
}

@end
