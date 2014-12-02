//
//  SHRecomendSecondTitleCell.m
//  PPTV
//
//  Created by yebaohua on 14/11/17.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHRecomendSecondTitleCell.h"

@implementation SHRecomendSecondTitleCell
@synthesize detail = _detail;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void) setDetail:(NSMutableDictionary *)detail_
{
    _detail = detail_;
    self.imgBig1.image = [UIImage imageNamed:@"ic_home_title_default2"];
    self.imgBig2.image = [UIImage imageNamed:@"ic_home_title_default2"];
}
- (IBAction)btnImgBigOntouch:(UIButton *)sender {
    SHIntent * intent = [[SHIntent alloc ]init];
    intent.target = @"SHTVDetailViewController";
    
    [intent.args setValue:[NSNumber numberWithBool:YES] forKey:@"readOnly"];
    intent.container = self.navController;
    [[UIApplication sharedApplication] open:intent];
}
@end
