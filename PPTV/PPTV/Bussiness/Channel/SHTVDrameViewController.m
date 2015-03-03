//
//  SHTVDrameViewController.m
//  PPTV
//
//  Created by yebaohua on 14/12/1.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTVDrameViewController.h"
#import "SHDrameMoviceViewCell.h"

@interface SHTVDrameViewController ()

@end

@implementation SHTVDrameViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor clearColor];//[SHSkin.instance colorOfStyle:@"ColorBase"]
    
  
}


-(void) refresh:(NSString *)videoID
{
    selctID = videoID;
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"Pad/iteminfo");
    [post.postArgs setValue:videoID forKey:@"id"];
    post.delegate = self;
    [post start:^(SHTask *task) {
        mResult = [[task result]mutableCopy];
        
        mList = [mResult objectForKey:@"list"];
       
        
        mListCategory = [mResult objectForKey:@"group"];
        mCurrentGroup = @"";
        if (mListCategory.count>0) {
            mCurrentGroup = [mListCategory objectAtIndex:0];
            CGRect rect = self.tableView.frame;
            rect.origin.y = 44;
            rect.size.height=758-44-60;
            self.tableView.frame = rect;
            [self createGroupView];
        }
        
        [self.tableView reloadData];
       
    } taskWillTry:^(SHTask *task) {
        
    } taskDidFailed:^(SHTask *task) {
        [task.respinfo show];
    }];
}
-(void) viewWillAppear:(BOOL)animated
{
//    [super viewWillAppear:YES];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = [mList objectAtIndex:indexPath.row];
    if ([mCurrentGroup isEqualToString:@""] || [[dic objectForKey:@"group"] isEqualToString:mCurrentGroup]) {
        return 80;
    }
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return mList.count;
}
-(SHTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SHDrameMoviceViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"table_drame_movice_cell"];
    if(cell == nil){
        cell = (SHDrameMoviceViewCell*)[[[NSBundle mainBundle]loadNibNamed:@"SHDrameMoviceViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    NSDictionary * dic = [mList objectAtIndex:indexPath.row];
    [cell.imgDetail setUrl:[dic objectForKey:@"pic"]];
    
    cell.labContent.text = [dic objectForKey:@"focus"];
    cell.labTitle.text = [dic objectForKey:@"title"];
    if(![dic objectForKey:@"focus"] || [[dic objectForKey:@"focus"] isEqualToString:@""]){
        cell.labTitle.numberOfLines = 3;
        [cell.labTitle sizeToFit];
    }
    cell.backgroundColor = [UIColor clearColor];
    if ([NSString stringWithFormat:@"%@",[dic objectForKey:@"id"]] == selctID) {

            [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
    if ([mCurrentGroup isEqualToString:@""] || [[dic objectForKey:@"group"] isEqualToString:mCurrentGroup]) {
        cell.hidden  = NO;
    }else{
        cell.hidden =  YES;
    }
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dic = [mList objectAtIndex:indexPath.row];
    
    if (self.isDownload) {
   
        AppDelegate* app=(AppDelegate*)[UIApplication sharedApplication].delegate;
        [app beginRequest:[[dic objectForKey:@"id"]intValue] hdType:hdType isCollection:YES isBeginDown:YES];
    }else{
        if (self.delegate && [self.delegate respondsToSelector:@selector(drameDidSelect:info:)]) {
            [self.delegate drameDidSelect:self info:dic];
        }
    }
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) setIsDownload:(BOOL)isDownload_
{
    _isDownload = isDownload_;
    if (isDownload_) {
        
        [UIView animateWithDuration:0.4 animations:^{
            
            CGRect rect = mViewContain.frame;
            rect.origin.y = 34;
            rect.size.height = 768-34-50;
            mViewContain.frame = rect;
            if (mListCategory.count>0) {
                CGRect rect = self.tableView.frame;
                rect.origin.y = 44;
                rect.size.height=758-34-50-44-60;
                self.tableView.frame = rect;
            }else{
                CGRect rect = self.tableView.frame;
                rect.origin.y = 0;
                rect.size.height=758-34-50-60;
                self.tableView.frame = rect;
            }
            [self.tableView reloadData];
            
        } completion:^(BOOL finished) {
            mViewDownload.hidden = NO;
            mlabTitleDown.hidden = NO;
            
        }];
        
    }else{
        
        [UIView animateWithDuration:0.4 animations:^{
            
            mViewDownload.hidden = YES;
            mlabTitleDown.hidden = YES;
            CGRect rect = mViewContain.frame;
            rect.size.height= 768;
            rect.origin.y = 0;
            mViewContain.frame = rect;
            if (mListCategory.count>0) {
                CGRect rect = self.tableView.frame;
                rect.origin.y = 44;
                rect.size.height=758-44-60;
                self.tableView.frame = rect;
            }else{
                CGRect rect = self.tableView.frame;
                rect.origin.y = 0;
                rect.size.height=758;
                self.tableView.frame = rect;
            }
            [self.tableView reloadData];
            
            
        } completion:^(BOOL finished) {
            

        }];
    }
}
-(void) createGroupView
{
    arrayBtnCate = [[NSMutableArray alloc]init];
    CGRect  lastRect = CGRectZero;
    for (int i=0; i<mListCategory.count; i++) {
//        NSDictionary * dic = ;
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(lastRect.origin.x+lastRect.size.width+20, 5, 50, 34)];
        [button setTitle:[mListCategory objectAtIndex:i] forState:UIControlStateNormal];
        button.tag = i;
        [button addTarget:self action:@selector(btnCategory:) forControlEvents:UIControlEventTouchUpInside];
        [button sizeToFit];
        lastRect = button.frame;
        [arrayBtnCate addObject:button];
        [mScrollviewCate addSubview:button];
    }
    [[arrayBtnCate objectAtIndex:0] setTitleColor:[SHSkin.instance colorOfStyle:@"ColorTextOrg"] forState:UIControlStateNormal];
    mScrollviewCate.contentSize = CGSizeMake(lastRect.origin.x+lastRect.size.width+20.f, 44);

}
-(void) btnCategory:(UIButton *)sender
{
    
    mCurrentGroup  =[mListCategory objectAtIndex:sender.tag];
    [self.tableView reloadData];

    
    for (UIButton * button in arrayBtnCate) {
        if (button == sender) {
            [button setTitleColor:[SHSkin.instance colorOfStyle:@"ColorTextOrg"] forState:UIControlStateNormal];
        }else{
            
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
}

- (IBAction)btnDownModeOntouch:(UIButton *)sender {
    switch (sender.tag) {
        case 0:
            [mbtn1 setTitleColor:[SHSkin.instance colorOfStyle:@"ColorTextOrg"] forState:UIControlStateNormal];
            [mbtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [mbtn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [mbtnMode setTitle:@"流畅" forState:UIControlStateNormal];

            break;
        case 1:
            [mbtn2 setTitleColor:[SHSkin.instance colorOfStyle:@"ColorTextOrg"] forState:UIControlStateNormal];
            [mbtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [mbtn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [mbtnMode setTitle:@"高清" forState:UIControlStateNormal];

            break;
        case 2:
            [mbtn3 setTitleColor:[SHSkin.instance colorOfStyle:@"ColorTextOrg"] forState:UIControlStateNormal];
            [mbtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [mbtn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [mbtnMode setTitle:@"超清" forState:UIControlStateNormal];

            break;
            
        default:
            break;
    }
    hdType = sender.tag;
    mViewDownSelect.hidden = YES;
}

- (IBAction)btnShowModeOntouch:(UIButton *)sender {
    if(mViewDownSelect.hidden){
        [UIView animateWithDuration:0.4 animations:^{
            mViewDownSelect.hidden = NO;
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (IBAction)btnModeCloseOntouch:(id)sender {
    mViewDownSelect.hidden = YES;
}
-(BOOL)showNextVideo{
    NSIndexPath *indexPath =[self.tableView indexPathForSelectedRow];
    if (indexPath && indexPath.row+1<mList.count) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(drameDidSelect:info:)]) {
            [self.delegate drameDidSelect:self info:[mList objectAtIndex:indexPath.row+1]];
            return YES;
        }
        
    }else if(!indexPath &&mList.count>0){
        if (self.delegate && [self.delegate respondsToSelector:@selector(drameDidSelect:info:)]) {
            [self.delegate drameDidSelect:self info:[mList objectAtIndex:0]];
            return YES;
        }
    }
    return NO;
}

@end
