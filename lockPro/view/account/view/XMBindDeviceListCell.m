//
//  XMBindDeviceListCell.m
//  lockPro
//
//  Created by 牛付威 on 2018/6/1.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "XMBindDeviceListCell.h"

@implementation XMBindDeviceListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setLock:(XMSingleLock *)lock{
    self.lockName.text = [NSString stringWithFormat:@"铅封锁编号#%@",lock.SN];
    self.mac.text = lock.macAddr;
    self.time.text = lock.lastWorkTime;
    
    NSString * image =@"lock_close_status";
    if([lock.lockStat integerValue]==1){
        image =@"find_lock_open_status";
    }
    [self.icon setImage:[UIImage imageNamed:image]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
