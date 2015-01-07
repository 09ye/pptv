//
//  SHRecordCell.h
//  PPTV
//
//  Created by Ye Baohua on 14/12/31.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewCell.h"

@interface SHRecordCell : SHTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labContent;
@property (weak, nonatomic) IBOutlet UIButton *btnSelect;
@end
