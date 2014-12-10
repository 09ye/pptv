//
//  SHChannelCollectionViewCell.h
//  PPTV
//
//  Created by yebaohua on 14/11/29.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHChannelCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet SHImageView *imgLogo;
@property (weak, nonatomic) IBOutlet UILabel *labName;
@property (weak, nonatomic) IBOutlet UILabel *labContent;
@end
