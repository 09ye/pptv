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
@synthesize detail = _detail;

- (void)awakeFromNib
{
    [super awakeFromNib];
    [mCollectView registerClass:[SHHorizonalCollectionViewCell class] forCellWithReuseIdentifier:@"sh_horizaonal_collectview_cell"];
}
-(void) setDetail:(NSMutableDictionary *)detail_
{
    _detail = detail_;
    if (self.type == 0) {
        mList = [detail_ objectForKey:@"column_index"];
    }else if(self.type == 1){
         mList = [detail_ objectForKey:@"doc_index"];
    }
    [mCollectView reloadData];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    SHHorizonalCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"sh_horizaonal_collectview_cell" forIndexPath:indexPath];
    cell.tag = indexPath.row;
    
    if(indexPath.row == 0){
        
        cell.labTitle.hidden = YES;
        cell.labTitle2.hidden = YES;
        cell.labContent.hidden = YES;
        cell.labLogoName.hidden = NO;
        cell.labLogoContent.hidden = NO;
        cell.imgDeatil.image = [UIImage imageNamed:@""];
        if(self.type ==0){
            cell.labLogoName.text = @"综艺";
             cell.labLogoContent.text = [NSString stringWithFormat:@"共%d部",[[_detail objectForKey:@"column_count"]intValue]];
            cell.imgDeatil.backgroundColor = [UIColor colorWithRed:92/255.0 green:0/255.0 blue:195/255.0 alpha:1];
        }else if(self.type == 1){
            cell.labLogoName.text = @"纪录片";
            cell.labLogoContent.text = [NSString stringWithFormat:@"共%d部",[[_detail objectForKey:@"doc_count"]intValue]];
            cell.imgDeatil.backgroundColor = [UIColor colorWithRed:0/255.0 green:56/255.0 blue:195/255.0 alpha:1];
            
        }
        
    }else{
       
        NSDictionary * dic = [mList objectAtIndex:indexPath.row-1];
        cell.labLogoName.hidden = YES;
        cell.labLogoContent.hidden = YES;
        [cell.imgDeatil setUrl:[dic objectForKey:@"pic"]];
       
        if(self.type ==0){
            cell.labTitle.text = [dic objectForKey:@"title"];
            cell.labContent.text = [dic objectForKey:@"focus"];
            cell.labStatus.text = [dic objectForKey:@"status"];
            
             cell.labTitle.hidden = NO;
            cell.labTitle2.hidden = YES;
            cell.labContent.hidden = NO;
            
          
        }else if(self.type == 1){
            
            cell.labTitle2.text = [dic objectForKey:@"title"];
            cell.labTitle.hidden =YES;
            cell.labTitle2.hidden = NO;
            cell.labContent.hidden = YES;
            
            
        }
    }
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return mList.count+1;
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
    [intent.args setValue:[mList objectAtIndex:indexPath.row-1] forKey:@"detailInfo"];
    intent.container = self.navController;
    [[UIApplication sharedApplication] open:intent];
}

@end
