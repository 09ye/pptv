//
//  SHBillListViewController.h
//  PPTV
//
//  Created by yebaohua on 14/12/15.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"

@interface SHBillListViewController : SHTableViewController<SHTaskDelegate>
{

    __weak IBOutlet UILabel *mlabNodata;
}

@property (nonatomic,strong) NSMutableArray * list;
@property (nonatomic,assign) int tag;

-(void) refreBill:(NSString *)date detail:(NSDictionary*)dic;
@end
