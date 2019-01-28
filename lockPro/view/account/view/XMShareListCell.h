//
//  XMShareListCell.h
//  lockPro
//
//  Created by 牛付威 on 2018/5/31.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMShareModel.h"

@interface XMShareListCell : UITableViewCell

@property (nonatomic,strong) IBOutlet UIView * bgView;
@property (nonatomic,strong) XMShareModel * shareModel;


@property (nonatomic,strong) IBOutlet UILabel * pos;
@property (nonatomic,strong) IBOutlet UILabel * lockName;
@property (nonatomic,strong) IBOutlet UILabel * fromPerson;
@property (nonatomic,strong) IBOutlet UILabel * startTime;
@property (nonatomic,strong) IBOutlet UILabel * endTime;
@property (nonatomic,strong) IBOutlet UILabel * nickName;
@property (nonatomic,strong) IBOutlet UIImageView * type;

@end

