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
#import <MediaPlayer/MediaPlayer.h>
@class SHShowVideoViewController;
@protocol SHShowVideoViewControllerDelegate <NSObject>

- (NSURL *)playCtrlGetCurrMediaTitle:(NSString **)title lastPlayPos:(long *)lastPlayPos;
- (void)playCtrlGetNextMediaTitle:(SHShowVideoViewController *)control lastPlayPos:(long *)lastPlayPos;
- (void)playCtrlGetPrevMediaTitle:(SHShowVideoViewController **)control lastPlayPos:(long *)lastPlayPo;

//- (void) showVideoControllerDidComplete:(SHShowVideoViewController*) control;
- (void) showVideoControllerFullScreen:(SHShowVideoViewController*) control full:(BOOL) isFull;

-(void) showVideoControllerMenuDidSelct:(SHShowVideoViewController *)control sender:(UIButton*) sender tag:(int) tag;
@end

typedef enum
{
    
    emLiving = 4840,//直播
    emDemand = 4841,//点播
}emVideoType;

@interface SHShowVideoViewController : SHViewController<VMediaPlayerDelegate>
{
    VMediaPlayer       *mMPayer;
    long               mDuration;
    long               mCurPostion;
    NSTimer            *mSyncSeekTimer;
    NSTimer * mtimeViewHidden;
    NSTimer * mTimerAD;
   
    UIView * mViewControl;// 浮在上面的播控条
    UIView * mViewMenu;
    UIButton * mbtnStore;
    
    NSArray * arrayBtn;
    BOOL isVideoShow;
    BOOL isLock;
    UISlider * mSliderSystemVolume;
    UISlider * mSliderVolume;
    
//    MPMoviePlayerViewController *playerViewController;
    NSDictionary *mAdVideo;
    NSDictionary *mAdPauseInfo;

    __weak IBOutlet UIView *mViewPauseAD;
    __weak IBOutlet SHImageView *imgADPause;
    __weak IBOutlet UILabel *labAdTime;
    __weak IBOutlet UIView *mViewVideoControl;// 显示在最下面的播控条
    
    
}
//@property(nonatomic,strong) UINavigationController *navController;
@property (nonatomic,strong) MPMoviePlayerViewController *playerViewController;
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
@property (nonatomic,assign) emVideoType videoType;
- (IBAction)btnMenuOntouch:(UIButton *)sender;
- (IBAction)btnLockOntouch:(id)sender;
- (IBAction)btnVolumeOntouch:(UIButton *)sender;

- (IBAction)btnADPauseDeleteOntouch:(id)sender;
- (IBAction)btnADPauseOntouch:(id)sender;

- (void)showIn:(UIView *)view;

- (IBAction)btnCloseOnTouch:(id)sender;

-(NSDictionary *) getRecordInfo;

-(void) request:(NSString *) aid gid:(NSString*)gid ;

@end
