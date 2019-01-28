//
//  XMCZSetViewController.m
//  lockPro
//
//  Created by 牛付威 on 2018/6/1.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "XMCZSetViewController.h"
#import "XMCzSetview.h"

@interface XMCZSetViewController ()

@property (nonatomic,assign) BOOL isSelect;

@end

@implementation XMCZSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    XMCzSetview * set = [[[NSBundle mainBundle] loadNibNamed:@"XMCzSetview" owner:self options:nil]lastObject];
    set.frame=  CGRectMake(0, 0, kScreen_Width, 44);
 
    [set.segment addTarget:self action:@selector(onSegment:) forControlEvents:UIControlEventTouchUpInside];
    [self.bgScrollview addSubview:set];
   
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"takePhoto"]){
        [set.segment setImage:[UIImage imageNamed:@"wxcz_icon"] forState:UIControlStateNormal];

    }else{
        [set.segment setImage:[UIImage imageNamed:@"once_icon"] forState:UIControlStateNormal];
    }
    
    // Do any additional setup after loading the view.
}


-(void)onSegment:(UIButton*)btn{
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"takePhoto"]){
        [btn setImage:[UIImage imageNamed:@"once_icon"] forState:UIControlStateNormal];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"takePhoto"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }else{
        [btn setImage:[UIImage imageNamed:@"wxcz_icon"] forState:UIControlStateNormal];
        [[NSUserDefaults standardUserDefaults] setObject:@"ok" forKey:@"takePhoto"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
 
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
