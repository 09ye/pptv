//
//  SHTVDrameViewController.h
//  PPTV
//
//  Created by yebaohua on 14/12/1.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"
@class SHTVDrameViewController;
@protocol SHTVDrameViewControllerDelegate <NSObject>

-(void) drameDidSelect:(SHTVDrameViewController*)controll info:(NSDictionary*)detail ;
@end
@interface SHTVDrameViewController : SHTableViewController<SHTaskDelegate>
{
    int selctID;
}
@property (nonatomic,assign) id <SHTVDrameViewControllerDelegate> delegate;

-(void) refresh:(NSInteger)videoID;
@end
