//
//  tabbarViewController.m
//  artists
//
//  Created by niufuwei on 13-12-15.
//  Copyright (c) 2013年 niufuwei. All rights reserved.
//

#import "XMTabbarViewController.h"
#import "AppDelegate.h"
#import "XMTabbarItem.h"
#import "XMLoginViewController.h"

@interface XMTabbarViewController ()

@end

@implementation XMTabbarViewController
{
    XMTabbarItem * tabbarButton;
    NSArray * no_select_tabbarArray;
    NSArray * selected_tabbarArray;
    NSInteger tempIndex;
  
}


-(void)setButtonIndex:(NSInteger)index
{
    currentPage = index;
    [self setButtonType:index];
}
- (void) hideTabBar:(BOOL) hidden{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0];
    
    for(UIView *view in self.tabBarController.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            if (hidden) {
                [view setFrame:CGRectMake(view.frame.origin.x, iPhone5?568:480, view.frame.size.width, view.frame.size.height)];
            } else {
                [view setFrame:CGRectMake(view.frame.origin.x, iPhone5?568-49:480-49, view.frame.size.width, view.frame.size.height)];
            }
        }
        else
        {
            if (hidden) {
                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, iPhone5?568:480)];
            } else {
                [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width,  iPhone5?568-49:480-49)];
            }
        }
    }
    
    [UIView commitAnimations];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)createCustomTabBar
{
    tabbarBG = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-49, self.view.frame.size.width, 49)];
   
//    tabbarBG.image = [UIImage imageNamed:@"ground_bar.png"];
  
    
    tabbarBG.userInteractionEnabled = YES;
    [self.view addSubview:tabbarBG];
    
    
    
//    UIView * lineImage = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
//    lineImage.backgroundColor = [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.1];
//    [_tabbarBG addSubview:lineImage];
//    
    
//    itemBG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tabbar_item_selected.png"]];
    [tabbarBG addSubview:itemBG];
    currentPage =1;
     no_select_tabbarArray = @[
                              @{@"name":@"我的车辆",@"icon":@"home_tabbar_no"},
                              @{@"name":@"我的好友",@"icon":@"friend_tabbar_no"},
                              @{@"name":@"服务",@"icon":@"service_tabbar_no"}];
    selected_tabbarArray = @[
                              @{@"name":@"我的车辆",@"icon":@"home_tabbar_yes"},
                              @{@"name":@"我的好友",@"icon":@"friend_tabbar_yes"},
                              @{@"name":@"服务",@"icon":@"service_tabbar_yes"}];
    int width = self.view.frame.size.width/[no_select_tabbarArray count];
    for(int i = 0 ; i < [no_select_tabbarArray count] ;i++)
    {
        tabbarButton= [[XMTabbarItem alloc] initWithFrame:CGRectMake(i*width, 0.0, width, 49.0)];
        tabbarButton.tag = i+1;
        [tabbarButton setBackgroundColor:[UIColor whiteColor]];
        [tabbarButton addTarget:self action:@selector(buttonTabbar_click:) forControlEvents:UIControlEventTouchUpInside];
        tabbarButton.selected = YES;
        tabbarButton.itemTitle.text =[no_select_tabbarArray[i] objectForKey:@"name"];
        tabbarButton.adjustsImageWhenHighlighted = FALSE;
        tabbarButton.itemTitle.textColor =i==0?[UIColor colorWithRed:91.0/255.0 green:208.0/255.0 blue:83.0/255.0 alpha:1]:[UIColor grayColor];
        [tabbarBG addSubview:tabbarButton];
        if(i==0){
            [tabbarButton.itemIcon setImage:[UIImage imageNamed:[selected_tabbarArray[i] objectForKey:@"icon"]]];
            
        }
        else{
            [tabbarButton.itemIcon setImage:[UIImage imageNamed:[no_select_tabbarArray[i] objectForKey:@"icon"]]];
            
        }
    }
}


-(void)updateTabbar:(NSArray*)arr{
    for(XMTabbarItem * btn in tabbarBG.subviews) {
        [btn.itemIcon setImage:[UIImage imageNamed:[arr[btn.tag-1] objectForKey:@"icon"]]];
    }

}


-(void)buttonTabbar_click:(id)sender{
    UIButton * btn = (UIButton*)sender;
    tempIndex= btn.tag;
    if(currentPage ==tempIndex)
    {
        
    }
    else
    {
        currentPage = btn.tag;
        [self setButtonType:currentPage];
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
//    [self show_custom_view_layer];
    self.tabBar.hidden = YES;
    //[self.tabBar removeFromSuperview];
    [self createCustomTabBar];
}

-(void)setButtonType:(NSInteger)index
{
    for(XMTabbarItem * btn in tabbarBG.subviews) {
        if(btn.tag == index)
        {
            btn.itemTitle.textColor = [UIColor colorWithRed:91.0/255.0 green:208.0/255.0 blue:83.0/255.0 alpha:1];
            [btn.itemIcon setImage:[UIImage imageNamed:[selected_tabbarArray[btn.tag-1] objectForKey:@"icon"]]];
        }else
        {
            btn.itemTitle.textColor = [UIColor grayColor];
            [btn.itemIcon setImage:[UIImage imageNamed:[no_select_tabbarArray[btn.tag-1] objectForKey:@"icon"]]];
        }
    }
  
    self.selectedIndex = index-1;

}
- (void)showTabBar
{

    [UIView setAnimationDuration:0.35];
    tabbarBG.frame = CGRectMake(0, self.view.frame.size.height-49, self.view.frame.size.width, 49);
    [UIView commitAnimations];
    [self makeTabBarHidden:YES];
}
- (void)hideTabBar
{
    [UIView beginAnimations:nil context:NULL];
    
    [UIView setAnimationDuration:0.35];
    tabbarBG.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 49);
    [UIView commitAnimations];
    
    [self makeTabBarHidden:YES];
}


- (void)hideTabBarWithNoAnimation
{
    tabbarBG.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 49);
    
    [self makeTabBarHidden:YES];
}


- (void)showTabBarWithNoAnimation
{
    tabbarBG.frame = CGRectMake(0, self.view.frame.size.height-49, self.view.frame.size.width, 49);
    
    [self makeTabBarHidden:NO];
}



-(void)login
{
//    [appDelegate loginButtonPress];
    
}

-(void)loginSuccessNotification:(NSNotification*)noti
{
//    NSLog(@"%d",tempIndex);
//    currentPage = tempIndex;
//    [self setButtonType:tempIndex];

}

-(void)loginFailureNotification:(NSNotification*)noti
{
        [self setButtonType:currentPage];

}

-(void)makeTabBarHidden:(BOOL)hide {
    // Custom code to hide TabBar
    if ( [self.view.subviews count] < 2 ) {
        return;
    }
    
    UIView *contentView;
    if ( [[self.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] ) {
        contentView = [self.view.subviews objectAtIndex:1];
    } else {
        contentView = [self.view.subviews objectAtIndex:0];
    }
    
    if (hide) {
        contentView.frame = self.view.bounds;
    } else {
        contentView.frame = CGRectMake(self.view.bounds.origin.x,
                                       self.view.bounds.origin.y,
                                       self.view.bounds.size.width,
                                       self.view.bounds.size.height -
                                       self.tabBar.frame.size.height);
    }
    
    self.tabBar.hidden = hide;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
