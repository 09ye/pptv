//
//  SHSettingCell.h
//  PPTV
//
//  Created by yebaohua on 14/12/20.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewCell.h"

@interface SHSettingCell : SHTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labContent;
@property (weak, nonatomic) IBOutlet UIImageView *imgChoose;
@property (weak, nonatomic) IBOutlet UIView *viewLine;

@end
