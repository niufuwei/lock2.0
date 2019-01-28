//
//  XMLogOutViewController.m
//  xmjr
//
//  Created by laoniu on 2018/2/9.
//  Copyright © 2018年 xiaoma. All rights reserved.
//

#import "XMLogOutViewController.h"
#import "XMLogOutView.h"
#import "XMNavigationController.h"

@interface XMLogOutViewController (){
    XMLogOutView * logOutView;
}

@end

@implementation XMLogOutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    logOutView = [[XMLogOutView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height)];
    [logOutView.exitButton addTarget:self action:@selector(onExitClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgScrollview addSubview:logOutView];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];

    // Do any additional setup after loading the view.
}

-(void)onExitClick:(id)sender{
//    [XMDataManager exitSystemRequestManager:^(id result) {
//        NSLog(@"%@",result);
//        
//        [XMMethod cleanUserToken];
//        XMLoginViewController * homeView = [[XMLoginViewController alloc] init];
//        XMNavigationController * homeViewNav = [[XMNavigationController alloc] initWithRootViewController:homeView];
//        
//        [appDelegate.window setRootViewController:homeViewNav];
//        [appDelegate.window makeKeyAndVisible];
//    } err:^(NSError *error) {
//        
//    }];
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
