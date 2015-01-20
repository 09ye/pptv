//
//  SHDownloadCollectionViewCell.h
//  PPTV
//
//  Created by yebaohua on 14/12/24.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SHDownloadCollectionViewCell;

@interface SHDownloadCollectionViewCell : UICollectionViewCell
{
    
    __weak IBOutlet UIView *mViewProgress;
    __weak IBOutlet UILabel *mlabSize;
    __weak IBOutlet UIButton *btnStart;
    __weak IBOutlet UILabel *mlabDownstate;
    __weak IBOutlet UIView *bgView;
    __weak IBOutlet UIImageView *imgCollectionShade;

    ASIHTTPRequest *mRequest;
    DownLoadState  mState;
    AppDelegate *app;
    
}
@property (weak, nonatomic) IBOutlet SHImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (nonatomic,strong) NSMutableDictionary * detail;
@property (nonatomic, assign) BOOL isDelete;
@property (nonatomic,assign) DownLoadState downLoadState;
@property (weak, nonatomic) IBOutlet UIButton *btnDelete;


- (IBAction)btnStartPauseOntouch:(id)sender;


@end
