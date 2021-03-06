//
//  SHFeedbackViewController.m
//  PPTV
//
//  Created by yebaohua on 14/12/20.
//  Copyright (c) 2014年 yebaohua. All rights reserved.
//

#import "SHFeedbackViewController.h"

@interface SHFeedbackViewController ()

@end

@implementation SHFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    [SHStatisticalData requestDmalog:self.title];
    self.view.backgroundColor = [SHSkin.instance colorOfStyle:@"ColorBackGroundRightView"];
    mScrollview.layer.cornerRadius= 5;
    arrayType = [[NSMutableArray alloc]init];
    selectType = @"播放卡顿严重";
    mtxtCOntent.layer.cornerRadius = 5;
    mtxtCOntent.layer.borderWidth = 0.4f;
    mtxtCOntent.layer.borderColor = [[UIColor grayColor]CGColor ];
    mtxtCOntent.placeholder = @"请尽量详细地描述您的问题或建议，方便我们为您更快地处理。";
    mtxtCOntent.delegate = self;
    
    mtxtPhone.layer.cornerRadius = 5;
    mtxtPhone.layer.borderWidth = 0.4f;
    mtxtPhone.layer.borderColor = [[UIColor grayColor]CGColor ];
    mtxtPhone.placeholder = @"QQ/手机/邮箱";
     mtxtPhone.delegate = self;

    
    mtxtArea.layer.cornerRadius = 5;
    mtxtArea.layer.borderWidth = 0.4f;
    mtxtArea.layer.borderColor = [[UIColor grayColor]CGColor ];
    mtxtArea.placeholder = @"您当前所在的地区";
     mtxtArea.delegate = self;
    
    mtxtCompany.layer.cornerRadius = 5;
    mtxtCompany.layer.borderWidth = 0.4f;
    mtxtCompany.layer.borderColor = [[UIColor grayColor]CGColor ];
    mtxtCompany.placeholder = @"当前的网络运营商";
     mtxtCompany.delegate = self;
    
   

    mbtnSumbit.layer.masksToBounds = YES;
    mbtnSumbit.layer.cornerRadius = 5;
    
    arrayBtn = [[NSArray alloc]initWithObjects:mbtn1,mbtn2,mbtn3,mbtn4,mbtn5,mbtn6,mbtn7, nil];
    [self btnSelectReasonOntouch:mbtn1];
    [self requestType];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
    [mtxtCOntent becomeFirstResponder];
    
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [mtxtCOntent resignFirstResponder];
    [mtxtPhone resignFirstResponder];
    [mtxtArea resignFirstResponder];
    [mtxtCompany resignFirstResponder];
}
-(void)requestType
{
    SHPostTaskM * post = [[SHPostTaskM alloc]init];
    post.URL = URL_FOR(@"Pad/feedtype");
    post.delegate = self;
    [post start:^(SHTask *task) {
        arrayType = [[task result]mutableCopy];
    } taskWillTry:^(SHTask *task) {
        
    } taskDidFailed:^(SHTask *task) {
        
    }];
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    int y = 10;
    if (textView ==mtxtCOntent) {
        y = -150;
    }else if (textView ==mtxtPhone) {
        y = -240;
    }else if (textView ==mtxtArea) {
        y = -300;
    }else if (textView ==mtxtCompany) {
        y = -350;
    }
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         mScrollview.frame = CGRectMake(10, y, mScrollview.frame.size.width, mScrollview.frame.size.height);
                     }];
}

- (void)keyboardDidHidden:(NSNotification*)ns
{
    [UIView animateWithDuration:0.3
                     animations:^{
                         mScrollview.frame = CGRectMake(10, 10, mScrollview.frame.size.width, mScrollview.frame.size.height);
                     }];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    if ([text isEqualToString:@"\n"]) {
        if (textView ==mtxtCOntent) {
            [mtxtPhone becomeFirstResponder];
        }else if (textView ==mtxtPhone) {
            [mtxtArea becomeFirstResponder];
        }else if (textView ==mtxtArea) {
            [mtxtCompany becomeFirstResponder];
        }else if (textView ==mtxtCompany) {
            [textView resignFirstResponder];
        }
        return NO;
    }
    
    return YES;
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

- (IBAction)btnSelectReasonOntouch:(UIButton *)sender {
    
    for (UIButton * button  in arrayBtn) {
        if (sender == button) {
            [button setImage:[UIImage imageNamed:@"btn_collect_list_select"] forState:UIControlStateNormal];
            if (sender.tag<arrayType.count) {
                selectType = [arrayType objectAtIndex:sender.tag];
            }
            
        }else{
            [button setImage:[UIImage imageNamed:@"btn_collect_list_normal"] forState:UIControlStateNormal];
        }
    }
}

- (IBAction)btnSumbitOntouch:(id)sender {
    if ([mtxtCOntent.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length <=0 ||  [mtxtCOntent.text isEqualToString:mtxtCOntent.placeholder]) {
        [self showAlertDialog:@"请填写您的宝贵意见"];
        return;
    }
    if ([mtxtPhone.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length <= 0 ||  [mtxtPhone.text isEqualToString:mtxtPhone.placeholder]) {
        [self showAlertDialog:@"请填写您联系方式"];
        return;
    }
    
    if ([mtxtArea.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length <= 0 ||  [mtxtPhone.text isEqualToString:mtxtArea.placeholder]) {
        [self showAlertDialog:@"请填写您的所在地区"];
        return;
    }
    if ([mtxtCompany.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length <= 0 ||  [mtxtCompany.text isEqualToString:mtxtCompany.placeholder]) {
        [self showAlertDialog:@"请填写您的所用网络运营商"];
        return;
    }
    [self showWaitDialog:@"正在提交" state:@"请稍等"];
    SHPostTaskM * postKeyWord = [[SHPostTaskM alloc]init];
    postKeyWord.URL = URL_FOR(@"Pad/feedback");
    [postKeyWord.postArgs setValue:selectType forKey:@"type"];
    [postKeyWord.postArgs setValue:mtxtPhone.text forKey:@"contact"];
    [postKeyWord.postArgs setValue:mtxtArea.text forKey:@"area"];
    [postKeyWord.postArgs setValue:mtxtCompany.text forKey:@"idc"];
    [postKeyWord.postArgs setValue:mtxtCOntent.text forKey:@"content"];
    [postKeyWord.postArgs setValue:@"" forKey:@"ip"];
    postKeyWord.delegate = self;
    [postKeyWord start:^(SHTask *t) {
        
        [self dismissWaitDialog];
        [t.respinfo show];
        [self.navigationController popViewControllerAnimated:YES];
        
    } taskWillTry:^(SHTask *t) {
        
    } taskDidFailed:^(SHTask *t) {
        [self dismissWaitDialog];
        [t.respinfo show];
        
    }];
}
@end
