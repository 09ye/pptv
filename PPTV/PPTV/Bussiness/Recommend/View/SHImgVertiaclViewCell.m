//
//  SHImgVertiaclViewCell.m
//  PPTV
//
//  Created by yebaohua on 14/11/17.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHImgVertiaclViewCell.h"
#import "SHVerticalCollectionViewCell.h"
#import "SHShowVideoViewController.h"


@implementation SHImgVertiaclViewCell
@synthesize list = _list;

- (void)awakeFromNib
{
    [super awakeFromNib];
    [mCollectView registerClass:[SHVerticalCollectionViewCell class] forCellWithReuseIdentifier:@"sh_vertical_collectview_cell"];
}
-(void) setList:(NSMutableArray *)list_
{
    _list = [list_ mutableCopy];
    [mCollectView reloadData];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    SHVerticalCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"sh_vertical_collectview_cell" forIndexPath:indexPath];
    NSDictionary * dic = [self.list objectAtIndex:indexPath.row];
    
    [cell.imgDeatil setUrl:[dic objectForKey:@"pic"]];
    cell.labTitle.text = [dic objectForKey:@"title"];
    cell.labContent.text = [dic objectForKey:@"focus"];
    cell.labStatus.text = [dic objectForKey:@"status"];
    
    
    
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.list.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    SHIntent * intent = [[SHIntent alloc ]init];
    intent.target = @"SHTVDetailViewController";
    [intent.args setValue:[self.list objectAtIndex:indexPath.row] forKey:@"detailInfo"];
    intent.container = self.navController;
    [[UIApplication sharedApplication] open:intent];
}


@end
