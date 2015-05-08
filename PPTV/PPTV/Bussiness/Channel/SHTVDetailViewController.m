//
//  SHTVDetailViewController.m
//  PPTV
//
//  Created by yebaohua on 14/11/19.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//
// detailInfo
#import "SHTVDetailViewController.h"
#import "SHChannelHorizontalCell.h"
#import "FileModel.h"


@interface SHTVDetailViewController ()

@end

@implementation SHTVDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    self.view.backgroundColor =[SHSkin.instance colorOfStyle:@"ColorBackGroundVideo"];
    
    AppDelegate* app=(AppDelegate*)[UIApplication sharedApplication].delegate;
    
    dicPreInfo = [self.intent.args objectForKey:@"detailInfo"];
//    self.leftTitle = [dicPreInfo objectForKey:@"title"];
    mScrollview.datasource = self;
    mScrollview.delegate = self;
    
    
    
    
    mShowViewControll = [[SHShowVideoViewController alloc]init];
    mShowViewControll.delegate = self;
    mShowViewControll.view.frame = CGRectMake(0, 0, UIScreenWidth, UIScreenHeight);
    mShowViewControll.isfull = YES;
//    mShowViewControll.navController = self.navigationController;
    mShowViewControll.videoType = emDemand;
    [self.view addSubview:mShowViewControll.view];
    
    arrayCollect = [[NSMutableArray alloc]init];
    
    NSData * data  = [[NSUserDefaults standardUserDefaults] valueForKey:COLLECT_LIST];
    if (data) {
        arrayCollect = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    
    if ([Utility containsObject:arrayCollect forKey:@"id" forValue:[dicPreInfo objectForKey:@"id"]]) {
        mShowViewControll.isStore = YES;
    }
    
    arrayRecord = [[NSMutableArray alloc]init];
    NSData * data2  = [[NSUserDefaults standardUserDefaults] valueForKey:RECORD_LIST];
    if (data2) {
        arrayRecord = [NSKeyedUnarchiver unarchiveObjectWithData:data2];
    }

    [self request:[dicPreInfo objectForKey:@"id"]];

    
    mTimeLog  = [NSTimer scheduledTimerWithTimeInterval:5*60 target:self selector:@selector(requestOnline) userInfo:nil repeats:YES];
    
    
}
-(void)requestOnline
{
    if (mResultDetail) {
        NSMutableDictionary * dic  = [[NSMutableDictionary alloc]init];
        [dic setValue:@"在线统计" forKey:@"DMec"];
        [dic setValue:@"点播" forKey:@"DMel"];
        NSString * string  = [NSString stringWithFormat:@"%@|%@|%@",mVideotitle,[mResultDetail objectForKey:@"id"],[mResultDetail objectForKey:@"pname"]];//标题|视频id|栏目
        [dic setValue:string forKey:@"DMeo"];
        [SHStatisticalData requestDmaevent:dic];
    }
}

