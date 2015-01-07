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
- (void)playCtrlGetNextMediaTitle:(SHShowVideoViewController *)control lastPlayPos:(long *)lastPlayPos;
- (void)playCtrlGetPrevMediaTitle:(SHShowVideoViewController **)control lastPlayPos:(long *)lastPlayPo;

//- (void) showVideoControllerDidComplete:(SHShowVideoViewController*) control;
- (void) showVideoControllerFullScreen:(SHShowVideoViewController*) control full:(BOOL) isFull;

-(void) showVideoControllerMenuDidSelct:(SHShowVideoViewController *)control sender:(UIButton*) sender tag:(int) tag;
@end
@interface SHShowVideoViewController : SHViewController<VMediaPlayerDelegate>
{
    VMediaPlayer       *mMPayer;
    long               mDuration;
    long               mCurPostion;
    NSTimer            *mSyncSeekTimer;
    NSTimer * mtimeViewHidden;
   
    UIView * mViewControl;
    UIView * mViewMenu;
    UIButton * mbtnStore;
    
    NSArray * arrayBtn;
    BOOL isVideoShow;
    BOOL isLock;
    UISlider * mSliderSystemVolume;
    UISlider * mSliderVolume;

}
@property (weak, nonatomic) IBOutlet UIView *viewMenuDown;
@property (weak, nonatomic) IBOutlet UIButton *btnSeriesDown;
@property (weak, nonatomic) IBOutlet UIButton *btnDeatilDown;
@property (weak, nonatomic) IBOutlet UIButton *btnDownDown;
@property (weak, nonatomic) IBOutlet UIButton *btnStoreDown;

@property (weak, nonatomic) IBOutlet UIView *viewMenuNo;
@property (weak, nonatomic) IBOutlet UIButton *btnSeries;
@property (weak, nonatomic) IBOutlet UIButton *btnDeatil;
@property (weak, nonatomic) IBOutlet UIButton *btnStore;

@property (weak, nonatomic) IBOutlet UIView *viewLock;
@property (weak, nonatomic) IBOutlet UIButton *btnLock;

@property (weak, nonatomic) IBOutlet UIView *viewDemand;
@property (weak, nonatomic) IBOutlet UIButton *startPause1;
@property (weak, nonatomic) IBOutlet UIButton *btnVolume1;
@property (weak, nonatomic) IBOutlet UISlider *sliderVolume1;
@property (weak, nonatomic) IBOutlet UIButton *prevBtn1;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn1;
@property (weak, nonatomic) IBOutlet UIButton *btnDefinition;

@property (weak, nonatomic) IBOutlet UIView *viewLive;
@property (weak, nonatomic) IBOutlet UIButton *startPause2;
@property (weak, nonatomic) IBOutlet UIButton *btnVolume2;
@property (weak, nonatomic) IBOutlet UISlider *sliderVolume2;

@property (nonatomic,assign)CGPoint firstPoint;
@property (nonatomic,assign)CGPoint secondPoint;


@property (nonatomic, weak) id<SHShowVideoViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIView *viewProgress;
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

-(void)quicklyPlayMovie:(NSURL*)fileURL title:(NSString*)title seekToPos:(long)pos;
-(void)quicklyReplayMovie:(NSURL*)fileURL title:(NSString*)title seekToPos:(long)pos;

- (IBAction)btnDefintionOntouch:(id)sender;

@property (nonatomic, copy)   NSURL *videoURL;
@property (nonatomic, retain) UIActivityIndicatorView *activityView;
@property (nonatomic, assign) BOOL progressDragging;
@property (nonatomic, assign) BOOL isfull;
@property (nonatomic, assign) BOOL isLive;
@property (nonatomic,assign)  BOOL isStore;
- (IBAction)btnMenuOntouch:(UIButton *)sender;
- (IBAction)btnLockOntouch:(id)sender;
- (IBAction)btnVolumeOntouch:(UIButton *)sender;


- (void)showIn:(UIView *)view;

- (IBAction)btnCloseOnTouch:(id)sender;

-(NSDictionary *) getRecordInfo;

@end
