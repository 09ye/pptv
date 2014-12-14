//
//  SHRecomendFirstCell.h
//  PPTV
//
//  Created by yebaohua on 14/11/17.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewCell.h"
#import "SHChannelCollectionViewCell.h"

@interface SHRecomendFirstCell : SHTableViewCell
{
     __weak IBOutlet UICollectionView *mCollectView;
    NSMutableArray * mList;
    NSDictionary * mDicSelectSysn;
}
@property(nonatomic,strong) UINavigationController *navController;
@property (weak, nonatomic) IBOutlet SHImageView *imgLive1;
@property (weak, nonatomic) IBOutlet SHImageView *imgLive2;
@property (weak, nonatomic) IBOutlet UILabel *labLive1;
@property (weak, nonatomic) IBOutlet UILabel *labLive2;
@property (weak, nonatomic) IBOutlet UILabel *labLiveSynch;
@property (weak, nonatomic) IBOutlet SHImageView *imgLiveSynch;
@property (weak, nonatomic) IBOutlet SHImageView *imgLiveSynch1;
@property (weak, nonatomic) IBOutlet SHImageView *imgLiveSynch2;
@property (weak, nonatomic) IBOutlet SHImageView *imgLiveSynch3;
@property (weak, nonatomic) IBOutlet SHImageView *imgLiveSynch4;
@property (nonatomic,strong) NSMutableDictionary * detail;
@property (nonatomic,strong) NSMutableArray * listLive;
- (IBAction)btnLiveOntouch:(UIButton *)sender;
- (IBAction)btnLiveSynchOntouch:(UIButton *)sender;

@end
