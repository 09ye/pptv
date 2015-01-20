//
//  SHShowVideoViewController.m
//  offer_neptune
//
//  Created by yebaohua on 14-7-1.
//  Copyright (c) 2014年 sheely.paean.coretest. All rights reserved.
//

#import "SHShowVideoViewController.h"
#import "MediaPlayer/MPMoviePlayerController.h"
#import "MediaPlayer/MPVolumeView.h"
#import "MediaPlayer/MPMusicPlayerController.h"
#define DELEGATE_IS_READY(x) (self.delegate && [self.delegate respondsToSelector:@selector(x)])
@interface SHShowVideoViewController ()

@end

@implementation SHShowVideoViewController
@synthesize isfull = _isfull;
@synthesize isLive = _isLive;
@synthesize isStore = _isStore;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Do any additional setup after loading the view from its nib.
    //    self.view.bounds = [[UIScreen mainScreen] bounds];
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:
                         UIActivityIndicatorViewStyleWhiteLarge] ;
    [self.activityCarrier addSubview:self.activityView];
    
    UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc]
                                  initWithTarget:self
                                  action:@selector(progressSliderTapped:)] ;
    [self.progressSld addGestureRecognizer:gr];
    [self.progressSld setThumbImage:[UIImage imageNamed:@"pb-seek-bar-btn"] forState:UIControlStateNormal];
    [self.progressSld setMinimumTrackImage:[UIImage imageNamed:@"pb-seek-bar-fr"] forState:UIControlStateNormal];
    [self.progressSld setMaximumTrackImage:[UIImage imageNamed:@"pb-seek-bar-bg"] forState:UIControlStateNormal];
    
    if (!mMPayer) {
        mMPayer = [VMediaPlayer sharedInstance];
        [mMPayer setupPlayerWithCarrierView:self.carrier withDelegate:self];
        [self setupObservers];
    }
    UIPinchGestureRecognizer * pinchRecongizer = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(scaleRecongizer:)];
    [self.backView addGestureRecognizer:pinchRecongizer];
    UITapGestureRecognizer * tapRecongizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapRecongizer:)];
    [self.backView addGestureRecognizer:tapRecongizer];
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handelPan:)];
    [self.backView  addGestureRecognizer:panGes];
    



    mtimeViewHidden = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(hiddenView) userInfo:nil repeats:YES];
    
    if (_isLive) {
        arrayBtn = [[NSArray alloc]initWithObjects:self.btnSeries,self.btnDeatil, nil];
        mViewControl = self.viewLive;
        mViewMenu = self.viewMenuNo;
        mbtnStore = self.btnStore;
        mSliderVolume = self.sliderVolume2;
        self.viewMenuNo.hidden = NO;
        self.viewMenuDown.hidden = YES;
        self.viewLive.hidden = YES;
        self.viewDemand.hidden = YES;
        self.viewLock.hidden = YES;
        self.durationLbl.hidden = YES;
        self.progressSld.hidden = YES;
        self.curPosLbl.hidden = YES;
        
        
    }else{
        arrayBtn = [[NSArray alloc]initWithObjects:self.btnSeriesDown,self.btnDeatilDown,self.btnDownDown, nil];
        mViewControl = self.viewDemand;
        mViewMenu = self.viewMenuDown;
        mbtnStore = self.btnStoreDown;
        mSliderVolume = self.sliderVolume1;
        self.viewMenuNo.hidden = YES;
        self.viewMenuDown.hidden = NO;
        self.viewLive.hidden = YES;
        self.viewDemand.hidden = NO;
        self.durationLbl.hidden = NO;
        self.progressSld.hidden = NO;
        self.curPosLbl.hidden = NO;
    }
   
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(volumeChanged:) name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];

    MPVolumeView *volumeView = [[MPVolumeView alloc] init];
    volumeView.hidden = YES;
    [self.view addSubview:volumeView];
    [volumeView sizeToFit];

    
//    self.sliderVolume1 = [[UISlider alloc]init];
//    self.sliderVolume1.backgroundColor = [UIColor blueColor];
    for (UIControl *view in volumeView.subviews) {
        if ([view.superclass isSubclassOfClass:[UISlider class]]) {
            NSLog(@"1");
            mSliderSystemVolume = (UISlider *)view;
        }
    }
    mSliderSystemVolume.autoresizesSubviews = NO;
    mSliderSystemVolume.autoresizingMask = UIViewAutoresizingNone;
    [self.view addSubview:mSliderSystemVolume];
    [self.view bringSubviewToFront:mSliderSystemVolume];
    mSliderSystemVolume.hidden = YES;
    mSliderVolume.tag = 1000;
    mSliderVolume.maximumValue = mSliderSystemVolume.maximumValue;
    mSliderVolume.minimumValue = mSliderSystemVolume.minimumValue;
    mSliderVolume.value = mSliderSystemVolume.value;
    [mSliderVolume addTarget:self action:@selector(sliderVolumeOntouch:) forControlEvents:UIControlEventValueChanged];
    
