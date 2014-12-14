//
//  SHShowRightView.h
//  PPTV
//
//  Created by yebaohua on 14/12/13.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHView.h"
#import "SHCollectViewController.h"
typedef enum
{
    Right,
    Up,//动画方向
   
}Direction;

@interface SHShowRightView : SHView
{
    __weak IBOutlet UIView *mViewContain;
     UINavigationController* mNavigationController;
    SHCollectViewController * mCollectViewController;
}
@property (nonatomic,assign) BOOL isShow;

- (IBAction)btnCloseOnTouch:(id)sender;
- (void)show:(UIViewController*)controller inView:(UIView *) view  direction:(Direction) direction;
- (void)showIn:(UIView *) view  direction:(Direction) direction;

- (void)close;
@end
