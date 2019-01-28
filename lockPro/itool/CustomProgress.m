
//
//  CustomProgress.m
//  WisdomPioneer
//
//  Created by 主用户 on 16/4/11.
//  Copyright © 2016年 江萧. All rights reserved.
//

#import "CustomProgress.h"

@implementation CustomProgress
@synthesize bgimg,leftimg,presentlab;

-(void)showProgress{
    
    UIView * bgView = [[ UIView alloc] initWithFrame:CGRectMake(0, 0,kScreen_Width ,appDelegate.window.bounds.size.height)];
    bgView.backgroundColor = COLORA(0, 0, 0, 0.1);
    bgView.tag = 1234;
    [appDelegate.window addSubview:bgView];
    
    [[XMMethod getCurrentVC].view addSubview:appDelegate.progress];

    [UIView animateWithDuration:0.3 animations:^{
        CGRect yy = appDelegate.progress.frame;
        yy.origin.y = [XMMethod getCurrentVC].view.bounds.size.height/2-25-kNavigationHeight;
        appDelegate.progress.frame = yy;
    }];
}

-(void)hideProgress{
    if([appDelegate.window viewWithTag:1234]){
        UIView * v = [appDelegate.window viewWithTag:1234];
        [v removeFromSuperview];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect yy = appDelegate.progress.frame;
        yy.origin.y = kScreenHeight;
        appDelegate.progress.frame = yy;
    } completion:^(BOOL finished) {
        [appDelegate.progress removeFromSuperview];
    }];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        bgimg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        bgimg.layer.borderColor = [UIColor clearColor].CGColor;
        bgimg.layer.borderWidth =  1;
        bgimg.layer.cornerRadius = 5;
        [bgimg.layer setMasksToBounds:YES];

        [self addSubview:bgimg];
        leftimg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, self.frame.size.height)];
        leftimg.layer.borderColor = [UIColor clearColor].CGColor;
        leftimg.layer.borderWidth =  1;
        leftimg.layer.cornerRadius = 5;
        [leftimg.layer setMasksToBounds:YES];
        [self addSubview:leftimg];
        
        presentlab = [[UILabel alloc] initWithFrame:bgimg.bounds];
        presentlab.textAlignment = NSTextAlignmentCenter;
        presentlab.textColor = [UIColor whiteColor];
        presentlab.font = [UIFont systemFontOfSize:16];
        [self addSubview:presentlab];
    }
    return self;
}
-(void)setPresent:(int)present
{
    presentlab.text = [NSString stringWithFormat:@"%d％",present];
    leftimg.frame = CGRectMake(0, 0, self.frame.size.width/self.maxValue*present, self.frame.size.height);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