//     self.view.userInteractionEnabled = NO;

}
#pragma  手势
-(void)handelPan:(UIPanGestureRecognizer*)gestureRecognizer{
    [NSRunLoop cancelPreviousPerformRequestsWithTarget:self];//双击事件取消延时
    CGPoint curPoint = [gestureRecognizer locationInView:self.view];
    if([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        self.firstPoint = curPoint;
        NSLog(@"begin====>>>>>%f===%f",curPoint.x ,curPoint.y);

    }
    if([gestureRecognizer state] == UIGestureRecognizerStateChanged) {
        NSLog(@"begin====>>>>>%f===%f",curPoint.x ,curPoint.y);
        self.secondPoint = curPoint;
        if(abs(self.firstPoint.y - self.secondPoint.y)>20){
           mSliderSystemVolume.value += (self.firstPoint.y - self.secondPoint.y)/500.0;   
        }
      
    }
    
    if([gestureRecognizer state] == UIGestureRecognizerStateEnded) {
        NSLog(@"end====>>>>>%f===%f",curPoint.x ,curPoint.y);
        self.firstPoint = self.secondPoint = CGPointZero;
   
    }
    
    
}
-(void) scaleRecongizer :(UIPinchGestureRecognizer*) sender
{
    static CGFloat beganScale;
    if([sender state] == UIGestureRecognizerStateBegan) {
        NSLog(@"begin====>>>>>%f",[(UIPinchGestureRecognizer*)sender scale]);
        beganScale = [(UIPinchGestureRecognizer*)sender scale];
    }
    if([sender state] == UIGestureRecognizerStateEnded) {
        NSLog(@"end====>>>>>%f",[(UIPinchGestureRecognizer*)sender scale]);
        
        NSLog(@"end=3333===>>>>>%f",[(UIPinchGestureRecognizer*)sender scale]-beganScale);
        CGFloat scale = [(UIPinchGestureRecognizer*)sender scale]-beganScale;
        if(scale>0 && !_isfull){// 放大
            
            [self setIsfull:YES];
        }else if(scale<0 && _isfull){
            
            [self setIsfull:NO];
        }
        return;
    }
    
    NSLog(@"scale%f====",[(UIPinchGestureRecognizer*)sender scale]);
}
-(void)tapRecongizer :(UITapGestureRecognizer*)sender
{
    [self resetTimeViewhidden];
    if(_isfull){
        if (isLock) {// b)	如果处于锁屏状态，仅出现锁屏按钮
            if (self.viewLock.hidden) {
                self.viewLock.hidden = NO;
                
            }else{
                self.viewLock.hidden = YES;
                
            }
            
            
        }else{//a)	如果没有处于锁屏状态，唤出全部播控工具条。
            
            if (mViewMenu.hidden) {
//                mViewMenu.hidden = NO;
                mViewControl.hidden = NO;
                self.viewLock.hidden = NO;
                
            }else{
//                mViewMenu.hidden = YES;
                mViewControl.hidden = YES;
                self.viewLock.hidden = YES;
                
            }
            [self viewMenuHiddenAnimate:!mViewMenu.hidden];
        }
    }else{
        [self viewMenuHiddenAnimate:!mViewMenu.hidden];
    }
    
    
}


-(void)resetTimeViewhidden
{
    if (mtimeViewHidden) {
        [mtimeViewHidden invalidate];
        mtimeViewHidden  = nil;
    }
    mtimeViewHidden = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(hiddenView) userInfo:nil repeats:YES];
    
}
-(void) hiddenView
{
    if(!mViewMenu.hidden){
        [self viewMenuHiddenAnimate:YES];
        mViewControl.hidden = YES;
        self.viewLock.hidden = YES;
        [mtimeViewHidden invalidate];
        mtimeViewHidden = nil;
    }
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    //	[self becomeFirstResponder];
    
//    [self currButtonAction:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self resignFirstResponder];
    [self quicklyStopMovie];
    
    [self unSetupObservers];
    
    [mMPayer unSetupPlayer];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    
    [self unSetupObservers];
    
    [mMPayer unSetupPlayer];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];
    
}


- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)to duration:(NSTimeInterval)duration
{
    //	if (UIInterfaceOrientationIsLandscape(to)) {
    //		self.backView.frame = self.view.bounds;
    //	} else {
    //		self.backView.frame = kBackviewDefaultRect;
    //	}
    NSLog(@"NAL 1HUI &&&&&&&&& frame=%@", NSStringFromCGRect(self.carrier.frame));
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    NSLog(@"NAL 2HUI &&&&&&&&& frame=%@", NSStringFromCGRect(self.carrier.frame));
}


#pragma mark - Respond to the Remote Control Events

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)remoteControlReceivedWithEvent:(UIEvent *)event
{
    switch (event.subtype) {
        case UIEventSubtypeRemoteControlTogglePlayPause:
            if ([mMPayer isPlaying]) {
                [mMPayer pause];
            } else {
                [mMPayer start];
            }
            break;
        case UIEventSubtypeRemoteControlPlay:
            [mMPayer start];
            break;
        case UIEventSubtypeRemoteControlPause:
            [mMPayer pause];
            break;
        case UIEventSubtypeRemoteControlPreviousTrack:
            [self prevButtonAction:nil];
            break;
        case UIEventSubtypeRemoteControlNextTrack:
            [self nextButtonAction:nil];
            break;
        default:
            break;
    }
}

- (void)applicationDidEnterForeground:(NSNotification *)notification
{
    
    if (isVideoShow) {
        [mMPayer setVideoShown:YES];
        
    }
    if (![mMPayer isPlaying]) {
        
        [mMPayer start];
        
        [self changeStartPauseImg:NO];
        //        [self.startPause setBackgroundImage:[UIImage imageNamed:@"mediacontroller_pause_normal.png"] forState:UIControlStateNormal];
        
        //		[self.startPause setTitle:@"Pause" forState:UIControlStateNormal];
    }
}

