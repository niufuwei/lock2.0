//
//  XMShowPicArrayViewController.h
//  xmjr
//
//  Created by laoniu on 2018/3/24.
//  Copyright © 2018年 xiaoma. All rights reserved.
//

#import "XMViewController.h"
#import "JCTopic.h"

@interface XMShowPicArrayViewController : XMViewController
@property(nonatomic,strong)JCTopic * Topic;
+(void)showImageArr:(NSArray*)imageArray;
@end
