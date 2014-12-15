//
//  SHRecomendFirstCell.m
//  PPTV
//
//  Created by yebaohua on 14/11/17.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHRecomendFirstCell.h"

@implementation SHRecomendFirstCell
@synthesize detail = _detail;
@synthesize listLive = _listLive;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void) awakeFromNib
{
    [super awakeFromNib];
    [mCollectView registerClass:[SHChannelCollectionViewCell class] forCellWithReuseIdentifier:@"sh_channel_collectview_cell"];
    self.imgLiveSynch1.layer.borderColor = [SHSkin.instance colorOfStyle:@"ColorTextRed"].CGColor;
    self.imgLiveSynch1.layer.borderWidth = 1;
}
-(void) setDetail:(NSMutableDictionary *)detail_
{
    _detail= detail_;
    NSArray * arry =[_detail objectForKey:@"live_area"];// 热门直播
    if (arry.count>1) {
        NSDictionary * dic1 =[arry objectAtIndex:0];
        self.labLive1.text =  [dic1 objectForKey:@"title"];
        [self.imgLive1 setUrl:[dic1 objectForKey:@"pic"]];
        self.imgLive2.layer.borderColor = [[UIColor blackColor]CGColor];
        self.imgLive2.layer.borderWidth = 1.0;
        NSDictionary * dic2 =[arry objectAtIndex:1];
        [self.imgLive2 setUrl:[dic2 objectForKey:@"pic"]];
        self.labLive2.text =  [dic2 objectForKey:@"title"];
        self.imgLive2.layer.borderColor = [[UIColor blackColor]CGColor];
        self.imgLive2.layer.borderWidth = 1.0;
    }
    NSArray * arry2 =[_detail objectForKey:@"series_area"];// 同步剧场
    for(int j=0;j<arry2.count;j++){
        NSDictionary * dic =[arry2 objectAtIndex:j];
        if (j== 0) {
            mDicSelectSysn= dic;
            [self.imgLiveSynch setUrl:[dic objectForKey:@"pic"]];
            [self.imgLiveSynch1 setUrl:[dic objectForKey:@"pic"]];
        }else if(j== 1){
            [self.imgLiveSynch2 setUrl:[dic objectForKey:@"pic"]];
        }else if(j== 2){
            [self.imgLiveSynch3 setUrl:[dic objectForKey:@"pic"]];
        }else if(j== 3){
            [self.imgLiveSynch4 setUrl:[dic objectForKey:@"pic"]];
        }
    }
  
    
   
    
   
}
-(void) setListLive:(NSMutableArray *)listLive_
{
    _listLive = listLive_;
    [mCollectView reloadData];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    SHChannelCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"sh_channel_collectview_cell" forIndexPath:indexPath];
    cell.tag = indexPath.row;
    NSDictionary * dic = [_listLive objectAtIndex:indexPath.row];
    [cell.imgLogo setUrl:[dic objectForKey:@"pic"]];
    cell.labName.text = [dic objectForKey:@"title"];
    cell.labContent.text = [dic objectForKey:@"focus"];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _listLive.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    SHIntent * intent = [[SHIntent alloc ]init];
    intent.target = @"SHLiveViewController";
    [intent.args setValue:[_listLive objectAtIndex:indexPath.row] forKey:@"detailInfo"];
    intent.container = self.navController;
    [[UIApplication sharedApplication] open:intent];
}
- (IBAction)btnLiveOntouch:(UIButton *)sender {
    SHIntent * intent = [[SHIntent alloc ]init];
    intent.target = @"SHLiveViewController";
    [intent.args setValue:[[_detail objectForKey:@"live_area"]objectAtIndex:sender.tag] forKey:@"detailInfo"];
    intent.container = self.navController;
    [[UIApplication sharedApplication] open:intent];
}