- (void)applicationDidEnterBackground:(NSNotification *)notification
{
    if ([mMPayer isPlaying]) {
        isVideoShow = YES;
        [mMPayer pause];
        [mMPayer setVideoShown:NO];
    }else{
        isVideoShow = NO;
    }
}


#pragma mark - VMediaPlayerDelegate Implement

#pragma mark VMediaPlayerDelegate Implement / Required

- (void)mediaPlayer:(VMediaPlayer *)player didPrepared:(id)arg
{
    [player setVideoFillMode:VMVideoFillModeFit];
    
    mDuration = [player getDuration];
    [player seekTo:mCurPostion];
    [player start];
    
    [self setBtnEnableStatus:YES];
//    self.view.userInteractionEnabled = YES;
    [self stopActivity];
    mSyncSeekTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/3
                                                      target:self
                                                    selector:@selector(syncUIStatus)
                                                    userInfo:nil
                                                     repeats:YES];
}

- (void)mediaPlayer:(VMediaPlayer *)player playbackComplete:(id)arg
{
//    [self goBackButtonAction:nil];
    if (DELEGATE_IS_READY(playCtrlGetNextMediaTitle:lastPlayPos:)) {
        [self.delegate playCtrlGetNextMediaTitle:self lastPlayPos:0];
    }else {
        NSLog(@"WARN: No previous media url found!");
    }
}

- (void)mediaPlayer:(VMediaPlayer *)player error:(id)arg
{
    NSLog(@"NAL 1RRE &&&& VMediaPlayer Error: %@", arg);
    [self showAlertDialog:@"对不起,播放错误未找到对应的播放源！"];
    [self stopActivity];

    [self setBtnEnableStatus:YES];
//    self.view.userInteractionEnabled = YES;
    [self quicklyStopMovie];
}

#pragma mark VMediaPlayerDelegate Implement / Optional

- (void)mediaPlayer:(VMediaPlayer *)player setupManagerPreference:(id)arg
{
    player.decodingSchemeHint = VMDecodingSchemeSoftware;
    player.autoSwitchDecodingScheme = NO;
    // {print_error:368} avformat_open_input: Input/output error : -5   yes
}

- (void)mediaPlayer:(VMediaPlayer *)player setupPlayerPreference:(id)arg
{
    // Set buffer size, default is 1024KB(1*1024*1024).

    [player setBufferSize:517*1024];
    //    [player setAdaptiveStream:YES];
    
    [player setVideoQuality:VMVideoQualityHigh];
    
    //	player.useCache = YES;
    //	[player setCacheDirectory:[self getCacheRootDirectory]];
}

- (void)mediaPlayer:(VMediaPlayer *)player seekComplete:(id)arg
{
}

- (void)mediaPlayer:(VMediaPlayer *)player notSeekable:(id)arg
{
    self.progressDragging = NO;
    NSLog(@"NAL 1HBT &&&&&&&&&&&&&&&&.......&&&&&&&&&&&&&&&&&");
}

- (void)mediaPlayer:(VMediaPlayer *)player bufferingStart:(id)arg
{
    self.progressDragging = YES;
    NSLog(@"NAL 2HBT &&&&&&&&&&&&&&&&.......&&&&&&&&&&&&&&&&&");
    if (![Utilities isLocalMedia:self.videoURL]) {
        [player pause];
        [self changeStartPauseImg:YES];
        //        [self.startPause setBackgroundImage:[UIImage imageNamed:@"mediacontroller_play_normal.png"] forState:UIControlStateNormal];
        //		[self.startPause setTitle:@"Start" forState:UIControlStateNormal];
        [self startActivityWithMsg:@"正在缓冲... 0%"];
    }
}

- (void)mediaPlayer:(VMediaPlayer *)player bufferingUpdate:(id)arg
{
    if (!self.bubbleMsgLbl.hidden) {
        self.bubbleMsgLbl.text = [NSString stringWithFormat:@"正在缓冲... %d%%",
                                  [((NSNumber *)arg) intValue]];
    }
}

- (void)mediaPlayer:(VMediaPlayer *)player bufferingEnd:(id)arg
{
    if (![Utilities isLocalMedia:self.videoURL]) {
        [player start];
        [self changeStartPauseImg:NO];
        //        [self.startPause setBackgroundImage:[UIImage imageNamed:@"mediacontroller_pause"] forState:UIControlStateNormal];
        //		[self.startPause setTitle:@"Pause" forState:UIControlStateNormal];
        [self stopActivity];
    }
    self.progressDragging = NO;
    NSLog(@"NAL 3HBT &&&&&&&&&&&&&&&&.......&&&&&&&&&&&&&&&&&");
}

- (void)mediaPlayer:(VMediaPlayer *)player downloadRate:(id)arg
{
    if (![Utilities isLocalMedia:self.videoURL]) {
        self.downloadRate.text = [NSString stringWithFormat:@"%dKB/s", [arg intValue]];
    } else {
        self.downloadRate.text = nil;
    }
}

- (void)mediaPlayer:(VMediaPlayer *)player videoTrackLagging:(id)arg
{
    //	NSLog(@"NAL 1BGR video lagging....");
}

#pragma mark VMediaPlayerDelegate Implement / Cache

- (void)mediaPlayer:(VMediaPlayer *)player cacheNotAvailable:(id)arg
{
    NSLog(@"NAL .... media can't cache.");
    self.progressSld.segments = nil;
}

- (void)mediaPlayer:(VMediaPlayer *)player cacheStart:(id)arg
{
    NSLog(@"NAL 1GFC .... media caches index : %@", arg);
}

