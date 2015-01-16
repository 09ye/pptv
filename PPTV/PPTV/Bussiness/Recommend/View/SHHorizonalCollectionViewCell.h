//
//  SHHorizonalCollectionViewCell.h
//  PPTV
//
//  Created by yebaohua on 14/11/18.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHHorizonalCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet SHImageView *imgDeatil;
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labTitle2;
@property (weak, nonatomic) IBOutlet UILabel *labContent;
@property (weak, nonatomic) IBOutlet UILabel *labLogoName;
@property (weak, nonatomic) IBOutlet UILabel *labLogoContent;
@property (weak, nonatomic) IBOutlet UILabel *labStatus;
@property (weak, nonatomic) IBOutlet UIImageView *imgBgState;
@end
