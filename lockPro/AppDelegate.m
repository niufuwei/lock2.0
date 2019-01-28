//
//  AppDelegate.m
//  xmjr
//
//  Created by laoniu on 16/4/7.
//  Copyright © 2016年 xiaoma. All rights reserved.
//

#import "AppDelegate.h"
#import "XMLoginViewController.h"
#import "XMNavigationController.h"
#import "openCheck.h"
#import "IQKeyboardManager.h"
#import <CoreLocation/CoreLocation.h>

//#import <AMapFoundationKit/AMapFoundationKit.h>
//#import <AMapLocationKit/AMapLocationKit.h>
//#import <AMapSearchKit/AMapSearchKit.h>

#import "XMHomeViewController.h"
#import "XMFriendListViewController.h"
#import "XMAccountViewController.h"
#import "XMLoginViewController.h"



@interface AppDelegate ()
{
    
}

//@property (nonatomic,strong ) AMapLocationManager *locationManager;//定位服务
@property (nonatomic,strong) XMNavigationController * loginNav;
//@property (nonatomic,strong) AMapSearchAPI * search;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Override point for customization after application launch.
    NSURLCache *URLCache = [[NSURLCache alloc] initWithMemoryCapacity:4 * 1024 * 1024 diskCapacity:20 * 1024 * 1024 diskPath:nil];
    [NSURLCache setSharedURLCache:URLCache];
    //键盘的添加
    IQKeyboardManager *keyBoardManager = [IQKeyboardManager sharedManager];
    keyBoardManager.enable = YES;
    keyBoardManager.shouldResignOnTouchOutside = YES;
    keyBoardManager.placeholderFont = [UIFont systemFontOfSize:14];
    keyBoardManager.enableAutoToolbar = NO;

    //初始化tabbar主Window
    [self initHomeWindow];
    
    //检查是否登录，如果已经登录了，去进行自动登录，否则跳过登录流程
    if([self isLogin])
    {
        //请求自动登录
        [self autoLogin];
    }
    
    //网络实时监测
    [openCheck netWorkStatus];
    //    [self locatemap];
    
    self.progress = [[CircularProgressView alloc] initWithFrame:CGRectMake(100, self.window.frame.size.height/2 - (self.window.frame.size.width-200)/2, self.window.frame.size.width-200, self.window.frame.size.width-200)];
    self.progress.backgroundColor = CLEARCOLOR;
    
    
    //高德地图定位
//    [AMapServices sharedServices].apiKey =GDAPIKey;
//
//    self.locationManager = [[AMapLocationManager alloc] init];
//
//    [self.locationManager setDelegate:self];
    
    //设置不允许系统暂停定位
//    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
//
//    //设置允许在后台定位
//    [self.locationManager setAllowsBackgroundLocationUpdates:YES];
//
//    //设置允许连续定位逆地理
//    [self.locationManager setLocatingWithReGeocode:YES];
//    [self.locationManager startUpdatingLocation];
    
//    self.search = [[AMapSearchAPI alloc] init];
//    self.search.delegate = self;
    
    
    
    return YES;
}



-(void)initHomeWindow
{
    /*!
     *初始化tabbar所应用的controller
     */
    
    
    XMLoginViewController * login = [[XMLoginViewController alloc] init];
    self.loginNav = [[XMNavigationController alloc] initWithRootViewController:login];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window setRootViewController:self.loginNav];
    [self.window makeKeyAndVisible];
    
    
}


-(void)setTabbar:(XMTabbarViewController *)tabbar{
//    if(!_tabbar){
        XMHomeViewController * home = [[XMHomeViewController alloc] init];
        XMNavigationController * homeNav = [[XMNavigationController alloc] initWithRootViewController:home];
        
        XMFriendListViewController * friend = [[XMFriendListViewController alloc] init];
        XMNavigationController * friendNav = [[XMNavigationController alloc] initWithRootViewController:friend];
        
        XMAccountViewController * account= [[XMAccountViewController alloc] init];
        XMNavigationController * accountNav = [[XMNavigationController alloc] initWithRootViewController:account];
        
        _tabbar  = [[XMTabbarViewController alloc] init];
        _tabbar.viewControllers = @[homeNav,friendNav,accountNav];
//    }
    [_tabbar setButtonIndex:1];
    [_window setRootViewController:_tabbar];

}

-(void)logout{
    [self.window setRootViewController:self.loginNav];
    [self.window makeKeyAndVisible];
}

//-(void)resetUpdateLocation:(location)location{
//    self.locationBack = location;
////    [self.locationManager startUpdatingLocation];
//
//}

//-(void)getAddressCode:(NSString*)address backResultCode:(location)backResultCode{
//
//    self.locationBack =  backResultCode;
//    AMapGeocodeSearchRequest *geo = [[AMapGeocodeSearchRequest alloc] init];
//    geo.address = address;
//    [self.search AMapGeocodeSearch:geo];
//}

////地址逆向解析，坐标
//- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response
//{
//    if (response.geocodes.count == 0)
//    {
//        return;
//    }
//
//    AMapGeocode * map = response.geocodes[0];
//
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"citys" ofType:@"plist"];
//    NSDictionary *cityDic = [[NSDictionary alloc] initWithContentsOfFile:filePath];
//
//    NSString * code = @"";
//    for(NSString * key in cityDic){
//        if([key rangeOfString:map.city].location!=NSNotFound){
//
//            code = cityDic[key];
//            break;
//        }
//        else{
//            code = @"";
//        }
//    }
//
//    if(self.locationBack){
//        self.locationBack(@{
//                            @"cityCode":[XMMethod checkParam:code]
//                            });
//    }
//
//    //解析response获取地理信息，具体解析见 Demo
//}

