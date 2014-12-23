//
//  SHRecomendSecondTitleCell.m
//  PPTV
//
//  Created by yebaohua on 14/11/17.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHRecomendSecondTitleCell.h"

@implementation SHRecomendSecondTitleCell
@synthesize detailArray = _detailArray;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void) setDetailArray:(NSMutableArray *)detailArray_
{
    _detailArray = detailArray_;
    
}
- (IBAction)btnImgBigOntouch:(UIButton *)sender {
    SHIntent * intent = [[SHIntent alloc ]init];
    intent.target = @"SHTVDetailViewController";
    [intent.args setValue:[_detailArray objectAtIndex:sender.tag] forKey:@"detailInfo"];
    intent.container = self.navController;
    [[UIApplication sharedApplication] open:intent];
}
@end
