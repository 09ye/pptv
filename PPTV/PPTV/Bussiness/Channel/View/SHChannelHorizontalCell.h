//
//  SHChannelHorizontalCell.h
//  PPTV
//
//  Created by yebaohua on 14/11/30.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableHorizontalView.h"

@interface SHChannelHorizontalCell : SHTableHorizontalViewCell
@property (weak, nonatomic) IBOutlet SHImageView *imgPic;
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labContent;

@end
