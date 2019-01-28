//
//  BALoginView.h
//  borrowApp
//
//  Created by laoniu on 2016/11/24.
//  Copyright © 2016年 xiaoma. All rights reserved.
//

#import "XMView.h"

@interface XMLoginView : XMView

@property (nonatomic,strong) UIButton * loginButton;
@property (nonatomic,strong) UIButton * registButton;
@property (nonatomic,strong) UIButton * forgetPasswordButton;
@property (nonatomic,strong) UIButton * protocolButton;

@property (nonatomic,strong) XMTextField * userNameTextField;
@property (nonatomic,strong) XMTextField * passwordTextField;

@property (nonatomic,strong) UIImageView * logoImage;

@end
