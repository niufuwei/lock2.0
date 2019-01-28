//
//  XMShowPicArrayViewController.m
//  xmjr
//
//  Created by laoniu on 2018/3/24.
//  Copyright © 2018年 xiaoma. All rights reserved.
//

#import "XMShowPicArrayViewController.h"

@interface XMShowPicArrayViewController ()<JCTopicDelegate,NavCustomDelegate>
{
    XMNavCustom * nav;

}

@end

@implementation XMShowPicArrayViewController

static XMShowPicArrayViewController * pic =nil;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    nav = [[XMNavCustom alloc] init];
    nav.NavDelegate =self;
    [nav setNavLeftBtnTitle:@"关闭" mySelf:self width:40 height:20];
    // Do any additional setup after loading the view.
}

+(instancetype)shareInstance{
    @synchronized(self){
        if(!pic){
            pic = [[self alloc] init];
            pic.view.backgroundColor = BLACKCOLOR;
        
        }
    }
    return pic;
}

+(void)showImageArr:(NSArray*)imageArray{
    //实例化
    [XMShowPicArrayViewController shareInstance].Topic = [[JCTopic alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreenHeight)];
    //代理
    [XMShowPicArrayViewController shareInstance].Topic.JCdelegate = [XMShowPicArrayViewController shareInstance];
    NSMutableArray * tempArray = [[NSMutableArray alloc]init];

    //网络图片
    //***********************//
    //key pic = 地址 NSString
    //key title = 显示的标题 NSString
    //key isLoc = 是否本地图片 Bool
    //key placeholderImage = 网络图片加载失败时显示的图片 UIImage
    //***********************//
    
    for(NSString*url in imageArray)
        [tempArray addObject:[NSDictionary dictionaryWithObjects:@[url ,@"",@NO] forKeys:@[@"pic",@"title",@"isLoc"]]];
    
    //加入数据
    [XMShowPicArrayViewController shareInstance].Topic.pics = tempArray;
    //更新
    [[XMShowPicArrayViewController shareInstance].Topic upDate];
    [[XMShowPicArrayViewController shareInstance].view addSubview:[XMShowPicArrayViewController shareInstance].Topic];
    
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:[XMShowPicArrayViewController shareInstance] ];
    
    
    [[XMMethod getCurrentVC].navigationController presentViewController:nav animated:YES completion:^{
        
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    

}

-(void)NavLeftButtononClick{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)didClick:(id)data{
}
-(void)currentPage:(int)page total:(NSUInteger)total{
   
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
