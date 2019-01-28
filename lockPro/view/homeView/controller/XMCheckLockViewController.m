//
//  XMCheckLockViewController.m
//  lockPro
//
//  Created by laoniu on 2018/5/29.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "XMCheckLockViewController.h"
#import "XMLockAnimation.h"
#import "PassWordView.h"

@interface XMCheckLockViewController ()
@property(strong,nonatomic)PassWordView *passWordV;

@end

@implementation XMCheckLockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"巴拉巴拉小魔仙";
    
    UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    [image setImage:[UIImage imageNamed:@"lockBg"]];
    [self.view addSubview:image];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, kScreen_Width-160, 20)];
    titleLabel.text = @"位置:02中";
    titleLabel.textColor = WHITECOLOR;
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    
    XMLockAnimation * animation = [[[NSBundle mainBundle]loadNibNamed:@"XMLockAnimation" owner:self options:nil]lastObject];
    animation.frame = CGRectMake(0, 50,kScreen_Width, 304);
    [self.view addSubview:animation];
    
    UILabel * titleLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(80, kScreen_Height-100, kScreen_Width-160, 20)];
    titleLabel2.text = @"点击锁进行操作";
    titleLabel2.textColor = COLOR(77, 170, 109);
    titleLabel2.font = [UIFont systemFontOfSize:14];
    titleLabel2.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel2];
    
    UILabel * titleLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(10, kScreen_Height-30, kScreen_Width-20, 20)];
    titleLabel3.text = @"若网络连接断开，请联系工作人员输入密码开锁";
    titleLabel3.textColor = LIGHTGRAY;
    titleLabel3.font = [UIFont systemFontOfSize:12];
    titleLabel3.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel3];
    
    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap)];
    [titleLabel3 addGestureRecognizer:tap];
    titleLabel3.userInteractionEnabled = YES;
    
    [appDelegate.tabbar hideTabBar];
    
    self.passWordV.viewCancelBlock = ^(){
        NSLog(@"消失了");
    };
    
    self.passWordV.viewConfirmBlock=^(NSString *text){
        NSLog(@"textCode:%@",text);
    };
    
    // Do any additional setup after loading the view.
}



-(void)onTap{
    [[UIApplication sharedApplication].keyWindow addSubview:self.passWordV];

}

- (PassWordView *)passWordV
{
    if (!_passWordV) {
        _passWordV = [[PassWordView instance] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    }
    return _passWordV;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
