//
//  SHHorizonalCollectionViewCell.m
//  PPTV
//
//  Created by yebaohua on 14/11/18.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHHorizonalCollectionViewCell.h"

@implementation SHHorizonalCollectionViewCell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 在此添加
        
        // 初始化时加载collectionCell.xib文件
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"SHHorizonalCollectionViewCell" owner:self options: nil];
        
        // 如果路径不存在，return nil
        if(arrayOfViews.count < 1){return nil;}
        
        // 如果xib中view不属于UICollectionViewCell类，return nil
        if(![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]){
            return nil;
        }
        
        // 加载nib
        self = [arrayOfViews objectAtIndex:0];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

@end
