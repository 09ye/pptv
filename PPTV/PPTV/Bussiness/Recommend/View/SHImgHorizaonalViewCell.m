//
//  SHImgHorizaonalViewCell.m
//  PPTV
//
//  Created by yebaohua on 14/11/18.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHImgHorizaonalViewCell.h"
#import "SHHorizonalCollectionViewCell.h"

@implementation SHImgHorizaonalViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [mCollectView registerClass:[SHHorizonalCollectionViewCell class] forCellWithReuseIdentifier:@"sh_horizaonal_collectview_cell"];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    SHHorizonalCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"sh_horizaonal_collectview_cell" forIndexPath:indexPath];
    cell.tag = indexPath.row;
    //    cell.labTitle.text = @"aaa";
    //    cell.labContent.text = @"ssss";
    if(indexPath.row == 0){
        
        cell.labTitle.hidden = YES;
        cell.labTitle2.hidden = YES;
        cell.labContent.hidden = YES;
        cell.labLogoName.hidden = NO;
        cell.labLogoContent.hidden = NO;
        cell.imgDeatil.image = [UIImage imageNamed:@""];
        if(self.type ==0){
            cell.labLogoName.text = @"综艺";
            cell.labLogoContent.text = @"共1234部";
            cell.imgDeatil.backgroundColor = [UIColor colorWithRed:96/255.0 green:0/255.0 blue:192/255.0 alpha:1];
        }else if(self.type == 1){
            cell.labLogoName.text = @"纪录片";
            cell.labLogoContent.text = @"共1234部";
            cell.imgDeatil.backgroundColor = [UIColor colorWithRed:31/255.0 green:53/255.0 blue:192/255.0 alpha:1];
            
        }
        
    }else{
       
      
        cell.labLogoName.hidden = YES;
        cell.labLogoContent.hidden = YES;
        cell.imgDeatil.image = [UIImage imageNamed:@"ic_home_content_default3"];
        if(self.type ==0){
             cell.labTitle.hidden = NO;
            cell.labTitle2.hidden = YES;
            cell.labContent.hidden = NO;
            
          
        }else if(self.type == 1){
            cell.labTitle.hidden =YES;
            cell.labTitle2.hidden = NO;
            cell.labContent.hidden = YES;
            
            
        }
    }
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
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return;
    }
    
    SHIntent * intent = [[SHIntent alloc ]init];
    intent.target = @"SHTVDetailViewController";
    
    [intent.args setValue:[NSNumber numberWithBool:YES] forKey:@"readOnly"];
    intent.container = self.navController;
    [[UIApplication sharedApplication] open:intent];
}

@end
