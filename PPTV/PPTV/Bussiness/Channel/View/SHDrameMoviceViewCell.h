//
//  SHDrameMoviceViewCell.h
//  PPTV
//
//  Created by yebaohua on 14/12/1.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewCell.h"

@interface SHDrameMoviceViewCell : SHTableViewCell
@property (weak, nonatomic) IBOutlet SHImageView *imgDetail;
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labContent;

@end
