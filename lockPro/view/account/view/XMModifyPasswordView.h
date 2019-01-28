//
//  XMModifyPasswordView.h
//  lockPro
//
//  Created by 牛付威 on 2018/6/1.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMModifyPasswordView : UITableViewCell

@property (nonatomic,strong) IBOutlet UITextField * oldPassword;
@property (nonatomic,strong) IBOutlet  UITextField * nPassword;
@property (nonatomic,strong) IBOutlet  UITextField * reNewPassword;
@property (nonatomic,strong) IBOutlet  UIButton * modifyConfirm;


@end
