//
//  CircularProgressView.m
//  SellMyiPhone
//
//  Created by Vincent on 1/12/17.
//  Copyright © 2017 zssr. All rights reserved.
//

#import "CircularProgressView.h"


#define LineWidth 5.f
#define Space 7.f
#define Yellow [UIColor colorWithRed:0.9725 green:0.7412 blue:0.1725 alpha:1]

@interface CircularProgressView()
{
    UILabel * progressLabel;
    UILabel * progressLabelText;
}

@end

@implementation CircularProgressView
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    

    }
    return self;
}

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
    
    progressLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height/2-30, self.bounds.size.width, 30)];
    progressLabel.textColor = WHITECOLOR;
    progressLabel.textAlignment = NSTextAlignmentCenter;
    [progressLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:40]];
    [self addSubview:progressLabel];
    [self bringSubviewToFront:progressLabel];
    
    progressLabelText = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height/2, self.bounds.size.width, 40)];
    progressLabelText.textColor = WHITECOLOR;
    [progressLabelText setFont:[UIFont systemFontOfSize:15]];
    progressLabelText.textAlignment = NSTextAlignmentCenter;
    progressLabelText.text = @"上传进度";
    [self addSubview:progressLabelText];
    [self bringSubviewToFront:progressLabelText];
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

- (void)setProgress:(float)progress {
    if (progress >= 100.f) {
        _progress = 100.f;
    }
    _progress = progress;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [self drawBackground];
    [self drawProgressLine];
}

- (void)drawProgressLine {
    [self drawCircleDashed:NO];
}

- (void)drawBackground {
    CGRect rect = self.bounds;
    CGPoint center = CGPointMake(CGRectGetWidth(rect) / 2.f, CGRectGetHeight(rect) / 2.f);
    CGFloat radius = MIN(CGRectGetHeight(rect), CGRectGetWidth(rect)) / 2 - Space - LineWidth;
    // draw pie
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    [Yellow setFill];
    [path fill];
    // draw dash circle
    [self drawCircleDashed:YES];
}

- (void)drawCircleDashed:(BOOL)dash {
    CGRect rect = self.bounds;
    CGPoint center = CGPointMake(CGRectGetWidth(rect) / 2.f, CGRectGetHeight(rect) / 2.f);
    CGFloat radius = MIN(CGRectGetHeight(rect), CGRectGetWidth(rect)) / 2 - LineWidth / 2;
    CGFloat endAngle = 2 * M_PI;
    CGFloat startAngle = 0;
    if (!dash) {
        startAngle = -M_PI_2;
        endAngle = M_PI * 2 * self.progress / 100.f - M_PI_2;
    }
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    if (dash) {
        CGFloat lengths[] = {2, 6};
        [path setLineDash:lengths count:2 phase:0];
    }
    [path setLineWidth:LineWidth];
    [Yellow setStroke];
    [path stroke];
    
    progressLabel.text = [NSString stringWithFormat:@"%.f%%",self.progress];

}

@end
