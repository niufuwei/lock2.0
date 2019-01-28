//
//  NavCustom.m
//  ELiuYan
//
//  Created by laoniu on 14-4-29.
//  Copyright (c) 2014年 chaoyong.com. All rights reserved.
//

#import "XMNavCustom.h"

@implementation XMNavCustom
@synthesize NavDelegate;

//static XMNavCustom * nav = nil;
//+(instancetype)shareInstance
//{
//    @synchronized (self) {
//        nav = [[self alloc] init];
//
//    }
//    return nav;
//}


-(void)setNavWithText:(NSString *)NavTitile mySelf:(UIViewController *)mySelf
{
    UILabel * lab;
    if([iOSCurrentVersion  floatValue]<7.0)
    {
        lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 21)];
    }
    else
    {
        lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 21, 21)];
    }
    
    [lab setFont:[UIFont systemFontOfSize:20]];
    lab.textColor = WHITECOLOR;
    lab.text = NavTitile;
    lab.textAlignment = NSTextAlignmentCenter;
    lab.backgroundColor = [UIColor clearColor];
    mySelf.navigationItem.titleView = lab;
    
}

-(void)setNavWithImage:(NSString *)imgName mySelf:(UIViewController *)mySelf width:(int)width height:(int)height
{
    UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(150, 0, width, height)];
    [image setImage:[UIImage imageNamed:imgName]];
    mySelf.navigationItem.titleView = image;
}

-(void)setNavRightBtnTitle:(NSString *)RightBtnTitle mySelf:(UIViewController *)mySelf width:(int)width height:(int)height
{
    //创建右边按钮
    UIButton *rightBackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    rightBackBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBackBtn setTitle:RightBtnTitle forState:UIControlStateNormal];
    [rightBackBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
    [rightBackBtn addTarget:self action:@selector(NavRightButtononClick) forControlEvents:UIControlEventTouchUpInside];
    
    //添加进BARBUTTONITEM
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBackBtn];
    
    //右按钮
    mySelf.navigationItem.rightBarButtonItem = rightBtn;
    

}

-(void)setNavRightBtnTitle:(NSString *)RightBtnTitleOne RightBtnTitleTwo:(NSString *)RightBtnTitleTwo mySelf:(UIViewController *)mySelf
{
    
    UIView * v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 130, 20)];
    
    //创建左边按钮
    UIButton *rightBackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, -10, 80,40)];
    rightBackBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBackBtn setTitle:RightBtnTitleOne forState:UIControlStateNormal];
    [rightBackBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
    rightBackBtn.tag = 101;
    [rightBackBtn addTarget:self action:@selector(NavRightButtononClick:) forControlEvents:UIControlEventTouchUpInside];
//    [rightBackBtn.titleLabel setTextAlignment:UIControlContentHorizontalAlignmentRight];
    rightBackBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;

    UIImageView * image =[[UIImageView alloc] initWithFrame:CGRectMake(84.5, 5, 0.5, 10)];
    [image setBackgroundColor:WHITECOLOR];
    
    
    //创建右边按钮
    UIButton *rightBackBtnTwo = [[UIButton alloc] initWithFrame:CGRectMake(90, -10, 60, 40)];
    rightBackBtnTwo.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBackBtnTwo setTitle:RightBtnTitleTwo forState:UIControlStateNormal];
    [rightBackBtnTwo setTitleColor:WHITECOLOR forState:UIControlStateNormal];
    rightBackBtnTwo.tag = 102;
    [rightBackBtnTwo addTarget:self action:@selector(NavRightButtononClick:) forControlEvents:UIControlEventTouchUpInside];
//    [rightBackBtnTwo setTextAlignment:UIControlContentHorizontalAlignmentLeft];
    rightBackBtnTwo.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [v addSubview:rightBackBtn];
    [v addSubview:rightBackBtnTwo];
    [v addSubview:image];
    
    //添加进BARBUTTONITEM
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:v];
    
    //右按钮
    mySelf.navigationItem.rightBarButtonItem = rightBtn;
    
    
}

