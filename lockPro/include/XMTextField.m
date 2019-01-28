//
//  XMTextField.m
//  xmjr
//
//  Created by laoniu on 2017/12/21.
//  Copyright © 2017年 xiaoma. All rights reserved.
//

#import "XMTextField.h"

@implementation XMTextField

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        self.leftViewMode = UITextFieldViewModeAlways;
        self.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