- (void)mediaPlayer:(VMediaPlayer *)player cacheUpdate:(id)arg
{
    NSArray *segs = (NSArray *)arg;
    //	NSLog(@"NAL .... media cacheUpdate, %d, %@", segs.count, segs);
    if (mDuration > 0) {
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
        for (int i = 0; i < segs.count; i++) {
            float val = (float)[segs[i] longLongValue] / mDuration;
            [arr addObject:[NSNumber numberWithFloat:val]];
        }
        self.progressSld.segments = arr;
    }
}

- (void)mediaPlayer:(VMediaPlayer *)player cacheSpeed:(id)arg
{
    //	NSLog(@"NAL .... media cacheSpeed: %dKB/s", [(NSNumber *)arg intValue]);
}

- (void)mediaPlayer:(VMediaPlayer *)player cacheComplete:(id)arg
{
    NSLog(@"NAL .... media cacheComplete");
    self.progressSld.segments = @[@(0.0), @(1.0)];
}


#pragma mark - Convention Methods

#define TEST_Common					1
#define TEST_setOptionsWithKeys		0
#define TEST_setDataSegmentsSource	0

-(void)quicklyPlayMovie:(NSURL*)fileURL title:(NSString*)title seekToPos:(long)pos
{
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    [self setBtnEnableStatus:NO];
//    self.view.userInteractionEnabled = NO;
    
    NSString *docDir = [NSString stringWithFormat:@"%@/Documents", NSHomeDirectory()];
    NSLog(@"NAL &&& Doc: %@", docDir);
    
    //	fileURL = [NSURL URLWithString:@"http://v.17173.com/api/5981245-4.m3u8"];
    
    
    
#if TEST_Common // Test Common
    NSString *abs = [fileURL absoluteString];
    if ([abs rangeOfString:@"://"].length == 0) {
        NSString *docDir = [NSString stringWithFormat:@"%@/Documents", NSHomeDirectory()];
        NSString *videoUrl = [NSString stringWithFormat:@"%@/%@", docDir, abs];
        self.videoURL = [NSURL fileURLWithPath:videoUrl];
    } else {
        self.videoURL = fileURL;
    }
    //    [mMPayer setDataSource:self.videoURL header:nil];
    [mMPayer setDataSource:self.videoURL];
    
#elif TEST_setOptionsWithKeys // Test setOptionsWithKeys:withValues:
    self.videoURL = [NSURL URLWithString:@"http://padlive2-cnc.wasu.cn/cctv7/z.m3u8"]; // This is a live stream.
    NSMutableArray *keys = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *vals = [NSMutableArray arrayWithCapacity:0];
    keys[0] = @"-rtmp_live";
    vals[0] = @"-1";
    
    [mMPayer setDataSource:self.videoURL header:nil];
    [mMPayer setOptionsWithKeys:keys withValues:vals];
#elif TEST_setDataSegmentsSource // Test setDataSegmentsSource:fileList:
    NSMutableArray *list = [NSMutableArray arrayWithCapacity:0];
    [list addObject:@"http://112.65.235.140/vlive.qqvideo.tc.qq.com/95V8NuxWX2J.p202.1.mp4?vkey=E3D97333E93EDF36E56CB85CE0B02018E1001BA5C023DFFD298C0204CD81610CFCE546C79DE6C3E2"];
    [list addObject:@"http://112.65.235.140/vlive.qqvideo.tc.qq.com/95V8NuxWX2J.p202.2.mp4?vkey=5E82F44940C19CCF26610E7E4088438E868AB2CAB5255E5FDE6763484B9B7E967EF9A97D7E54A324"];
    [list addObject:@"http://112.65.235.140/vlive.qqvideo.tc.qq.com/95V8NuxWX2J.p202.3.mp4?vkey=0A1EA30BCB057BAE8746C2D7B07FE4ABF3BD839FF011224F31F7544BFFB647F06A6D5245C57277BC"];
    [list addObject:@"http://112.65.235.140/vlive.qqvideo.tc.qq.com/95V8NuxWX2J.p202.4.mp4?vkey=DF36DC29AD2C2F0BA5A688223AFCD0008BDD681D8B060C9F4739E1A365495CD165E28DFD80E8E41C"];
    [list addObject:@"http://112.65.235.140/vlive.qqvideo.tc.qq.com/95V8NuxWX2J.p202.5.mp4?vkey=76172D18B89A91CDB803889B4C5127741EF4BBD9B90CC54269B89CEEF558B9B286DDE6083ADB8195"];
    [list addObject:@"http://112.65.235.140/vlive.qqvideo.tc.qq.com/95V8NuxWX2J.p202.6.mp4?vkey=27718B68A396DCFBC483321827604179D35F31C41EC57908C0F78D9416690F6986B0766872C2AF60"];
    [list addObject:@"http://112.65.235.140/vlive.qqvideo.tc.qq.com/95V8NuxWX2J.p202.7.mp4?vkey=B56628DD31A60E975CC9EE321DCE2FC9554AF2CE5BC2BFCEFCEEA633F27CDF16CADA9915338AB2E5"];
    [list addObject:@"http://112.65.235.140/vlive.qqvideo.tc.qq.com/95V8NuxWX2J.p202.8.mp4?vkey=40F45871CE7827699FACE57A95CA1FDA58B16A8A2523C738C422ADCBF015F50254C356614EFAFDE0"];
    [list addObject:@"http://112.65.235.140/vlive.qqvideo.tc.qq.com/95V8NuxWX2J.p202.9.mp4?vkey=553157FD5A7607CC1E255D0E26B503FAD842DC509F15D766C31446E8607E60A621F7B9FABC5B8C7D"];
    [list addObject:@"http://112.65.235.140/vlive.qqvideo.tc.qq.com/95V8NuxWX2J.p202.10.mp4?vkey=2968D15E93D1C1A295FC810DA561789487330F8BEA5B408533BF396648400A89924611724FD5BE67"];
    [list addObject:@"http://112.65.235.140/vlive.qqvideo.tc.qq.com/95V8NuxWX2J.p202.11.mp4?vkey=495CDFCAD30945947CE1E43CBD88DE32E505B4D02BD4AAB2F4B17F98EFF702485C270558951A3109"];
    [list addObject:@"http://112.65.235.140/vlive.qqvideo.tc.qq.com/95V8NuxWX2J.p202.12.mp4?vkey=01B5580A0A6F3597D66440C060885AFC7AA03CD7272D36472FBC9C261D72D2E964D254775C574CA3"];
    [list addObject:@"http://112.65.235.140/vlive.qqvideo.tc.qq.com/95V8NuxWX2J.p202.13.mp4?vkey=2256FFE5FABC971F6A0D6889A1EA1CE8E837D17929708C6ACC6F903939076BB926442DBF6F3AD309"];
    [list addObject:@"http://112.65.235.140/vlive.qqvideo.tc.qq.com/95V8NuxWX2J.p202.14.mp4?vkey=77BB2C40B9383BF048206EC357FE5F061A0A16B9242CAD207CBEA3C3C53E50B24056D93E578A400F"];
    [list addObject:@"http://112.65.235.140/vlive.qqvideo.tc.qq.com/95V8NuxWX2J.p202.15.mp4?vkey=1366F026BB6B987C82C58CF707269C091EA086BB1A09430611A6E124A419E04774FE793E11EB64C1"];
    [list addObject:@"http://112.65.235.140/vlive.qqvideo.tc.qq.com/95V8NuxWX2J.p202.16.mp4?vkey=E0F358E64365C5B12614EA74B25C4F87C7E8CD4003DCB2C792850180CF3CD7645BB22E5E57B40CC5"];
    [list addObject:@"http://112.65.235.140/vlive.qqvideo.tc.qq.com/95V8NuxWX2J.p202.17.mp4?vkey=E95EC62FAE0D92BE8A2FE85842B875F2E9B9B07616B8892D1EF18A0C645994E885D65BDAC24EF0FD"];
    [list addObject:@"http://112.65.235.140/vlive.qqvideo.tc.qq.com/95V8NuxWX2J.p202.18.mp4?vkey=48B021C886CFC23E22FA56C71C7C204E300E7D58CBB97867F23CC8F30EB4D1B53ABE41627F7D6610"];
    [list addObject:@"http://112.65.235.140/vlive.qqvideo.tc.qq.com/95V8NuxWX2J.p202.19.mp4?vkey=0D51F428BB12C2C5C015E41997371FC80338924F804D9D688C7B9560C7336A48870873F34189C58D"];
    [mMPayer setDataSegmentsSource:nil fileList:list];
#endif
    [mMPayer prepareAsync];
    mCurPostion = pos;
    if (pos>60000) {
        [self startActivityWithMsg:[NSString stringWithFormat:@"上次观看至第%@分钟，正在全力加载中…",[self stringtTimeToHumanString:pos]]];//上次观看至第N分钟，正在全力加载中…
    }else{
       [self startActivityWithMsg:@"正在全力加载中..."];//上次观看至第N分钟，正在全力加载中…
    }
    
    
}

