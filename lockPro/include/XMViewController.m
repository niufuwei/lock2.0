//
//  XMViewController.m
//  xmjr
//
//  Created by laoniu on 16/5/23.
//  Copyright © 2016年 xiaoma. All rights reserved.
//

#import "XMViewController.h"
#import "XMRequestNetWork.h"


@interface XMViewController ()<UIGestureRecognizerDelegate,UIScrollViewDelegate,NavCustomDelegate>

@end

@implementation XMViewController
//@synthesize scrollview;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = COLOR(240, 240, 240);
    
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    //主要是以下两个图片设置
    self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"backWhite"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"backWhite"];
    self.navigationItem.backBarButtonItem = backItem;
    
//    id target = self.navigationController.interactivePopGestureRecognizer.delegate;
//    // 创建全屏滑动手势，调用系统自带滑动手势的target的action方法
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
//    // 设置手势代理，拦截手势触发
//    pan.delegate = self;
//    // 给导航控制器的view添加全屏滑动手势
//    [self.view addGestureRecognizer:pan];
//    // 禁止使用系统自带的滑动手势
//    self.navigationController.interactivePopGestureRecognizer.enabled = NO;


//
    self.bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreenHeight)];
    [self.bgView  setImage:[UIImage imageNamed:@"loginPageView"]];
    [self.view addSubview:self.bgView ];
    self.bgView.hidden = YES;
    [self.view addSubview:self.bgScrollview];
    [self.bgScrollview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    XMNavCustom * nav = [[ XMNavCustom alloc] init];
    [nav setNavLeftBtnImage:@"backWhite" LeftBtnSelectedImage:@"backWhite" mySelf:self width:30 height:40];
    nav.NavDelegate =self;
    // Do any additional setup after loading the view.
}

//-(void)handleNavigationTransition:(UIPanGestureRecognizer *)g{
//
//}

// 作用：拦截手势触发
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
//    // 注意：只有非根控制器才有滑动返回功能，根控制器没有。
//
//    // 判断导航控制器是否只有一个子控制器，如果只有一个子控制器，肯定是根控制器
//    if(self.navigationController.childViewControllers.count == 1){
//        // 表示用户在根控制器界面，就不需要触发滑动手势，
//        return NO;
//    }
//    return YES;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)hidenNavigationWithAnimation:(BOOL)animation {
    [self.navigationController setNavigationBarHidden:YES animated:animation];
}
-(void)hidenTabbarWithAnimation:(BOOL)animation {
    [appDelegate.tabbar hideTabBar];
}

//显示导航栏
-(void)showNavigationWithAnimation:(BOOL)animation {
    [self.navigationController setNavigationBarHidden:NO animated:animation];
}

//显示tabbar
-(void)showTabbarWithAnimation:(BOOL)animation {
    [appDelegate.tabbar showTabBar];

}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
//    [appDelegate.window hideToastActivity];
    
    [XMRequestNetWork cancelRequestNetWork];

}
//
//-(void)addSubViewWithScrollview:(UIView*)view
//{
//    scrollview = [[UIScrollView alloc] initWithFrame:self.view.frame];
//    scrollview.delegate =self;
//    scrollview.contentSize = CGSizeMake(kScreen_Width, kScreen_Height+1);
//    scrollview.showsHorizontalScrollIndicator = NO;
//    scrollview.showsVerticalScrollIndicator = NO;
//    [self.view addSubview:scrollview];
//
//    [scrollview addSubview:view];
//}

-(UIScrollView*)bgScrollview{
    if(!_bgScrollview){
        _bgScrollview = [[UIScrollView alloc] init];
        _bgScrollview.delegate =self;
        _bgScrollview.contentSize = CGSizeMake(kScreen_Width, kScreen_Height+1);
        _bgScrollview.showsVerticalScrollIndicator = NO;
    }
    
    return _bgScrollview;
}

-(void)viewWillAppear:(BOOL)animated{
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
//                                                  forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    UIImage *bgImage = [[UIImage imageNamed:@"navBG"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch];
    //    [[UINavigationBar appearance] setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
    //
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    
    self.navigationController.navigationBar.barTintColor = [UIColor clearColor];
    
    //隐藏黑线
    
    [self.navigationController.navigationBar setBackgroundImage:
     bgImage forBarMetrics:UIBarMetricsDefault];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
  
}

-(void)NavLeftButtononClick{
    
    if([self.navigationController.viewControllers count]>1){
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self.navigationController.topViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
