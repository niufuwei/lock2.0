//
//  XMHomeListViewVell.h
//  lockPro
//
//  Created by 牛付威 on 2018/5/28.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMHomeListViewVell : UITableViewCell

@property (nonatomic,strong) IBOutlet UIView * progress;
@property (nonatomic,strong) IBOutlet UIImageView * progressBGView;

@property (nonatomic,strong) IBOutlet UIImageView * statusImage;
@property (nonatomic,strong) IBOutlet UILabel  * pos;
@property (nonatomic,strong) IBOutlet UILabel * name;

@end
