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

@property (nonatomic,strong) NSMutableDictionary * detail;
- (IBAction)btnImgBigOntouch:(UIButton *)sender;
@end
