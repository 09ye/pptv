//
//  SHImgVertiaclViewCell.h
//  PPTV
//
//  Created by yebaohua on 14/11/17.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewCell.h"
#import "SHShowVideoViewController.H"


@interface SHImgVertiaclViewCell : SHTableViewCell
{
    __weak IBOutlet UICollectionView *mCollectView;
    SHShowVideoViewController* mShowViewControll;
    
}
@property(nonatomic,strong) UINavigationController *navController;
@property(nonatomic,strong) NSMutableArray * list;
@end
