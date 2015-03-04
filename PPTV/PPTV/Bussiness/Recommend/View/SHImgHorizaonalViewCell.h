//
//  SHImgHorizaonalViewCell.h
//  PPTV
//
//  Created by yebaohua on 14/11/18.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewCell.h"

@interface SHImgHorizaonalViewCell : SHTableViewCell
{
    __weak IBOutlet UICollectionView *mCollectView;


}
@property(nonatomic,strong) UINavigationController *navController;
@property (nonatomic,assign) int type;//0 一般的 1综艺 12 纪录片
@property (nonatomic,strong) NSMutableDictionary * detail;
@property (nonatomic,strong) NSArray * list;
@property (nonatomic,assign) BOOL isHiddenLive;
@end
