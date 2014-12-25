//
//  SHDownloadViewController.m
//  PPTV
//
//  Created by yebaohua on 14/12/23.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHDownloadViewController.h"
#import "ASIHTTPRequest.h"

@interface SHDownloadViewController ()

@end

@implementation SHDownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    app  = (AppDelegate*)[UIApplication sharedApplication].delegate;
    NSString* path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] ;
    
    NSFileManager* fileManager = [[NSFileManager alloc ]init];
    
    NSDictionary *fileSysAttributes = [fileManager attributesOfFileSystemForPath:path error:nil];
    
    NSNumber *freeSpace = [fileSysAttributes objectForKey:NSFileSystemFreeSize];
    
    NSNumber *totalSpace = [fileSysAttributes objectForKey:NSFileSystemSize];
    
    NSString  * str= [NSString stringWithFormat:@"已占用%0.1fG/剩余%0.1fG",([totalSpace longLongValue] - [freeSpace longLongValue])/1024.0/1024.0/1024.0,[freeSpace longLongValue]/1024.0/1024.0/1024.0];
    mlabTotal.text = [NSString stringWithFormat:@"总空间%0.1fG",[totalSpace longLongValue]/1024.0/1024.0/1024.0];
    
    mlabDownSize.text = [NSString stringWithFormat:@"已缓存:%0.1fG",[SHFileManager currentCachesFileSize]];
    mlabFree.text = [NSString stringWithFormat:@"可用空间:%0.1fG",[freeSpace longLongValue]/1024.0/1024.0/1024.0];
    NSLog(@"--------%@",str);
    
    [mCollection registerClass:[SHDownloadCollectionViewCell class] forCellWithReuseIdentifier:@"collection_download_cell"];
   
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    if(app.downinglist.count>0){
        mViewNoData.hidden = YES;
    }else{
        mViewNoData.hidden = NO;
    }
     [mCollection reloadData];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    SHDownloadCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collection_download_cell" forIndexPath:indexPath];
//    NSDictionary * dic = [app.downinglist objectAtIndex:indexPath.row];
    ASIHTTPRequest *theRequest=[app.downinglist objectAtIndex:indexPath.row];
    FileModel *fileInfo=[theRequest.userInfo objectForKey:@"File"];
    theRequest.downloadProgressDelegate = self;
//    [cell.imgDeatil setUrl:[dic objectForKey:@"pic"]];
    cell.labTitle.text = fileInfo.fileName;
//    cell.labContent.text = [dic objectForKey:@"focus"];
//    cell.labStatus.text = [dic objectForKey:@"status"];
    
    
    
    
    return cell;
}
-(void)setProgress:(float)newProgress
{
    NSLog(@"setProgress-%f",newProgress);
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return app.downinglist.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    SHIntent * intent = [[SHIntent alloc ]init];
    intent.target = @"SHTVDetailViewController";
//    [intent.args setValue:[self. objectAtIndex:indexPath.row] forKey:@"detailInfo"];
    intent.container = self.navController;
    [[UIApplication sharedApplication] open:intent];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
