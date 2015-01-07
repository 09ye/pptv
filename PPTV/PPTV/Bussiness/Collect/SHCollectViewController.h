//
//  SHCollectViewController.h
//  PPTV
//
//  Created by yebaohua on 14/12/13.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHViewController.h"

@class SHCollectViewController;
@protocol SHCollectViewControllerDelegate <NSObject>

-(void)collectViewControllerDidSelect:(SHCollectViewController *)controllerr videoInfo:(NSDictionary *)dic;

@end
@interface SHCollectViewController : SHTableViewController
{
    __weak IBOutlet UIView *mViewDelete;
    NSMutableArray * mArraySelect;
    
}
@property (nonatomic, weak) id<SHCollectViewControllerDelegate> delegate;
- (IBAction)btnDeleteOntouch:(id)sender;
- (IBAction)btnClearAllOntouch:(id)sender;
- (IBAction)btnCancaleOntouch:(id)sender;

@end
