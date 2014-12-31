//
//  SHTVDrameViewController.h
//  PPTV
//
//  Created by yebaohua on 14/12/1.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"
@class SHTVDrameViewController;
@protocol SHTVDrameViewControllerDelegate <NSObject>

-(void) drameDidSelect:(SHTVDrameViewController*)controll info:(NSDictionary*)detail ;
@end
@interface SHTVDrameViewController : SHTableViewController<SHTaskDelegate>
{
    int selctID;
    __weak IBOutlet UIView *mViewDownload;
    __weak IBOutlet UILabel *mlabTitleDown;
     __weak IBOutlet UIView *mViewContain;
    __weak IBOutlet UIScrollView *mScrollviewCate;
    
    __weak IBOutlet UIView *mViewDownSelect;
    __weak IBOutlet UIButton *mbtn1;
    __weak IBOutlet UIButton *mbtn2;
    __weak IBOutlet UIButton *mbtn3;
    __weak IBOutlet UIButton *mbtnMode;

    NSDictionary * mResult;
    NSArray * mListCategory;
    NSMutableArray * arrayBtnCate;
    NSString * mCurrentGroup;
    
}
@property (nonatomic,assign) id <SHTVDrameViewControllerDelegate> delegate;
@property (nonatomic,assign) BOOL isDownload;


- (IBAction)btnDownModeOntouch:(UIButton *)sender;
- (IBAction)btnShowModeOntouch:(id)sender;
- (IBAction)btnModeCloseOntouch:(id)sender;
-(void) refresh:(NSInteger)videoID;
-(BOOL) showNextVideo;
@end
