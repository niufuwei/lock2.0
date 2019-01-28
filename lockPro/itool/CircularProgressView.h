//
//  CircularProgressView.h
//  SellMyiPhone
//
//  Created by Vincent on 1/12/17.
//  Copyright © 2017 zssr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircularProgressView : UIView
/// 0 ~ 100
@property (nonatomic) float progress;

-(void)showProgress;
-(void)hideProgress;
@end