- (IBAction)btnLiveSynchOntouch:(UIButton *)sender {
    if ([[_detail objectForKey:@"series_area"] count]<3) {
        return;
    }
    if (sender.tag>0) {
        mDicSelectSysn= [[_detail objectForKey:@"series_area"]objectAtIndex:sender.tag-1];
    }
    
    switch (sender.tag) {
        case 0:
        {
            SHIntent * intent = [[SHIntent alloc ]init];
            intent.target = @"SHLiveViewController";
            [intent.args setValue:mDicSelectSysn forKey:@"detailInfo"];
            intent.container = self.navController;
            [[UIApplication sharedApplication] open:intent];
        }
            break;
        case 1:
             [self.imgLiveSynch setUrl:[[[_detail objectForKey:@"series_area"]objectAtIndex:0]objectForKey:@"pic"]];
            self.labLiveSynch.text = [[[_detail objectForKey:@"series_area"]objectAtIndex:0]objectForKey:@"title"];

            self.imgLiveSynch1.layer.borderColor = [SHSkin.instance colorOfStyle:@"ColorTextRed"].CGColor;
            self.imgLiveSynch1.layer.borderWidth = 1;
            self.imgLiveSynch2.layer.borderColor = [UIColor clearColor].CGColor;
            self.imgLiveSynch2.layer.borderWidth = 1;
            self.imgLiveSynch3.layer.borderColor = [UIColor clearColor].CGColor;
            self.imgLiveSynch3.layer.borderWidth = 1;
            self.imgLiveSynch4.layer.borderColor = [UIColor clearColor].CGColor;
            self.imgLiveSynch4.layer.borderWidth = 1;
            break;
        case 2:
            [self.imgLiveSynch setUrl:[[[_detail objectForKey:@"series_area"]objectAtIndex:1]objectForKey:@"pic"]];
            self.labLiveSynch.text = [[[_detail objectForKey:@"series_area"]objectAtIndex:1]objectForKey:@"title"];
            
            self.imgLiveSynch1.layer.borderColor = [UIColor clearColor].CGColor;
            self.imgLiveSynch1.layer.borderWidth = 1;
            self.imgLiveSynch2.layer.borderColor = [SHSkin.instance colorOfStyle:@"ColorTextRed"].CGColor;
            self.imgLiveSynch2.layer.borderWidth = 1;
            self.imgLiveSynch3.layer.borderColor = [UIColor clearColor].CGColor;
            self.imgLiveSynch3.layer.borderWidth = 1;
            self.imgLiveSynch4.layer.borderColor = [UIColor clearColor].CGColor;
            self.imgLiveSynch4.layer.borderWidth = 1;
            break;
        case 3:
             [self.imgLiveSynch setUrl:[[[_detail objectForKey:@"series_area"]objectAtIndex:2]objectForKey:@"pic"]];
            self.labLiveSynch.text = [[[_detail objectForKey:@"series_area"]objectAtIndex:2]objectForKey:@"title"];
            self.imgLiveSynch1.layer.borderColor = [UIColor clearColor].CGColor;
            self.imgLiveSynch1.layer.borderWidth = 1;
            self.imgLiveSynch2.layer.borderColor = [UIColor clearColor].CGColor;
            self.imgLiveSynch2.layer.borderWidth = 1;
            self.imgLiveSynch3.layer.borderColor = [SHSkin.instance colorOfStyle:@"ColorTextRed"].CGColor;
            self.imgLiveSynch3.layer.borderWidth = 1;
            self.imgLiveSynch4.layer.borderColor = [UIColor clearColor].CGColor;
            self.imgLiveSynch4.layer.borderWidth = 1;
            break;
        case 4:
             [self.imgLiveSynch setUrl:[[[_detail objectForKey:@"series_area"]objectAtIndex:3]objectForKey:@"pic"]];
            self.labLiveSynch.text = [[[_detail objectForKey:@"series_area"]objectAtIndex:3]objectForKey:@"title"];
            self.imgLiveSynch1.layer.borderColor = [UIColor clearColor].CGColor;
            self.imgLiveSynch1.layer.borderWidth = 1;
            self.imgLiveSynch2.layer.borderColor = [UIColor clearColor].CGColor;
            self.imgLiveSynch2.layer.borderWidth = 1;
            self.imgLiveSynch3.layer.borderColor = [UIColor clearColor].CGColor;
            self.imgLiveSynch3.layer.borderWidth = 1;
            self.imgLiveSynch4.layer.borderColor = [SHSkin.instance colorOfStyle:@"ColorTextRed"].CGColor;
            self.imgLiveSynch4.layer.borderWidth = 1;
            break;
            
        default:
            break;
    }
  
}
@end
