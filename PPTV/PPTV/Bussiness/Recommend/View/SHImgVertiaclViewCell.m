//
//  SHImgVertiaclViewCell.m
//  PPTV
//
//  Created by yebaohua on 14/11/17.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHImgVertiaclViewCell.h"
#import "SHVerticalCollectionViewCell.h"


@implementation SHImgVertiaclViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [mCollectView registerClass:[SHVerticalCollectionViewCell class] forCellWithReuseIdentifier:@"sh_vertical_collectview_cell"];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    SHVerticalCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"sh_vertical_collectview_cell" forIndexPath:indexPath];
    cell.tag = indexPath.row;
    cell.labTitle.text = @"aaa";
    cell.labContent.text = @"ssss";
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

@end
