//
//  SHDownloadCollectionViewCell.m
//  PPTV
//
//  Created by yebaohua on 14/12/24.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHDownloadCollectionViewCell.h"
#import "ASIHTTPRequest.h"

@implementation SHDownloadCollectionViewCell
@synthesize  detail = _detail;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 在此添加
        
        // 初始化时加载collectionCell.xib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"SHDownloadCollectionViewCell" owner:self options: nil];
        
        // 如果路径不存在，return nil
        if(arrayOfViews.count < 1){return nil;}
        
        // 如果xib中view不属于UICollectionViewCell类，return nil
        if(![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]){
            return nil;
        }
        
        // 加载nib
        self = [arrayOfViews objectAtIndex:0];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
    self.layer.cornerRadius = 5;
     app  = (AppDelegate*)[UIApplication sharedApplication].delegate;
}
-(void) setDetail:(NSMutableDictionary *)detail_
{
    _detail = detail_;
    for (int i= 0; i<app.requestlist.count; i++) {
        ASIHTTPRequest *request = [app.requestlist objectAtIndex:i];
        NSDictionary *dic =[request.userInfo objectForKey:@"file"];
        if ([dic objectForKey:@"id"] ==[detail_ objectForKey:@"id"]) {
            mRequest = request;
        }
    }
    mRequest.downloadProgressDelegate = self;
    [mRequest setShouldContinueWhenAppEntersBackground:YES]; //监视网络活动
    //记录过去5秒的平均流量字节/秒
   
    mState = Downloading;
    [self.imgPic setUrl:[detail_ objectForKey:@"pic"]];
    self.labTitle.text = [detail_ objectForKey:@"title"];
    switch ([[detail_ objectForKey:@"state"]intValue]) {
        case 0:
            mlabDownstate.text = @"";
            [btnStart setImage:[UIImage imageNamed:@"kaishi"] forState:UIControlStateNormal];
            mlabSize.text = [detail_ objectForKey:@"fileSize"];
            break;
        default:
            break;
    }
    mlabDownstate.text = [detail_ objectForKey:@"fileSize"];
    mlabSize.text = [detail_ objectForKey:@"fileSize"];
    //    cell.labContent.text = [dic objectForKey:@"focus"];
    //    cell.labStatus.text = [dic objectForKey:@"status"];

}
-(void)setProgress:(float)newProgress
{
    mViewProgress.frame = CGRectMake(newProgress*120, 0, 220, 120);
    unsigned long byte = [ASIHTTPRequest averageBandwidthUsedPerSecond];
    int dbyte = byte/5;
    mlabDownstate.text = [NSString stringWithFormat:@"下载中 %d kb/s",dbyte/1024];
    NSString * size = [_detail objectForKey:@"fileSize"];
   float sizenum = [[size substringToIndex:size.length-1]floatValue];
    mlabSize.text = [NSString stringWithFormat:@"%0.1fM/%@",sizenum*newProgress,[_detail objectForKey:@"fileSize"]];
    [btnStart setImage:[UIImage imageNamed:@"xiazai"] forState:UIControlStateNormal];
    NSLog(@"setProgress-%f",newProgress);
}
- (IBAction)btnStartPauseOntouch:(UIButton*)sender {
    
    if(mState == Waiting){

    }else if (mState == Downloading) {
        [mRequest clearDelegatesAndCancel];
        [sender setImage:[UIImage imageNamed:@"zhanting"] forState:UIControlStateNormal];
        mState = Paused;
        mlabDownstate.text = @"已暂停";
    }else if(mState == Paused){
        [mRequest start];
        [_detail setValue:[NSNumber numberWithInt:Downloading] forKey:@"state"];
        [app beginRequest:_detail isBeginDown:NO];
        [self setDetail:_detail];
        [sender setImage:[UIImage imageNamed:@"xiazai"] forState:UIControlStateNormal];
        mState = Downloading;
    }else{
        SHIntent * intent = [[SHIntent alloc ]init];
        intent.target = @"SHTVDetailViewController";
        //    [intent.args setValue:[self. objectAtIndex:indexPath.row] forKey:@"detailInfo"];
//        intent.container = self.navController;
        [[UIApplication sharedApplication] open:intent];
    }
    
}
@end
