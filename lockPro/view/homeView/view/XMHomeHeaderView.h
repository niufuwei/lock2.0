//
//  XMHomeHeaderView.h
//  lockPro
//
//  Created by 牛付威 on 2018/5/28.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMHomeHeaderView : UITableViewCell

@property (nonatomic,strong) IBOutlet UIButton * sectionButton;
@property (nonatomic,strong) IBOutlet UIImageView * icon;
@property (nonatomic,strong) IBOutlet UILabel * carNumber;
@property (nonatomic,strong) IBOutlet UILabel * openNumber;
@property (nonatomic,strong) IBOutlet UILabel * closeNumber;
@property (nonatomic,strong) IBOutlet UILabel * normalNumber;

@end