-(void)setNavRightBtnImage:(NSString *)RightBtnImage RightBtnSelectedImage:(NSString *)RightBtnSelectedImage mySelf:(UIViewController *)mySelf width:(int)width height:(int)height
{
    //创建右边按钮
    UIButton *rightBackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    
    [rightBackBtn setImage:[UIImage imageNamed:RightBtnImage] forState:UIControlStateNormal];
    [rightBackBtn setImage:[UIImage imageNamed:RightBtnSelectedImage] forState:UIControlStateHighlighted];
    [rightBackBtn addTarget:self action:@selector(NavRightButtononClick) forControlEvents:UIControlEventTouchUpInside];
    
    //添加进BARBUTTONITEM
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:rightBackBtn];
    
    //右按钮
    mySelf.navigationItem.rightBarButtonItem = rightBtn;
    

}

-(void) NavRightButtononClick:(UIButton*)btn{
    
    if ([self.NavDelegate respondsToSelector:@selector(NavRightButtononClick:)])
    {//判断方法是否实现
        [self.NavDelegate NavRightButtononClick:btn];
    }
}


-(void) NavRightButtononClick{
    
    if ([self.NavDelegate respondsToSelector:@selector(NavRightButtononClick)])
    {//判断方法是否实现
        [self.NavDelegate NavRightButtononClick];
    }
}


-(void)setNavLeftBtnTitle:(NSString *)LeftBtnTitle mySelf:(UIViewController *)mySelf width:(int)width height:(int)height
{
    //创建右边按钮
    UIButton *LeftBackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    
    [LeftBackBtn setTitle:LeftBtnTitle forState:UIControlStateNormal];
    [LeftBackBtn setTitleColor:WHITECOLOR forState:UIControlStateNormal];
    [LeftBackBtn addTarget:self action:@selector(NavLeftButtononClick) forControlEvents:UIControlEventTouchUpInside];
    
    //添加进BARBUTTONITEM
    UIBarButtonItem *LeftBtn = [[UIBarButtonItem alloc] initWithCustomView:LeftBackBtn];
    
    //右按钮
    mySelf.navigationItem.leftBarButtonItem = LeftBtn;
    

}

-(void)setNavLeftBtnImage:(NSString *)LeftBtnImage LeftBtnSelectedImage:(NSString *)LeftBtnSelectedImage mySelf:(UIViewController *)mySelf width:(int)width height:(int)height
{
    //创建右边按钮
    UIButton *LeftBackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, width-5, height)];
    
    [LeftBackBtn setImage:[UIImage imageNamed:LeftBtnImage] forState:UIControlStateNormal];
    [LeftBackBtn setImage:[UIImage imageNamed:LeftBtnSelectedImage] forState:UIControlStateHighlighted];
    [LeftBackBtn addTarget:self action:@selector(NavLeftButtononClick) forControlEvents:UIControlEventTouchUpInside];
    
    //添加进BARBUTTONITEM
    UIBarButtonItem *LeftBtn = [[UIBarButtonItem alloc] initWithCustomView:LeftBackBtn];
    
    //右按钮
    mySelf.navigationItem.leftBarButtonItem = LeftBtn;
    

}

-(void)NavLeftButtononClick{
    
    if ([self.NavDelegate respondsToSelector:@selector(NavLeftButtononClick)])
    {//判断方法是否实现
        [self.NavDelegate NavLeftButtononClick];
    }
}

-(void)setNavTitleBackImage:(NSString *)title mySelf:(UIViewController*)mySelf width:(int)width
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, width, 19);
    button.backgroundColor = CLEARCOLOR;
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:WHITECOLOR forState:UIControlStateNormal];
    
    UIImageView *backImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"backwhite"]];
    backImageView.backgroundColor = CLEARCOLOR;
    backImageView.frame = CGRectMake(0, 0, 11, 17);
    [button addSubview:backImageView];
    backImageView.userInteractionEnabled = YES;

    UIBarButtonItem *LeftBtn = [[UIBarButtonItem alloc] initWithCustomView:button];
    mySelf.navigationItem.leftBarButtonItem = LeftBtn;

    [button addTarget:self action:@selector(NavLeftButtononClick) forControlEvents:UIControlEventTouchUpInside];

}



@end
