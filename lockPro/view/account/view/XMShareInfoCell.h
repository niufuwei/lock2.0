//
//  XMShareInfoCell.h
//  lockPro
//
//  Created by 牛付威 on 2018/5/31.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMShareInfoCell : UITableViewCell
@property (nonatomic,strong) IBOutlet UIButton * segment;
@property (nonatomic,strong) IBOutlet UILabel * titleLabel;
@property (nonatomic,strong) IBOutlet UILabel * contentLabel;
@property (nonatomic,strong) IBOutlet UITextField * textField;

@end