//
//  XMNearListCell.h
//  lockPro
//
//  Created by laoniu on 2018/5/29.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XMNearListCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UILabel * lockName;
@property (nonatomic,strong) IBOutlet UILabel * lockMac;
@property (nonatomic,strong) IBOutlet UIImageView * lockImage;
@property (nonatomic,strong) IBOutlet UIImageView * wifi;

@end
