//
//  SHDownloadCollectionViewCell.h
//  PPTV
//
//  Created by yebaohua on 14/12/24.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    DownLoaded,// 完成
    Downloading,//下载中
    Paused,//暂停
    Waiting,// 等待
    
    
}DownLoadState;
@interface SHDownloadCollectionViewCell : UICollectionViewCell
{
    
    __weak IBOutlet UIView *mViewProgress;
    __weak IBOutlet UILabel *mlabSize;
    __weak IBOutlet UIButton *btnStart;
    __weak IBOutlet UILabel *mlabDownstate;
    ASIHTTPRequest *mRequest;
    DownLoadState  mState;
    AppDelegate *app;
    
}
@property (weak, nonatomic) IBOutlet SHImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (nonatomic,strong) NSMutableDictionary * detail;
@property (nonatomic,assign) DownLoadState downLoadState;

- (IBAction)btnStartPauseOntouch:(id)sender;

@end
