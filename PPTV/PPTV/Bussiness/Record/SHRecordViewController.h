//
//  SHRecordViewController.h
//  PPTV
//
//  Created by yebaohua on 14/12/13.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHViewController.h"
@class SHRecordViewController;
@protocol SHRecordViewControllerDelegate <NSObject>

-(void)recordViewControllerDidSelect:(SHRecordViewController *)controllerr videoInfo:(NSDictionary *)dic;

@end
@interface SHRecordViewController : SHTableViewController
{
    __weak IBOutlet UIView *mViewDelete;
     NSMutableArray * mArraySelect;
    NSMutableDictionary * mSection;
}
@property (nonatomic, weak) id<SHRecordViewControllerDelegate> delegate;

- (IBAction)btnDeleteOntouch:(id)sender;
- (IBAction)btnClearAllOntouch:(id)sender;
- (IBAction)btnCancaleOntouch:(id)sender;
@end
