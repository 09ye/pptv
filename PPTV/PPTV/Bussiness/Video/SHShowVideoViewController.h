//
//  SHShowVideoViewController.h
//  offer_neptune
//
//  Created by yebaohua on 14-7-1.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHViewController.h"
#import "Utilities.h"
#import "VSegmentSlider.h"
@class SHShowVideoViewController;
@protocol SHShowVideoViewControllerDelegate <NSObject>

- (NSURL *)playCtrlGetCurrMediaTitle:(NSString **)title lastPlayPos:(long *)lastPlayPos;
- (NSURL *)playCtrlGetNextMediaTitle:(NSString **)title lastPlayPos:(long *)lastPlayPos;
- (NSURL *)playCtrlGetPrevMediaTitle:(NSString **)title lastPlayPos:(long *)lastPlayPos;
- (void) showVideoControllerDidComplete:(SHShowVideoViewController*) control;
- (void) showVideoControllerFullScreen:(SHShowVideoViewController*) control full:(BOOL) isFull;

@end
@interface SHShowVideoViewController : SHViewController<VMediaPlayerDelegate>
{
    VMediaPlayer       *mMPayer;
    long               mDuration;
    long               mCurPostion;
    NSTimer            *mSyncSeekTimer;
}
@property (nonatomic, assign) id<SHShowVideoViewControllerDelegate> delegate;
@property (nonatomic, assign) IBOutlet UIButton *startPause;
@property (nonatomic, assign) IBOutlet UIButton *prevBtn;
@property (nonatomic, assign) IBOutlet UIButton *nextBtn;
@property (nonatomic, assign) IBOutlet UIButton *modeBtn;
@property (nonatomic, assign) IBOutlet UIButton *reset;
@property (nonatomic, assign) IBOutlet UIButton *resetBtn;
@property (nonatomic, assign) IBOutlet VSegmentSlider *progressSld;
@property (nonatomic, assign) IBOutlet UILabel  *curPosLbl;
@property (nonatomic, assign) IBOutlet UILabel  *durationLbl;
@property (nonatomic, assign) IBOutlet UILabel  *bubbleMsgLbl;
@property (nonatomic, assign) IBOutlet UILabel  *downloadRate;
@property (nonatomic, assign) IBOutlet UIView  	*activityCarrier;
@property (nonatomic, assign) IBOutlet UIView  	*backView;
@property (nonatomic, assign) IBOutlet UIView  	*carrier;

@property (nonatomic, copy)   NSURL *videoURL;
@property (nonatomic, retain) UIActivityIndicatorView *activityView;
@property (nonatomic, assign) BOOL progressDragging;
@property (nonatomic,strong) NSString * videoTitle;
@property (nonatomic,strong) NSString * videoUrl;
@property (nonatomic, assign) BOOL isfull;

- (void)showIn:(UIView *)view;

- (IBAction)btnCloseOnTouch:(id)sender;

@end
