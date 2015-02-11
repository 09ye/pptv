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
    NSDictionary * dic = [_detailArray objectAtIndex:sender.tag];
    if([[dic objectForKey:@"type"]intValue] == 4){
        intent.target = @"WebViewController";
        
    }else if([[dic objectForKey:@"type"]intValue] == 2){
        intent.target = @"SHLiveViewController";
    }else{
        intent.target = @"SHTVDetailViewController";
    }
    [intent.args setValue:dic forKey:@"detailInfo"];
    intent.container = self.navController;
    [[UIApplication sharedApplication] open:intent];
}

- (IBAction)btnHomeOntouch:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFICATION_HOME_TABBAR_DIDSELECT object:[NSNumber numberWithInt:self.tabIndex]];

}
@end
