//
//  XMDefine.h
//  xmjr
//
//  Created by laoniu on 16/4/14.
//  Copyright © 2016年 laoniu. All rights reserved.
//

#ifndef XMDefine_h
#define XMDefine_h

/*
 *
 * 正式环境
 *
 */
#if DEVELOPMENT_ENVIRONMENT ==1

#define NET_WORK_CONNECT_ADDR_IP @"https://xedk3front.xmjr.com"

#define NET_WORK_CONNECT_ADDR_IMAGE_IP  @"https://xedk3front.xmjr.com/xmphImageAccessary/" //测试图片服务器

#define PORT                     7777

#else

/*
 *
 * 测试环境
 *
 */

//#define NET_WORK_CONNECT_ADDR_IP @"http://192.168.2.65:8095"//文双 客户
//#define NET_WORK_CONNECT_ADDR_IP @"http://47.93.126.233:8104"//测试服务器
//#define NET_WORK_CONNECT_ADDR_IP @"http://192.168.2.181:8095"//亚明
//#define NET_WORK_CONNECT_ADDR_IP  @"http://192.168.1.245:8095" //雷和红 申请
//#define NET_WORK_CONNECT_ADDR_IP  @"http://192.168.2.91:8095" //小龙 调查

//#define NET_WORK_CONNECT_ADDR_IP  @"http://47.93.126.233:8087" //前置


//#define NET_WORK_CONNECT_ADDR_IMAGE_IP  @"http://192.168.2.91:8090/xmphImageAccessary/" //小龙 图片服务器
//#define NET_WORK_CONNECT_ADDR_IMAGE_IP  @"http://47.93.126.233:8081/xmphImageAccessary/" //测试图片服务器

#define NET_WORK_CONNECT_ADDR_IP @"http://121.40.101.133:81/eSeal.asmx/postMsg"

#define PORT                     7777

#endif

//登录
#define OSS_LOGIN_SERVICE_PROTOCOL @"0x03"

//登录
#define OSS_AUTO_LOGIN_SERVICE_PROTOCOL @"0x10"

//用户注册
#define OSS_REGISTER_SERVICE_PROTOCOL @"0x01"

//获取验证码
#define OSS_GET_CODER_SERVICE_PROTOCOL @"0x05"

//验证验证码
#define OSS_VERIFY_CODER_SERVICE_PROTOCOL @"0x1b"

//通知图片更新
#define OSS_NOTIFY_IMAGE_UPDATE_SERVICE_PROTOCOL @"0x2b"

//获取key
#define OSS_GET_KEY_SERVICE_PROTOCOL @"0x1a"

//退出登录
#define OSS_LOGOU_SERVICE_PROTOCOL @"/user/loginout"

//忘记密码
#define OSS_FORGET_PASSWORD_SERVICE_PROTOCOL @"0x09"


//上传操作记录
#define OSS_POST_RECODER_SERVICE_PROTOCOL @"0x24"

//修改密码
#define OSS_MODIFY_PASSWORD_SERVICE_PROTOCOL @"0x06"

//修改用户昵称
#define OSS_MODIFY_NICKNAME_SERVICE_PROTOCOL @"0x07"

//搜索好友
#define OSS_SEARCH_FRIEND_SERVICE_PROTOCOL @"0x33"

//我的车辆
#define OSS_MY_CARD_LIST_SERVICE_PROTOCOL @"0x61"

//获取我的设备
#define OSS_MY_DEVICE_LIST_SERVICE_PROTOCOL @"0x28"

//添加好友
#define OSS_ADD_FRIEND_SERVICE_PROTOCOL @"0x30"

//我的好友
#define OSS_MY_FRIEND_LIST_SERVICE_PROTOCOL @"0x34"

//我的好友
#define OSS_REMOVE_FRIEND_LIST_SERVICE_PROTOCOL @"0x32"


//分享权限列表
#define OSS_SHARE_LIST_SERVICE_PROTOCOL @"0x62"

//分享权限列表
#define OSS_ALL_DEVICE_SERVICE_PROTOCOL @"0x63"

//确认分享
#define OSS_CONFIRM_SHARE_SERVICE_PROTOCOL @"0x40"

//删除分享
#define OSS_DELETE_SHARE_SERVICE_PROTOCOL @"0x42"

//查看记录
#define OSS_CAT_RECODER_SERVICE_PROTOCOL @"0x25"

//未绑定设备
#define OSS_NO_BIND_DEVICE_SERVICE_PROTOCOL @"0x23"

//获取绑定设备位置
#define OSS_EDIT_BIND_DEVICE_SERVICE_PROTOCOL @"0x21"

//我的设备
#define OSS_MY_DEVICE_SERVICE_PROTOCOL @"0x28"

//我的设备
#define OSS_CHECK_DEVICE_PASSWORD_SERVICE_PROTOCOL @"0x9a"

#endif /* MLDefine_h */
