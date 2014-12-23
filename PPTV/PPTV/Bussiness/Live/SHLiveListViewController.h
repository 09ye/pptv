//
//  SHLiveListViewController.h
//  PPTV
//
//  Created by yebaohua on 14/12/1.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"
@class SHLiveListViewController;
@protocol SHLiveListViewControllerDelegate <NSObject>

-(void) liveListDidSelect:(SHLiveListViewController*)controll info:(NSDictionary*)detail ;
@end
@interface SHLiveListViewController : SHTableViewController<SHTaskDelegate>
{
    NSArray * mListCategory;
    __weak IBOutlet UIScrollView *mScrollviewCate;
    
    int pagenum;
    NSDictionary * mResult;
    int cid;
    
    int selctID;
}
@property (nonatomic,assign) id <SHLiveListViewControllerDelegate> delegate;
@end
