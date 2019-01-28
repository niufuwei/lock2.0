//
//  XMMydeviceListCell.m
//  lockPro
//
//  Created by 牛付威 on 2018/6/1.
//  Copyright © 2018年 牛付威. All rights reserved.
//

#import "XMMydeviceListCell.h"

@implementation XMMydeviceListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



-(void)setLockRelat:(XMLockRelat *)lockRelat{
    
    self.lockName.text = lockRelat.lockName;
    self.mac.text = lockRelat.macAddr;
    self.cuidPos.text = [[lockRelat.cUid stringByAppendingString:@" "] stringByAppendingString:lockRelat.pos];
    self.number.text = [NSString stringWithFormat:@"操作%@次",lockRelat.authoCnt];
    
    NSString * image = [lockRelat.lockStat integerValue]==1?@"find_lock_open_status":@"lock_close_status";
    [self.lockImage setImage:[UIImage imageNamed:image]];
    
    if([lockRelat.elec floatValue]>100){
        lockRelat.elec =@"100";
    }
    
    if([lockRelat.elec floatValue] < 20){
        self.progress.backgroundColor = COLOR(250, 108, 132);
        [self.progressBGView setImage:[UIImage imageNamed:@"dianchi_no"]];
        
    }else{
        self.progress.backgroundColor = BLACKCOLOR;
        [self.progressBGView setImage:[UIImage imageNamed:@"dianchi_ok"]];
        
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        CGRect proGressWidth = self.progress.frame;
        proGressWidth.size.width = [lockRelat.elec floatValue]/100.0*15;
        self.progress.frame = proGressWidth;
    });
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