-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    [self recordVideoDate];
}
-(void) request:(NSString *)videoID
{
    [mShowViewControll request:@"102345" gid:@"p4841"];// ad
    [self recordVideoDate];
    
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"Pad/vodinfo");
    [post.postArgs setValue:videoID forKey:@"id"];
    [post.postArgs setValue:SHEntironment.instance.version.description forKey:@"version"];
    post.delegate = self;
    [post start:^(SHTask *t) {

        mResultDetail = [[t result]mutableCopy];        
        mVideotitle = [mResultDetail objectForKey:@"title"];
        self.leftTitle = mVideotitle;
        mVideoUrl = @"";
        NSDictionary *urls = [mResultDetail objectForKey:@"vods"];
        NSArray *keys = urls.allKeys;
        for (int i = 0; i< keys.count; i++) {
            if (![[urls objectForKey:[keys objectAtIndex:i]] isEqualToString:@""]) {
                mVideoUrl = [urls objectForKey:[keys objectAtIndex:i]];
                break;
            }
        }
        NSURL * videoUrl = [NSURL URLWithString:[Utility encodeVideoUrl:mVideoUrl]];
        if ([self.intent.args objectForKey:@"urlPath"] && ![[self.intent.args objectForKey:@"urlPath"] isEqualToString:@""]) {
            mVideoUrl = [self.intent.args objectForKey:@"urlPath"];
            videoUrl = [[NSURL alloc]initFileURLWithPath:mVideoUrl];
        }
//        NSString * msg = [NSString stringWithFormat:@"收到数据===%@\n 转换后的链接：==%@",mVideoUrl,[Utility encodeVideoUrl:mVideoUrl]];
//        UIAlertView * alter = [[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"xx", nil];
//        [alter show];
        
        
        
        [mShowViewControll quicklyReplayMovie:videoUrl title:[mResultDetail objectForKey:@"title"] seekToPos:[self getVideoRecordSeek]];
        if (mDrameViewControll ==nil) {// 剧集
            mDrameViewControll = [[SHTVDrameViewController alloc]init];
            mDrameViewControll.view.frame = mViewContent.bounds;
            mDrameViewControll.delegate = self;
        }
        [mDrameViewControll refresh:[mResultDetail objectForKey:@"id"]];
        
        [mViewContent addSubview:mDrameViewControll.view];
        if (mDemandDetailViewControll==nil) {// 详情
            mDemandDetailViewControll = [[SHDemandDetailViewController alloc]init];
            mDemandDetailViewControll.view.frame = mViewContent.bounds;
        }
        mDemandDetailViewControll.detail = [mResultDetail mutableCopy];
        if (mMoviceDownloadViewControll == nil) {
            mMoviceDownloadViewControll = [[SHMoviceDownloadViewController alloc]init];
            mMoviceDownloadViewControll.view.frame = mViewContent.bounds;
            mMoviceDownloadViewControll.detail = [mResultDetail mutableCopy];
        }
        
        NSMutableDictionary * dic  = [[NSMutableDictionary alloc]init];
        [dic setValue:@"视频监测" forKey:@"DMec"];
        
        NSString * string  = [NSString stringWithFormat:@"%@|%@|%@|%@",[mResultDetail objectForKey:@"pid"],[mResultDetail objectForKey:@"pname"],mVideotitle,[mResultDetail objectForKey:@"id"]];//频道名称|频道ID|节目名称|节目ID
        [dic setValue:string forKey:@"DMel"];
        [dic setValue:[NSDate stringFromDate:[NSDate date] withFormat:@"HH"] forKey:@"DMeo"];
        [SHStatisticalData requestDmaevent:dic];
        
        // 大家都在看
        SHPostTaskM * post = [[SHPostTaskM alloc]init];
        post.URL = URL_FOR(@"Pad/recominfo");
        [post.postArgs setValue:SHEntironment.instance.version.description forKey:@"version"];
        [post.postArgs setValue:[mResultDetail objectForKey:@"id"] forKey:@"id"];
        post.delegate = self;
        [post start:^(SHTask *task) {
            NSDictionary * dic  =[[task result]mutableCopy];
            mLabTitleRec.text = [dic objectForKey:@"title"];
            if ([[dic objectForKey:@"title"] caseInsensitiveCompare:@"大家都在看"] != NSOrderedSame) {
                [mImgRec setImage:[UIImage imageNamed:@"cainixihuan"]];
            }
            mList = [[dic objectForKey:@"list"]mutableCopy];
            [mScrollview reloadData];
        } taskWillTry:^(SHTask *task) {
            
        } taskDidFailed:^(SHTask *task) {
            
        }];
        
        
    } taskWillTry:^(SHTask *t) {
        
    } taskDidFailed:^(SHTask *t) {
        [t.respinfo show];
    }];

}


- (SHTableHorizontalViewCell*) tableView:(SHTableHorizontalView *)tableView cellForColumnAtIndexPath:(NSIndexPath *)indexPath
{
    
    SHTableHorizontalViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"defalut_cell"];
    if(cell == nil){
        NSArray * array = [[NSBundle mainBundle] loadNibNamed:@"SHChannelHorizontalCell" owner:nil options:nil];
        cell = [array objectAtIndex:0];
        cell.identifier = @"defalut_cell";
    }
    NSDictionary * dic = [mList objectAtIndex:indexPath.row];
    [((SHChannelHorizontalCell*)cell).imgPic setUrl:[dic objectForKey:@"pic"]];
    ((SHChannelHorizontalCell*)cell).labTitle.text = [dic objectForKey:@"title"];
    ((SHChannelHorizontalCell*)cell).labContent.text = [dic objectForKey:@"focus"];
    
    return cell;
    
}
- (NSInteger)tableView:(SHTableHorizontalView *)tableView numberOfColumnInSection:(NSInteger)section
{
    
    return mList.count;
}

