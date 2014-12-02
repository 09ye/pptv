//
//  SHDrameMoviceViewCell.m
//  PPTV
//
//  Created by yebaohua on 14/12/1.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHDrameMoviceViewCell.h"

@implementation SHDrameMoviceViewCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void) loadSkin
{
    [super loadSkin];
    self.selectedBackgroundView.backgroundColor = [SHSkin.instance colorOfStyle:@"ColorMoviceSelected"];

}
@end
