//
//  BAButtonCustom.m
//  borrowApp
//
//  Created by laoniu on 2016/11/22.
//  Copyright © 2016年 xiaoma. All rights reserved.
//

#import "XMButtonCustom.h"

@implementation XMButtonCustom

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

static XMButtonCustom * button = nil;
+(instancetype)shareInstance
{
    @synchronized (self) {
        if(!button)
        {
            button = [[self alloc] init];
        }
    }
    return button;
}

+(UIButton*)createBlockButtonWithFrame:(CGRect)frame titleLabel:(NSString*)titleLabel backGroundColor:(UIColor*)backGroundColor titleColor:(UIColor*)titleColor titleFont:(NSInteger)titleFont tag:(NSInteger)tag target:(id)target buttonClick:(btnClick)buttonClick
{
    [XMButtonCustom shareInstance].btn_click = buttonClick;
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitle:titleLabel forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:titleFont];
    btn.tag = tag;
    [btn addTarget:button action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = backGroundColor;
    return btn;
}

+(UIButton*)createSelButtonWithFrame:(CGRect)frame titleLabel:(NSString*)titleLabel backGroundColor:(UIColor*)backGroundColor titleColor:(UIColor*)titleColor titleFont:(NSInteger)titleFont tag:(NSInteger)tag target:(id)target btnClick:(SEL)btnClick
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitle:titleLabel forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:titleFont];
    btn.tag = tag;
    [btn addTarget:target action:btnClick forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = backGroundColor;
    return btn;
   
}

-(void)onClick:(id)sender
{
    _btn_click(sender);
}

@end
