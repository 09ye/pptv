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
    cell.tag = indexPath.row;
    cell.imgDeatil.image = [UIImage imageNamed:[self.list objectAtIndex:indexPath.row
                                        ]];
//    cell.labTitle.text = @"aaa";
//    cell.labContent.text = @"ssss";
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
    mShowViewControll = [[SHShowVideoViewController alloc] initWithNibName:@"SHShowVideoViewController" bundle:nil];;
    mShowViewControll.delegate = self;
    mShowViewControll.videoTitle = @"xxx";
    mShowViewControll.videoUrl = @"http://hot.vrs.sohu.com/ipad1407291_4596271359934_4618512.m3u8";
     AppDelegate* app=(AppDelegate*)[UIApplication sharedApplication].delegate;
    
//    [mShowViewControll showIn:self];
//    [self addSubview:mShowViewControll.view]
//
//    //    showViewControll.view.frame = CGRectMake(20, 20, 1000, 600);
//    
//    [self.navController pushViewController:mShowViewControll animated:YES];
    
    SHIntent * intent = [[SHIntent alloc ]init];
    intent.target = @"SHTVDetailViewController";
    intent.container = self.navController;
    [[UIApplication sharedApplication] open:intent];
}


@end
