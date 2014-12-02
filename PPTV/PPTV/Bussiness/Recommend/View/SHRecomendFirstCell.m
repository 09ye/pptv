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
    self.imgLive1.image = [UIImage imageNamed:@"ic_video_default"];
    self.imgLive2.image = [UIImage imageNamed:@"ic_video_default"];
    self.imgLiveSynch.image = [UIImage imageNamed:@"ic_home_title_default1"];
    self.imgLiveSynch1.image = [UIImage imageNamed:@"ic_home_content_default1"];
    self.imgLiveSynch2.image = [UIImage imageNamed:@"ic_home_content_default1"];
    self.imgLiveSynch3.image = [UIImage imageNamed:@"ic_home_content_default1"];
    self.imgLiveSynch4.image = [UIImage imageNamed:@"ic_home_content_default1"];
    
    [mCollectView reloadData];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    SHChannelCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"sh_channel_collectview_cell" forIndexPath:indexPath];
    cell.tag = indexPath.row;
    //    cell.labTitle.text = @"aaa";
    //    cell.labContent.text = @"ssss";
    
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

    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    SHIntent * intent = [[SHIntent alloc ]init];
    intent.target = @"SHLiveViewController";
    
    [intent.args setValue:[NSNumber numberWithBool:YES] forKey:@"readOnly"];
    intent.container = self.navController;
    [[UIApplication sharedApplication] open:intent];
}
- (IBAction)btnLiveOntouch:(UIButton *)sender {
    SHIntent * intent = [[SHIntent alloc ]init];
    intent.target = @"SHLiveViewController";
    
    [intent.args setValue:[NSNumber numberWithBool:YES] forKey:@"readOnly"];
    intent.container = self.navController;
    [[UIApplication sharedApplication] open:intent];
}

- (IBAction)btnLiveSynchOntouch:(UIButton *)sender {
    switch (sender.tag) {
        case 0:
            
            break;
        case 1:
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
    SHIntent * intent = [[SHIntent alloc ]init];
    intent.target = @"SHTVDetailViewController";
    [intent.args setValue:[NSNumber numberWithBool:YES] forKey:@"readOnly"];
    intent.container = self.navController;
    [[UIApplication sharedApplication] open:intent];
}
@end
