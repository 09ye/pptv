//
//  SHCollectCell.m
//  PPTV
//
//  Created by yebaohua on 14/12/16.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHCollectCell.h"

@implementation SHCollectCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)loadSkin
{
    self.selectedBackgroundView.backgroundColor = [SHSkin.instance colorOfStyle:@"ColorBackGroundRightView"];
    self.backgroundColor =  [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];;;
}
@end
