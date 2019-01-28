//
//  XMDataManager.h
//  xmjr
//
//  Created by laoniu on 16/5/23.
//  Copyright © 2016年 xiaoma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
typedef void (^backSuccess)(id result);
typedef void (^backError)(NSError * error);

@class XMLoginDataModel;
@class XMCheckVersionDataModel;
@class XMUserInfoDataModel;

@interface XMDataManager : NSObject

@property (nonatomic,strong) backSuccess    block_success;
@property (nonatomic,strong) backError      block_error;
@property (nonatomic,strong) XMLoginDataModel * loginModel;

/*!
 * brief 发起登录请求
 * param dic 登录数据模型
 * return
 */
+(void)loginRequestManager:(id)dic success:(backSuccess)success err:(backError)err;

/*!
 * brief 自动登录
 * param dic 登录数据模型
 * return
 */
+(void)autoLoginRequestManager:(id)dic success:(backSuccess)success err:(backError)err;

/*!
 * brief 通知图片更新
 * param
 * return
 */
+(void)updatePicRequestManager:(id)dic success:(backSuccess)success err:(backError)err;


/*!
 * brief 获取上传文件key
 * param dic 获取上传文件key
 * return
 */
+(void)getKeyServiceManager:(id)dic success:(backSuccess)success err:(backError)err;

/*!
 * brief 获取验证码
 * param  success 请求结果成功返回数据 err错误信息
 * return
 */
+(void)getCodeRequestManager:(id)dic success:(backSuccess)success err:(backError)err;


/*!
 * brief 校验验证码
 * param  success 请求结果成功返回数据 err错误信息
 * return 成功
 */
+(void)veryCodeRequestManager:(id)dic success:(backSuccess)success err:(backError)err;

/*!
 * brief \上传操作记录
 * param  success 请求结果成功返回数据 err错误信息
 * return 成功
 */
+(void)postRecoderRequestManager:(id)dic success:(backSuccess)success err:(backError)err;


/*!
 * brief 注册
 * param  success 请求结果成功返回数据 err错误信息
 * return 成功
 */
+(void)registerRequestManager:(id)dic success:(backSuccess)success err:(backError)err;

/*!
 * brief 忘记密码
 * param  success 请求结果成功返回数据 err错误信息
 * return 成功
 */
+(void)forgetPasswordManager:(id)dic success:(backSuccess)success err:(backError)err;


/*!
 * brief 修改用户昵称
 * param  success 请求结果成功返回数据 err错误信息
 * return 成功
 */
+(void)modifyNicknameManager:(id)dic success:(backSuccess)success err:(backError)err;
/*!
 * brief 修改密码
 * param  success 请求结果成功返回数据 err错误信息
 * return 成功
 */
+(void)modifyPasswordManager:(id)dic success:(backSuccess)success err:(backError)err;

/*!
 * brief 搜索好友
 * param  success 请求结果成功返回数据 err错误信息
 * return 成功
 */
+(void)searchFriendManager:(id)dic success:(backSuccess)success err:(backError)err;


/*!
 * brief 获取我的设备
 * param  success 请求结果成功返回数据 err错误信息
 * return 成功
 */
+(void)myDeviceListManager:(id)dic success:(backSuccess)success err:(backError)err;

/*!
 * brief 我的车辆
 * param  success 请求结果成功返回数据 err错误信息
 * return 成功
 */
+(void)myCarListManager:(id)dic success:(backSuccess)success err:(backError)err;


/*!
 * brief 添加好友
 * param  success 请求结果成功返回数据 err错误信息
 * return 成功
 */
+(void)addFriendManager:(id)dic success:(backSuccess)success err:(backError)err;


/*!
 * brief 我的好友
 * param  success 请求结果成功返回数据 err错误信息
 * return 成功
 */
+(void)myFriendListManager:(id)dic success:(backSuccess)success err:(backError)err;

/*!
 * brief 删除好友
 * param  success 请求结果成功返回数据 err错误信息
 * return 成功
 */
+(void)removeFriendListManager:(id)dic success:(backSuccess)success err:(backError)err;

/*!
 * brief 分享权限
 * param  success 请求结果成功返回数据 err错误信息
 * return 成功
 */
+(void)shareListManager:(id)dic success:(backSuccess)success err:(backError)err;

/*!
 * brief 获取车上所有设备
 * param  success 请求结果成功返回数据 err错误信息
 * return 成功
 */
+(void)getCarsAllDeviceManager:(id)dic success:(backSuccess)success err:(backError)err;


/*!
 * brief 确认分享
 * param  success 请求结果成功返回数据 err错误信息
 * return 成功
 */
+(void)confirmShareManager:(id)dic success:(backSuccess)success err:(backError)err;

/*!
 * brief 删除分享
 * param  success 请求结果成功返回数据 err错误信息
 * return 成功
 */
+(void)deleteShareManager:(id)dic success:(backSuccess)success err:(backError)err;

/*!
 * brief 查看记录
 * param  success 请求结果成功返回数据 err错误信息
 * return 成功
 */
+(void)catRecoderManager:(id)dic success:(backSuccess)success err:(backError)err;

/*!
 * brief 未绑定设备
 * param  success 请求结果成功返回数据 err错误信息
 * return 成功
 */
+(void)noBindDeviceManager:(id)dic success:(backSuccess)success err:(backError)err;

/*!
 * brief 获取设备位置
 * param  success 请求结果成功返回数据 err错误信息
 * return 成功
 */
+(void)editBindDevicePosManager:(id)dic success:(backSuccess)success err:(backError)err;


/*!
 * brief 我的设备
 * param  success 请求结果成功返回数据 err错误信息
 * return 成功
 */
+(void)myDeviceManager:(id)dic success:(backSuccess)success err:(backError)err;


/*!
 * brief 获取操作锁的动态密码
 * param  success 请求结果成功返回数据 err错误信息
 * return 成功
 */
+(void)checkDevicePasswordManager:(id)dic success:(backSuccess)success err:(backError)err;
@end
