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
{
    BOOL isDelete;
}

@end

@implementation SHDownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [SHStatisticalData requestDmalog:@"下载"];
    if(iOS8){
        self.view.frame = CGRectMake(0, 64, 1024, 655);
    }else{
        self.view.frame = CGRectMake(0, 64, 1024, 648);
    }
    btnClearAll.layer.cornerRadius = 5;
    btnEdit.layer.cornerRadius = 5;
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
    if(app.cachesInfolist.count>0){
        mViewNoData.hidden = YES;
        [mCollection reloadData];
    }else{
        mViewNoData.hidden = NO;
    }
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    SHDownloadCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collection_download_cell" forIndexPath:indexPath];
//    NSDictionary * dic = [app.downinglist objectAtIndex:indexPath.row];
    NSDictionary * dic=[app.cachesInfolist objectAtIndex:indexPath.row];
    cell.detail = [dic mutableCopy];
    cell.isDelete = isDelete;
    cell.btnDelete.tag = indexPath.row;
    [cell.btnDelete addTarget:self action:@selector(btnDeleteOntouch:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return app.cachesInfolist.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = [app.cachesInfolist objectAtIndex:indexPath.row];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:[NSString stringWithFormat:@"%@.mp4",[dic objectForKey:@"path"]]]){
        SHIntent *intent = [[SHIntent alloc]init];
        intent.target = @"SHTVDetailViewController";
        [intent.args setValue:dic forKeyPath:@"detailInfo"];
        [intent.args setValue:[NSString stringWithFormat:@"%@.mp4",[dic objectForKey:@"path"]] forKey:@"urlPath"];
        intent.container = self.navController;
        [[UIApplication sharedApplication]open:intent];
    }
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

- (IBAction)btnEditOntouch:(id)sender {
    if (btnClearAll.hidden) {
        btnClearAll.hidden = NO;
        [btnEdit setTitle:@"完成" forState:UIControlStateNormal];
        isDelete = YES;
    }else{
        btnClearAll.hidden = YES;
        [btnEdit setTitle:@"编辑" forState:UIControlStateNormal];
        isDelete = NO;
    }
    [mCollection reloadData];
}

- (IBAction)btnClearAllOntouch:(id)sender {
    [app.cachesInfolist removeAllObjects];
     [SHFileManager deleteFile:SHFileManager.getTargetFloderPath];
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:app.cachesInfolist ];
    [[NSUserDefaults standardUserDefaults ] setValue:data forKey:DOWNLOAD_INFO_LIST];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [mCollection reloadData];
}

-(void) btnDeleteOntouch:(UIButton *)sender
{
    
    NSDictionary * dic = [app.cachesInfolist objectAtIndex:sender.tag];
    [app.cachesInfolist removeObjectAtIndex:sender.tag];
    [SHFileManager deleteFileOfPath:[dic objectForKey:@"path"]];
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:app.cachesInfolist ];
    [[NSUserDefaults standardUserDefaults ] setValue:data forKey:DOWNLOAD_INFO_LIST];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [mCollection reloadData];
}
@end