-(void)quicklyReplayMovie:(NSURL*)fileURL title:(NSString*)title seekToPos:(long)pos
{
    if (mSyncSeekTimer) {
         [self quicklyStopMovie];
    }
    [self quicklyPlayMovie:fileURL title:title seekToPos:pos];
}

-(void)quicklyStopMovie
{
    [mMPayer reset];
    [mSyncSeekTimer invalidate];
    mSyncSeekTimer = nil;
    self.progressSld.value = 0.0;
    self.progressSld.segments = nil;
    self.curPosLbl.text = @"00:00:00";
    self.durationLbl.text = @"00:00:00";
    self.downloadRate.text = nil;
    mDuration = 0;
    mCurPostion = 0;
    [self stopActivity];
    [self setBtnEnableStatus:YES];
    
    [UIApplication sharedApplication].idleTimerDisabled = NO;
//    self.view.userInteractionEnabled = YES;
}
#pragma set
-(void) setIsfull:(BOOL)isfull_
{
    
    _isfull = isfull_;
   
    if (_isfull) {
        mViewControl.hidden = YES;
//        mViewMenu.hidden = YES;
        if(mViewMenu){
            [self viewMenuHiddenAnimate:YES];
        }
   
        self.viewLock.hidden = NO;
        self.startPause.hidden = YES;
        [self.resetBtn setBackgroundImage:[UIImage imageNamed:@"btn_small_normal"] forState:UIControlStateNormal];
        [self.resetBtn setBackgroundImage:[UIImage imageNamed:@"btn_small_select"] forState:UIControlStateHighlighted];
    } else {
        mViewControl.hidden = YES;
//        mViewMenu.hidden = NO;
        if(mViewMenu){
            [self viewMenuHiddenAnimate:NO];
        }
        self.viewLock.hidden = YES;
        self.startPause.hidden = NO;
        
        
        [self.resetBtn setBackgroundImage:[UIImage imageNamed:@"btn_full_normal"] forState:UIControlStateNormal];
        [self.resetBtn setBackgroundImage:[UIImage imageNamed:@"btn_full_select"] forState:UIControlStateHighlighted];
    }
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(showVideoControllerFullScreen:full:)]){
        [self.delegate showVideoControllerFullScreen:self full:isfull_];
    }
}
-(void) setIsStore:(BOOL)isStore_
{
    _isStore = isStore_;
    if (_isStore) {
        [mbtnStore setTitleColor:[SHSkin.instance colorOfStyle:@"ColorTextOrg"] forState:UIControlStateNormal];
        
        [mbtnStore setImage:[UIImage imageNamed:@"ic_video_select_4"] forState:UIControlStateNormal];
    }else{
        [mbtnStore setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [mbtnStore setImage:[UIImage imageNamed:@"ic_video_normal_4"] forState:UIControlStateNormal];
    }
    
}
-(void) viewMenuHiddenAnimate:(BOOL) value
{
    if ((value && mViewMenu.hidden)|| (!value && !mViewMenu.hidden)) {
        return;
    }
    [UIView animateWithDuration:0.5 animations:^{
        
        if(value){
            if(!_isfull){
                mViewMenu.hidden = YES;
            }
//            mViewMenu.alpha = 0;
            CGRect rect = mViewMenu.frame;
            rect.origin.x +=65;
            mViewMenu.frame = rect;
        }else{
            if(_isfull){
                mViewMenu.hidden = NO;
            }
//            mViewMenu.alpha = 0.9;
            CGRect rect = mViewMenu.frame;
            rect.origin.x -=65;
            mViewMenu.frame = rect;
            
        }
        
    } completion:^(BOOL finished) {
        mViewMenu.hidden = value;
    }];
}
#pragma mark - UI Actions

-(void) changeStartPauseImg:(BOOL) isplay
{
    if (isplay) {
        [self.startPause setBackgroundImage:[UIImage imageNamed:@"mediacontroller_play_normal.png"] forState:UIControlStateNormal];
        [self.startPause setBackgroundImage:[UIImage imageNamed:@"mediacontroller_play_select.png"] forState:UIControlStateHighlighted];
        [self.startPause1 setBackgroundImage:[UIImage imageNamed:@"btn_full_start_normal"] forState:UIControlStateNormal];
        [self.startPause1 setBackgroundImage:[UIImage imageNamed:@"btn_full_start_select"] forState:UIControlStateHighlighted];
        [self.startPause2 setBackgroundImage:[UIImage imageNamed:@"btn_full_start_normal"] forState:UIControlStateNormal];
        [self.startPause2 setBackgroundImage:[UIImage imageNamed:@"btn_full_start_select"] forState:UIControlStateHighlighted];
    } else {
        [self.startPause setBackgroundImage:[UIImage imageNamed:@"mediacontroller_pause_normal"] forState:UIControlStateNormal];
        [self.startPause setBackgroundImage:[UIImage imageNamed:@"mediacontroller_pause_select.png"] forState:UIControlStateHighlighted];
        [self.startPause1 setBackgroundImage:[UIImage imageNamed:@"btn_full_pause_normal"] forState:UIControlStateNormal];
        [self.startPause1 setBackgroundImage:[UIImage imageNamed:@"btn_full_pause_select"] forState:UIControlStateHighlighted];
        [self.startPause2 setBackgroundImage:[UIImage imageNamed:@"btn_full_pause_normal"] forState:UIControlStateNormal];
        [self.startPause2 setBackgroundImage:[UIImage imageNamed:@"btn_full_pause_select"] forState:UIControlStateHighlighted];
        
    }
}
-(void) changeVolumImg:(float) volumeValue
{
    if (volumeValue>0) {
        
        [self.btnVolume1 setBackgroundImage:[UIImage imageNamed:@"btn_volume_max_normal"] forState:UIControlStateNormal];
        [self.btnVolume1 setBackgroundImage:[UIImage imageNamed:@"btn_volume_max_select"] forState:UIControlStateHighlighted];
        [self.btnVolume2 setBackgroundImage:[UIImage imageNamed:@"btn_volume_max_normal"] forState:UIControlStateNormal];
        [self.btnVolume2 setBackgroundImage:[UIImage imageNamed:@"btn_volume_max_select"] forState:UIControlStateHighlighted];
    } else {
        [self.btnVolume1 setBackgroundImage:[UIImage imageNamed:@"btn_volume_min_normal"] forState:UIControlStateNormal];
        [self.btnVolume1 setBackgroundImage:[UIImage imageNamed:@"btn_volume_min_select"] forState:UIControlStateHighlighted];
        [self.btnVolume2 setBackgroundImage:[UIImage imageNamed:@"btn_volume_min_normal"] forState:UIControlStateNormal];
        [self.btnVolume2 setBackgroundImage:[UIImage imageNamed:@"btn_volume_min_select"] forState:UIControlStateHighlighted];
        
    }
}
-(NSDictionary *) getRecordInfo;
{
    if(mDuration>0){
        NSMutableDictionary * dic =[[NSMutableDictionary alloc]init];
        [dic setValue: [NSNumber numberWithLong:mDuration] forKey:@"duration"];
        [dic setValue:[NSNumber numberWithLong:[mMPayer getCurrentPosition]] forKey:@"currentPos"];
        return dic;
    }
    return nil;
}
-(IBAction)goBackButtonAction:(id)sender
{
    [self quicklyStopMovie];
    [self dismissModalViewControllerAnimated:YES];
}

-(IBAction)startPauseButtonAction:(id)sender
{ [self resetTimeViewhidden];
    BOOL isPlaying = [mMPayer isPlaying];
    if (isPlaying) {
        [mMPayer pause];
    } else {
        [mMPayer start];
    }
    [self changeStartPauseImg:isPlaying];
}

-(void)currButtonAction:(id)sender
{
    NSURL *url = nil;
    NSString *title = nil;
    long lastPos = 0;
    
    [self quicklyPlayMovie:self.videoURL title:title seekToPos:lastPos];
    
}
// 快退
-(IBAction)prevButtonAction:(id)sender
{
    [self resetTimeViewhidden];
    [self.prevBtn1 setBackgroundImage:[UIImage imageNamed:@"btn_pre_normal"] forState:UIControlStateNormal];
    [self.prevBtn1 setBackgroundImage:[UIImage imageNamed:@"btn_pre_select"] forState:UIControlStateHighlighted];
    
    [self startActivityWithMsg:@"Buffering"];
    [mMPayer seekTo:[mMPayer getCurrentPosition]-30*1000];
//    if (DELEGATE_IS_READY(playCtrlGetPrevMediaTitle:lastPlayPos:)) {
//        [self.delegate playCtrlGetNextMediaTitle:self lastPlayPos:0];
//    }else {
//        NSLog(@"WARN: No previous media url found!");
//    }
}
// 快进
-(IBAction)nextButtonAction:(id)sender
{
    [self resetTimeViewhidden];
    [self.nextBtn1 setBackgroundImage:[UIImage imageNamed:@"btn_next_normal"] forState:UIControlStateNormal];
    [self.nextBtn1 setBackgroundImage:[UIImage imageNamed:@"btn_next_select"] forState:UIControlStateHighlighted];
    
    [self startActivityWithMsg:@"Buffering"];
    [mMPayer seekTo:[mMPayer getCurrentPosition]+25*1000];
    
//    if (DELEGATE_IS_READY(playCtrlGetNextMediaTitle:lastPlayPos:)) {
//        [self.delegate playCtrlGetNextMediaTitle:self lastPlayPos:0];
//    }else {
//        NSLog(@"WARN: No previous media url found!");
//    }
}

-(IBAction)switchVideoViewModeButtonAction:(id)sender
{ [self resetTimeViewhidden];
    static emVMVideoFillMode modes[] = {
        VMVideoFillModeFit,
        VMVideoFillMode100,
        VMVideoFillModeCrop,
        VMVideoFillModeStretch,
    };
    static int curModeIdx = 0;
    
    curModeIdx = (curModeIdx + 1) % (int)(sizeof(modes)/sizeof(modes[0]));
    NSLog(@"emVMVideoFillMode====%d",curModeIdx);
    [mMPayer setVideoFillMode:modes[curModeIdx]];
}

-(IBAction)resetButtonAction:(id)sender
{
    [self resetTimeViewhidden];
    self.isfull = !_isfull;
}


-(IBAction)progressSliderDownAction:(id)sender
{
    [self resetTimeViewhidden];
    self.progressDragging = YES;
    NSLog(@"NAL 4HBT &&&&&&&&&&&&&&&&.......&&&&&&&&&&&&&&&&&");
    NSLog(@"NAL 1DOW &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& Touch Down");
}

-(IBAction)progressSliderUpAction:(id)sender
{
    [self resetTimeViewhidden];
    UISlider *sld = (UISlider *)sender;
    NSLog(@"NAL 1BVC &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& seek = %ld", (long)(sld.value * mDuration));
    [self startActivityWithMsg:@"Buffering"];
    [mMPayer seekTo:(long)(sld.value * mDuration)];
}

-(IBAction)dragProgressSliderAction:(id)sender
{    [self resetTimeViewhidden];
    UISlider *sld = (UISlider *)sender;
    self.curPosLbl.text = [Utilities timeToHumanString:(long)(sld.value * mDuration)];
}

-(void)progressSliderTapped:(UIGestureRecognizer *)g
{
    UISlider* s = (UISlider*)g.view;
    if (s.highlighted)
        return;
    CGPoint pt = [g locationInView:s];
    CGFloat percentage = pt.x / s.bounds.size.width;
    CGFloat delta = percentage * (s.maximumValue - s.minimumValue);
    CGFloat value = s.minimumValue + delta;
    [s setValue:value animated:YES];
    long seek = percentage * mDuration;
    self.curPosLbl.text = [Utilities timeToHumanString:seek];
    NSLog(@"NAL 2BVC &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&& seek = %ld", seek);
    [self startActivityWithMsg:@"Buffering"];
    [mMPayer seekTo:seek];
    
}

- (IBAction)btnMenuOntouch:(UIButton *)sender {
    [self resetTimeViewhidden];
    if(sender.tag != 4){
        for (UIButton * button in arrayBtn) {
            if (button == sender) {
                [button setTitleColor:[SHSkin.instance colorOfStyle:@"ColorTextOrg"] forState:UIControlStateNormal];
                
                [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"ic_video_select_%d",button.tag]] forState:UIControlStateNormal];
            }else{
                [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"ic_video_normal_%d",button.tag]] forState:UIControlStateNormal];
            }
        }
        
        if(_isfull){
            self.isfull = NO;
        }
    }
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(showVideoControllerMenuDidSelct:sender:tag:)]){
        [self.delegate showVideoControllerMenuDidSelct:self sender:sender  tag:sender.tag];
    }
}