- (void)tableView:(SHTableHorizontalView *)tableView didSelectColumnAtIndexPath:(NSIndexPath *)indexPath
{
    //    CGRect rectInTableView = [tableView rectForRowAtIndexPath:indexPath];
    //    CGRect rect = [tableView convertRect:rectInTableView toView:[tableView superview]];
//    [mScrollview selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];


    [self request:[[mList objectAtIndex:indexPath.row] objectForKey:@"id"]];
    
}
#pragma video delegate
- (void)playCtrlGetNextMediaTitle:(SHShowVideoViewController *)control lastPlayPos:(long *)lastPlayPos
{
    
    if (![mDrameViewControll showNextVideo]) {
        NSIndexPath *indexPath =[self.tableView indexPathForSelectedRow];
        if (indexPath && indexPath.row+1<mList.count) {

            [self request:[[mList objectAtIndex:indexPath.row+1] objectForKey:@"id"]];

        }else if(!indexPath && mList.count>0){
            [self request:[[mList objectAtIndex:0] objectForKey:@"id"]];
        }else{
           [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
    
//    [mShowViewControll quicklyReplayMovie:[NSURL URLWithString:mVideoUrl] title:mVideotitle seekToPos:0];
}

- (void) showVideoControllerFullScreen:(SHShowVideoViewController*) control full:(BOOL) isFull
{

    [UIView animateWithDuration:0.3 animations:^{
        if (isFull) {
            

            mShowViewControll.view.frame = self.view.bounds;
//            [[UIApplication sharedApplication] setStatusBarHidden:YES];
//            [self.navigationController setNavigationBarHidden:YES animated:YES];
//            [self.view bringSubviewToFront:mShowViewControll.view];
            
        } else {

            mShowViewControll.view.frame = mViewVideo.frame;
           
        }
    }completion:^(BOOL finished) {
        
    }];
}
-(void) showVideoControllerMenuDidSelct:(SHShowVideoViewController *)control sender:(UIButton *)sender tag:(int)tag
{
    
    [self changeRightViewContent:tag];
}

-(void) drameDidSelect:(SHTVDrameViewController*)controll info:(NSDictionary*)detail
{
    [self request:[detail objectForKey:@"id"]];
}
#pragma  菜单响应变化
-(void) changeRightViewContent:(int) index
{
    for (UIView * view in mViewContent.subviews) {
        [view removeFromSuperview];
    }
    switch (index) {
        case 1:// 剧集
            mDrameViewControll.isDownload = NO;
            [mViewContent addSubview:mDrameViewControll.view];
            break;
        case 2:// 详情
            [mViewContent addSubview:mDemandDetailViewControll.view];
            break;
        case 3:// 下载
        {
            if ([[mResultDetail objectForKey:@"pid"]intValue] == 1) {// 电影
                [mViewContent addSubview:mMoviceDownloadViewControll.view];
            }else{
                mDrameViewControll.isDownload = YES;
                [mViewContent addSubview:mDrameViewControll.view];
            }
           

        }
            break;
        case 4://收藏
        {
            if([Utility containsObject:arrayCollect forKey:@"id" forValue:[mResultDetail objectForKey:@"id"]]){// 取消收藏
                mShowViewControll.isStore = NO;
                [Utility removeObject:arrayCollect forKey:@"id" forValue:[mResultDetail objectForKey:@"id"]];
            }else{
                mShowViewControll.isStore = YES;
                NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
                [dic setValue:[mResultDetail objectForKey:@"id"] forKey:@"id"];
                [dic setValue:mVideotitle forKey:@"title"];
                [dic setValue:[mResultDetail objectForKey:@"cid"] forKey:@"type"];
                [arrayCollect insertObject:dic atIndex:0];
                if (arrayCollect.count>50) {
                    [arrayCollect removeObjectAtIndex:arrayCollect.count-1];
                }
            }
            NSData * data = [NSKeyedArchiver archivedDataWithRootObject:arrayCollect];
            [[NSUserDefaults standardUserDefaults ] setValue:data forKey:COLLECT_LIST];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
        }
            break;
            
        default:
            break;
    }
}
-(void) recordVideoDate
{
    if(mResultDetail){
        NSMutableDictionary * recordInfo = [[NSMutableDictionary alloc]init];
        [recordInfo setValue:[NSDate stringFromDate:[NSDate date] withFormat:@"yyyy-MM-dd"] forKey:@"date"];
        [recordInfo setValue:[mResultDetail objectForKey:@"id"] forKey:@"id"];
        [recordInfo setValue:[mResultDetail objectForKey:@"title"] forKey:@"title"];
        [recordInfo setValuesForKeysWithDictionary:[mShowViewControll getRecordInfo]];
        for (NSDictionary * dic in arrayRecord) {
            if ([[dic objectForKey:@"id"] isEqualToString:[mResultDetail objectForKey:@"id"]]) {
                [arrayRecord removeObject:dic];
                break;
            }
        }
        [arrayRecord insertObject:recordInfo atIndex:0];
        NSData * data = [NSKeyedArchiver archivedDataWithRootObject:arrayRecord];
        [[NSUserDefaults standardUserDefaults ] setValue:data forKey:RECORD_LIST];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSMutableDictionary * dic  = [[NSMutableDictionary alloc]init];
        [dic setValue:@"播放时长监测" forKey:@"DMec"];
        
        NSString * string  = [NSString stringWithFormat:@"%@|%0.0lf",[mResultDetail objectForKey:@"id"],[[recordInfo objectForKey:@"currentPos"]doubleValue]/1000];//视频ID|播放时间'，时间的单位为秒
        [dic setValue:string forKey:@"DMel"];
        [dic setValue:[NSDate stringFromDate:[NSDate date] withFormat:@"HH"] forKey:@"DMeo"];
        [SHStatisticalData requestDmaevent:dic];
    }
   
    
}
-(long)getVideoRecordSeek{
    for (NSDictionary * dic in arrayRecord) {
        if ([[dic objectForKey:@"id"] isEqualToString:[mResultDetail objectForKey:@"id"]]) {
            return    [[dic objectForKey:@"currentPos"]longValue] ;
            
        }
    }
    return 0;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) dealloc
{
    
}


@end
