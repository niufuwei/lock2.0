//
//  AlertView.m
//  tempPush
//
//  Created by laoniu on 14/10/29.
//  Copyright (c) 2014年 xiaoma. All rights reserved.
//

#import "AlertCerti.h"

@implementation AlertCerti
{
    BOOL isShow;
    UIImageView * imageMBBJT;
    UIView * bgView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithView:(UIView*)view
{
    if(self = [super init])
    {
        _view = view;
        self.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        [self setBackgroundColor:[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3]];
        
        NSInteger myHeight = 250;
       
        bgView = [[UIView alloc] init];
        bgView.frame = CGRectMake(20, self.view.frame.size.height/2-myHeight/2, _view.frame.size.width-40, myHeight);
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.layer.cornerRadius = 10;
        [self addSubview:bgView];
        
        UIButton * Close = [[UIButton alloc] initWithFrame:CGRectMake(bgView.frame.size.width-40, 10, 20, 20)];
        [Close setBackgroundImage:[UIImage imageNamed:@"close_press"] forState:UIControlStateNormal];
        [Close addTarget:self action:@selector(onClose) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:Close];
        
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, bgView.frame.size.width-40, 20)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor lightGrayColor];
        titleLabel.font = [UIFont systemFontOfSize:17];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.adjustsFontSizeToFitWidth = YES;
        titleLabel.text = @"请完成有氧注册开户后申请征信查询";
        [bgView addSubview:titleLabel];
        
        
        UILabel * chuliren = [[UILabel alloc] initWithFrame:CGRectMake(10, titleLabel.frame.size.height+titleLabel.frame.origin.y+20, 80, 45)];
        chuliren.backgroundColor = [UIColor clearColor];
        chuliren.textColor = [UIColor lightGrayColor];
        chuliren.font = [UIFont systemFontOfSize:17];
        chuliren.textAlignment = NSTextAlignmentLeft;
        chuliren.adjustsFontSizeToFitWidth = YES;
        chuliren.text = @"处理人";
        [bgView addSubview:chuliren];
        
        self.name = [[UIButton alloc] initWithFrame:CGRectMake(chuliren.frame.size.width+chuliren.frame.origin.x+5, titleLabel.frame.size.height+titleLabel.frame.origin.y+20, bgView.frame.size.width-(chuliren.frame.size.width+chuliren.frame.origin.x+5)-20, 45)];
        self.name.layer.cornerRadius = 2;
        self.name.layer.borderColor = COLORA(0, 0, 0, 0.2).CGColor;
        self.name.layer.borderWidth = 0.5;
        [self.name setTitle:@"请选择" forState:UIControlStateNormal];
        self.name.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.name setTitleColor:GRAYCOLOR forState:UIControlStateNormal];
        self.name.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [bgView addSubview:self.name];
        
        
        UILabel * question = [[UILabel alloc] initWithFrame:CGRectMake(10, self.name.frame.size.height+self.name.frame.origin.y+10, 80, 45)];
        question.backgroundColor = [UIColor clearColor];
        question.textColor = [UIColor lightGrayColor];
        question.font = [UIFont systemFontOfSize:17];
        question.textAlignment = NSTextAlignmentLeft;
        question.adjustsFontSizeToFitWidth = YES;
        question.text = @"查询原因";
        [bgView addSubview:question];
        
       self.selectButton = [[UIButton alloc] initWithFrame:CGRectMake(question.frame.size.width+question.frame.origin.x+5, self.name.frame.size.height+self.name.frame.origin.y+10, bgView.frame.size.width-(question.frame.size.width+question.frame.origin.x+5)-20, 45)];
        self.selectButton.layer.cornerRadius = 2;
        self.selectButton.layer.borderColor = COLORA(0, 0, 0, 0.2).CGColor;
        self.selectButton.layer.borderWidth = 0.5;
        [self.selectButton setTitle:@"请选择" forState:UIControlStateNormal];
        self.selectButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.selectButton setTitleColor:GRAYCOLOR forState:UIControlStateNormal];
        self.selectButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [bgView addSubview:self.selectButton];
        
        UIButton * rightButton =[UIButton buttonWithType:UIButtonTypeCustom];
        rightButton.frame = CGRectMake(20, self.selectButton.frame.size.height+self.selectButton.frame.origin.y+15, bgView.frame.size.width-40, 50);
        [rightButton setBackgroundImage:[UIImage imageNamed:@"idConfirmButtonSelected"] forState:UIControlStateNormal];
        rightButton.titleLabel.font = [UIFont systemFontOfSize:19];
        [rightButton setTitle:@"保存" forState:UIControlStateNormal];
        [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        rightButton.tag = 102;
        rightButton.layer.cornerRadius = 5;
        [rightButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:rightButton];
        
        [self registerForKeyboardNotifications];
    }
    return self;
}


- (void) registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardDidHideNotification object:nil];
}

- (void) keyboardWasShown:(NSNotification *) notif
{
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    
    NSLog(@"keyBoard:%f", keyboardSize.height);  //216
    
    
    [UIView animateWithDuration:0.1 animations:^{
        
        CGRect myFrame = bgView.frame;
        
        myFrame.origin.y = bgView.frame.origin.y-keyboardSize.height/2;
        bgView.frame = myFrame;
        
    } completion:^(BOOL finished) {
        
    }];

    
    ///keyboardWasShown = YES;
}
- (void) keyboardWasHidden:(NSNotification *) notif
{
    NSDictionary *info = [notif userInfo];
    
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    NSLog(@"keyboardWasHidden keyBoard:%f", keyboardSize.height);
    
    [UIView animateWithDuration:0.1 animations:^{
        
        CGRect myFrame = bgView.frame;
        
        myFrame.origin.y = self.view.frame.size.height/2-250/2;
        bgView.frame = myFrame;
        
    } completion:^(BOOL finished) {
        
    }];
    // keyboardWasShown = NO;
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}
-(void)onClose
{
    [self hidden];
}



-(void)onClick:(id)sender
{
   
    [_delegate confirmButtonClick];
    
}


-(void)show
{
//    CGRect myFrame = self.frame;
//    
//    myFrame.origin.y = _view.frame.size.height;
//    self.frame = myFrame;
//    
//    [UIView animateWithDuration:0.2 animations:^{
//        
//        CGRect myFrame = self.frame;
//        
//        myFrame.origin.y = 150;
//        self.frame = myFrame;
//        
//    }];
//
    
    if(isShow)
    {
        for(UIView * view in self.view.subviews)
        {
            if([view viewWithTag:10086])
            {
                [view removeFromSuperview];
            }
        }
       
    }
    self.tag = 10086;
    [_view addSubview:self];

    bgView.transform = CGAffineTransformMakeScale(0, 0);
    [UIView animateWithDuration:0.3 animations:^{
        bgView.transform = CGAffineTransformIdentity;
        //view.transform = CGAffineTransformMakeScale(0, 0);
        //view.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
       
    }];
    
    isShow = TRUE;
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"isShow"];

}

-(void)hidden
{
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect myFrame = bgView.frame;
        
        myFrame.origin.y = _view.frame.size.height;
        bgView.frame = myFrame;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        isShow = FALSE;
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"isShow"];


    }];
    
}

@end
