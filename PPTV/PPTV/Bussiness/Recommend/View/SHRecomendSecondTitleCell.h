//
//  SHRecomendSecondTitleCell.h
//  PPTV
//
//  Created by yebaohua on 14/11/17.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewCell.h"

@interface SHRecomendSecondTitleCell : SHTableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btnBg;
@property (weak, nonatomic) IBOutlet UIImageView *imgLogo;
@property (weak, nonatomic) IBOutlet UILabel *labNameLogo;
@property (weak, nonatomic) IBOutlet UILabel *labContentLogo;
@property (weak, nonatomic) IBOutlet SHImageView *imgBig1;
@property (weak, nonatomic) IBOutlet SHImageView *imgBig2;
@property(nonatomic,strong) UINavigationController *navController;

@property (nonatomic,strong) NSMutableArray * detailArray;
@property (nonatomic,assign)int tabIndex;
- (IBAction)btnImgBigOntouch:(UIButton *)sender;
- (IBAction)btnHomeOntouch:(UIButton *)sender;
@end
