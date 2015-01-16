//
//  SHChannelHorizontalCell.m
//  PPTV
//
//  Created by yebaohua on 14/11/30.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHChannelHorizontalCell.h"

@implementation SHChannelHorizontalCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    if(selected){
        self.backgroundColor = [SHSkin.instance colorOfStyle:@"ColorStyleCellSelected"];
    }else{
        self.backgroundColor = [UIColor whiteColor];
    }
}

@end
