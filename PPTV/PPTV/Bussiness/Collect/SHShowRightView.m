//
//  SHShowRightView.m
//  PPTV
//
//  Created by yebaohua on 14/12/13.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHShowRightView.h"

@implementation SHShowRightView

- (void)loadSkin
{
    self.backgroundColor = [UIColor clearColor];
    mViewContain.backgroundColor = [UIColor whiteColor];
}
- (void)createNavi
{
    for (UIView * view in mViewContain.subviews) {
        [view removeFromSuperview];
    }
    mNavigationController = [[UINavigationController alloc]init];
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[SHSkin.instance colorOfStyle:@"ColorStyleLight"],NSForegroundColorAttributeName,nil];
    [mNavigationController.navigationBar setTitleTextAttributes:attributes];
    mNavigationController.navigationBar.translucent = NO;
//    [mNavigationController.navigationBar setBackgroundImage:([[UIImage imageNamed:@"navigation_bar_bg"] stretchableImageWithLeftCapWidth:5 topCapHeight:10]) forBarMetrics:UIBarMetricsDefault];
//    mNavigationController.navigationBar.tintColor = [SHSkin.instance colorOfStyle:@"ColorLine"];
    mNavigationController.navigationBar.barTintColor = [SHSkin.instance colorOfStyle:@"ColorLine"];
    mNavigationController.navigationBar.clipsToBounds = YES;
    mNavigationController.delegate = self;
    mNavigationController.view.backgroundColor = [UIColor colorWithRed:201/255.0 green:201/255.0 blue:201/255.0 alpha:1];
    mNavigationController.view.frame = mViewContain.bounds;
    [mViewContain addSubview:mNavigationController.view];
    
   
    



   



}
- (void)show:(UIViewController*)controller inView:(UIView *) view  direction:(Direction) direction
{
    
    [self createNavi];
    [mNavigationController pushViewController:controller animated:NO];
    [self showIn:view direction:direction];
}
- (void)showIn:(UIView *) view direction:(Direction) direction
{
    if(self.isShow){
        return;
    }
    self.frame = CGRectMake(0, 64, 1024, 655);
    self.alpha = 0;
    
    mViewContain.frame = CGRectMake( 1024, mViewContain.frame.origin.y, mViewContain.frame.size.width, mViewContain.frame.size.height);
    [view addSubview:self];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 1;
        mViewContain.frame = CGRectMake( mViewContain.frame.origin.x-mViewContain.frame.size.width, mViewContain.frame.origin.y, mViewContain.frame.size.width, mViewContain.frame.size.height);
        
    } completion:^(BOOL finished) {
        
    }];
    self.isShow = YES;
}

- (void)close
{
    
    self.isShow = NO;
    [UIView animateWithDuration:0.5 animations:^{
        mViewContain.frame = CGRectMake( mViewContain.frame.origin.x+mViewContain.frame.size.width, mViewContain.frame.origin.y, mViewContain.frame.size.width, mViewContain.frame.size.height);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}

- (IBAction)btnCloseOnTouch:(id)sender
{
    [self close];
}
@end