- (IBAction)btnLockOntouch:(id)sender {
    [self resetTimeViewhidden];
    if (isLock) {
        isLock = NO;
        mViewControl.hidden = YES;
//        mViewMenu.hidden = YES;
        [self viewMenuHiddenAnimate:YES];
        self.viewProgress.userInteractionEnabled = YES;
        [self.btnLock setBackgroundImage:[UIImage imageNamed:@"btn_unlock_normal"] forState:UIControlStateNormal];
        [self.btnLock setBackgroundImage:[UIImage imageNamed:@"btn_unlock_select"] forState:UIControlStateHighlighted];
        
    }else{
        isLock = YES;
        mViewControl.hidden = YES;
//        mViewMenu.hidden = YES;
        [self viewMenuHiddenAnimate:YES];
        self.viewProgress.userInteractionEnabled = NO;
        [self.btnLock setBackgroundImage:[UIImage imageNamed:@"btn_lock_normal"] forState:UIControlStateNormal];
        [self.btnLock setBackgroundImage:[UIImage imageNamed:@"btn_lock_select"] forState:UIControlStateHighlighted];
    }
}

- (IBAction)btnVolumeOntouch:(UIButton *)sender {
    [self resetTimeViewhidden];
    if (mSliderSystemVolume.value>0) {
        mSliderVolume.value = 0;
        mSliderSystemVolume.value = 0;
        
    } else {
        mSliderVolume.value = 1;
        mSliderSystemVolume.value = 1;
    }
    [self changeVolumImg:mSliderVolume.value];
}
- (void)volumeChanged:(NSNotification *)notification
{
    // service logic here.
    float volume =[[[notification userInfo]objectForKey:@"AVSystemController_AudioVolumeNotificationParameter"]floatValue];
    NSLog(@"volumn is %f", volume);
    mSliderVolume.value = volume;
   
    
}
-(void) sliderVolumeOntouch:(UISlider *)slider
{
    mSliderSystemVolume.value = slider.value;
    mSliderVolume.value = slider.value;
    [self changeVolumImg:mSliderVolume.value];
}


