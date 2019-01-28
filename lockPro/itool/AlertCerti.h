//
//  AlertView.h
//  tempPush
//
//  Created by laoniu on 14/10/29.
//  Copyright (c) 2014年 xiaoma. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol alertCertiDelegate <NSObject>

-(void)confirmButtonClick;
@end

@interface AlertCerti : UIView<UITextFieldDelegate>

@property (nonatomic,strong) UIView * view;
@property (nonatomic,strong) UIButton * selectButton;
@property (nonatomic,strong) UIButton * name ;
@property (nonatomic,strong) id<alertCertiDelegate>delegate;

-(id)initWithView:(UIView*)view;
-(void)show;
-(void)hidden;
@end