#pragma mark - AMapLocationManager Delegate

//- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error
//{
//    NSLog(@"%s, amapLocationManager = %@, error = %@", __func__, [manager class], error);
//}
//
//- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
//{
//    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f; reGeocode:%@}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy, reGeocode.formattedAddress);
//    self.currentCity = reGeocode.formattedAddress;
//    self.cityCode = reGeocode.adcode;
//    
//    
//    if(![XMMethod isNull:reGeocode.adcode]&&![XMMethod isNull:reGeocode.formattedAddress]){
//        if(self.locationBack){
//            self.locationBack(@{@"currentCity":self.currentCity,
//                                @"cityCode":self.cityCode
//                                });
//        }
//        
//        [self.locationManager stopUpdatingLocation];
//    }
//    
//    
//}


//
//- (void)locatemap{
//
//    if ([CLLocationManager locationServicesEnabled]) {
//        _locationManager = [[CLLocationManager alloc]init];
//        _locationManager.delegate = self;
//        [_locationManager requestAlwaysAuthorization];
//        [_locationManager requestWhenInUseAuthorization];
//        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
//        _locationManager.distanceFilter = 5.0;
//        updateLocation = true;
//        [self.locationManager startUpdatingLocation];
//    }
//}
//
//#pragma mark - 定位失败
//-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
//
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        NSURL *settingURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//        [[UIApplication sharedApplication]openURL:settingURL];
//    }];
//    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//
//    }];
//    [alert addAction:cancel];
//    [alert addAction:ok];
//    [[XMMethod getCurrentVC] presentViewController:alert animated:YES completion:nil];
//}
//#pragma mark - 定位成功
//-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
//
////    [_locationManager stopUpdatingLocation];
//    CLLocation *currentLocation = [locations lastObject];
//    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
//    //当前的经纬度
//    NSLog(@"当前的经纬度 %f,%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
//    //这里的代码是为了判断didUpdateLocations调用了几次 有可能会出现多次调用 为了避免不必要的麻烦 在这里加个if判断 如果大于1.0就return
//    NSTimeInterval locationAge = -[currentLocation.timestamp timeIntervalSinceNow];
////    if (locationAge > 1.0 && !updateLocation){//如果调用已经一次，不再执行
////        return;
////    }
//    updateLocation = false;
//    //地理反编码 可以根据坐标(经纬度)确定位置信息(街道 门牌等)
//    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//        if (placemarks.count >0) {
//            CLPlacemark *placeMark = placemarks[0];
//            self.currentCity = [placeMark.addressDictionary objectForKey:@"FormattedAddressLines"][0];
//            self.cityCode = placeMark.postalCode;
//
//            if (!_currentCity) {
//                self.currentCity = @"无法定位当前城市";
//            }
//            if(!self.cityCode){
//                self.cityCode = @"";
//            }
//            //看需求定义一个全局变量来接收赋值
//            //            NSLog(@"当前国家 - %@",placeMark.country);//当前国家
//            //            NSLog(@"当前城市 - %@",_currentCity);//当前城市
//            //            NSLog(@"当前位置 - %@",placeMark.subLocality);//当前位置
//            //            NSLog(@"当前街道 - %@",placeMark.thoroughfare);//当前街道
//            //            NSLog(@"具体地址 - %@",placeMark.name);//具体地址
//            //            NSString *message = [NSString stringWithFormat:@"%@,%@,%@,%@,%@",placeMark.country,_currentCity,placeMark.subLocality,placeMark.thoroughfare,placeMark.name];
//
//            self.locationBack(@{@"currentCity":self.currentCity,@"code":self.cityCode});
//
////            UILabel * selectLabel = _backRequest[@"label"];
////            selectLabel.text = _currentCity;
////            [XMInstanceDataArray shareInstance].investigationInfoArray = [XMMethod checkArray:[XMInstanceDataArray shareInstance].investigationInfoArray keyValue:@{@"tag":_backRequest[@"tag"]} replacKey:@"content" replacValue:_currentCity];
////
//            //            UILabel * selectLabel = _backRequest[@"label"];
//            //            selectLabel.text = _currentCity;
//            //            [XMInstanceDataArray shareInstance].investigationInfoArray = [XMMethod checkArray:[XMInstanceDataArray shareInstance].investigationInfoArray keyValue:@{@"tag":_backRequest[@"tag"]} replacKey:@"content" replacValue:_currentCity];
//            //
//            //              [XMInstanceDataArray shareInstance].investigationInfoArray = [XMMethod checkArray:[XMInstanceDataArray shareInstance].investigationInfoArray keyValue:@{@"tag":data[@"tag"]} replacKey:@"content" replacValue:result[@"data"][@"custName"]];
//
//
//
//        }else if (error == nil && placemarks.count){
//
//            NSLog(@"NO location and error return");
//        }else if (error){
//
//            NSLog(@"loction error:%@",error);
//        }
//    }];
//}


-(BOOL)isLogin {
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"userModel"]){
        [XMUserStateDataModel shareInstance].isLogin = true;
    }
    
    return [XMUserStateDataModel shareInstance].isLogin;
}

-(void)autoLogin {
    [openCheck openCheckRequest];
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    //     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game./
    
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