- (IBAction)btnDefintionOntouch:(id)sender {
    [self resetTimeViewhidden];
}

#pragma mark - Sync UI Status

-(void)syncUIStatus
{
    if (!self.progressDragging) {
        mCurPostion  = [mMPayer getCurrentPosition];
        [self.progressSld setValue:(float)mCurPostion/mDuration];
        self.curPosLbl.text = [Utilities timeToHumanString:mCurPostion];
        self.durationLbl.text = [Utilities timeToHumanString:mDuration];
    }
}


#pragma mark Others

-(void)startActivityWithMsg:(NSString *)msg
{
    self.bubbleMsgLbl.hidden = NO;
    self.bubbleMsgLbl.text = msg;
    [self.activityView startAnimating];
}

-(void)stopActivity
{
    self.bubbleMsgLbl.hidden = YES;
    self.bubbleMsgLbl.text = nil;
    [self.activityView stopAnimating];
}

-(void)setBtnEnableStatus:(BOOL)enable
{
    self.startPause.enabled = enable;
    self.prevBtn.enabled = enable;
    self.nextBtn.enabled = enable;
    self.modeBtn.enabled = enable;
    self.resetBtn.enabled = enable;
    self.progressSld.enabled = enable;
    mViewControl.userInteractionEnabled = enable;
}
-(NSString *)stringtTimeToHumanString:(unsigned long)ms {
    unsigned long seconds, h, m, s;
    char buff[128] = { 0 };
    NSString *nsRet = nil;
    
    seconds = ms / 1000;
    h = seconds / 3600;
    m = (seconds - h * 3600) / 60;
    s = seconds - h * 3600 - m * 60;
    snprintf(buff, sizeof(buff), "%02ld:%02ld:%02ld", h, m, s);
    nsRet = [[NSString alloc] initWithCString:buff
                                     encoding:NSUTF8StringEncoding];
    
    
    return [NSString stringWithFormat:@"%ld",h*60+m];
}
- (void)setupObservers
{
    NSNotificationCenter *def = [NSNotificationCenter defaultCenter];
    [def addObserver:self
            selector:@selector(applicationDidEnterForeground:)
                name:UIApplicationDidBecomeActiveNotification
              object:[UIApplication sharedApplication]];
    [def addObserver:self
            selector:@selector(applicationDidEnterBackground:)
                name:UIApplicationWillResignActiveNotification
              object:[UIApplication sharedApplication]];
}

- (void)unSetupObservers
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)showVideoLoadingError
{
    NSString *sError = NSLocalizedString(@"Video cannot be played", @"description");
    NSString *sReason = NSLocalizedString(@"Video cannot be loaded.", @"reason");
    NSDictionary *errorDict = [NSDictionary dictionaryWithObjectsAndKeys:
                               sError, NSLocalizedDescriptionKey,
                               sReason, NSLocalizedFailureReasonErrorKey,
                               nil];
    NSError *error = [NSError errorWithDomain:@"Vitamio" code:0 userInfo:errorDict];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[error localizedDescription]
                                                        message:[error localizedFailureReason]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
    
}

- (NSString *)getCacheRootDirectory
{
    NSString *cache = [NSString stringWithFormat:@"%@/Library/Caches/MediasCaches", NSHomeDirectory()];
    if (![[NSFileManager defaultManager] fileExistsAtPath:cache]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:cache
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:NULL];
    }
    return cache;
}

@end
