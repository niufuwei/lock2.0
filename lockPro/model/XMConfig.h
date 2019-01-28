//
//  config.h
//  xmjr
//
//  Created by laoniu on 2016/11/14.
//  Copyright © 2016年 xiaoma. All rights reserved.
//

#ifndef config_h
#define config_h

//开发环境配置，1连接是正@式，2是连接测@试服务器
#define DEVELOPMENT_ENVIRONMENT 2

//下拉刷新高度
#define REFRESH_HEIGHT 100

//jsPath热更新appKey
#define JSPATCH_KEY @"5a984afe70bf1565"

//微博分享key
#define kAppKey @"3657785678"

//微信分享Key
#define kWXAppKey @"wx34194d7c90d1d639"

//qq分享key
#define QQAppid @"801424455"

//友盟统计key
#define YOUMENG_KEY @"55b6f92367e58e48830042de"

//talkingdata 统计key
#define TALKINGDATA_KEY @"A80E592F601A0A8C484BDD2553598B91"

//appstore 应用id
#define APP_STORE_ID @"966091062"

//高德地图
#define GDAPIKey @"da54468c5c87c7c8c76c221a7e923136"

//百度地图
#define baiduMapKey @"oWZbXfubOd7TeW2QIjagQ6LxTED9d7Yg"
//应用自动退出时间
#define  APP_LOG_OUT 3600*24

#define WK(weakSelf) __weak __typeof(&*self)weakSelf = self;

//自动登录时间
#define APP_AUTO_LOGIN_BIG_TIME  3600*24   //1800
#define APP_AUTO_LOGIN_SMALL_TIME 60 * 25  //1700

//退出应用多久启动手势密码
#define APP_TIME_OUT 60


#define BGCOLOR COLOR(240, 240, 240)

#define NavCOLOR COLOR(250, 250, 250)

//首页菜单大小
//#define collectHeight  (kScreen_Width-(iPhone5?4:5)*10)/(iPhone5?3:4)
#define collectHeight  361

#endif /* config_h */
