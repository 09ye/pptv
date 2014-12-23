//
//  SHFeedbackViewController.h
//  PPTV
//
//  Created by yebaohua on 14/12/20.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHTableViewController.h"
#import  "CPTextViewPlaceholder.h"

@interface SHFeedbackViewController : SHTableViewController<SHTaskDelegate,UITextViewDelegate>
{
     __weak IBOutlet UIScrollView *mScrollview;
    __weak IBOutlet UIButton *mbtn1;
    __weak IBOutlet UIButton *mbtn2;
    __weak IBOutlet UIButton *mbtn3;
    __weak IBOutlet UIButton *mbtn4;
    __weak IBOutlet UIButton *mbtn5;
    __weak IBOutlet UIButton *mbtn6;
    __weak IBOutlet UIButton *mbtn7;
    __weak IBOutlet UIButton *mbtnSumbit;
    __weak IBOutlet CPTextViewPlaceholder *mtxtCOntent;
    __weak IBOutlet CPTextViewPlaceholder *mtxtPhone;
    __weak IBOutlet CPTextViewPlaceholder *mtxtArea;
    __weak IBOutlet CPTextViewPlaceholder *mtxtCompany;
    
    NSArray *arrayBtn;
}
- (IBAction)btnSelectReasonOntouch:(UIButton *)sender;
- (IBAction)btnSumbitOntouch:(id)sender;

@end
