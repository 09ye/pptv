//
//  SHFilterView.m
//  crowdfunding-arcturus
//
//  Created by sheely.paean.Nightshade on 14-4-28.
//  Copyright (c) 2014年 WSheely. All rights reserved.
//

#import "SHFilterView.h"

@implementation SHFilterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
        [button addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor =[UIColor clearColor];
        button.tag = 10001;
        [self addSubview:button];
        UIView * line = [[UIView alloc]initWithFrame:CGRectMake(30, 0, 964, 1)];
        line.backgroundColor = [SHSkin.instance colorOfStyle:@"ColorBaseBackGround"];
        line.tag = 10002;
        [self addSubview:line];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)loadSkin
{
    self.backgroundColor = [UIColor clearColor];
    self.backGround.backgroundColor = [UIColor whiteColor];
}

- (void)showIn:(UIView *)view rect:(CGRect)rect 
{
    if(!mIsShow){
        mIsShow = YES;
        self.imgArrow.image = [UIImage imageNamed:@"ic_arrow_up"];
        self.frame = rect;
        self.backGround.frame = CGRectMake( self.backGround.frame.origin.x, - self.backGround.frame.size.height, self.backGround.frame.size.width, self.backGround.frame.size.height);
        [view addSubview:self];
        self.alpha = 0;
        [UIView animateWithDuration:0.5 animations:^{
            self.imgArrow.image = [UIImage imageNamed:@"ic_arrow_down"];
            self.alpha = 1;
            self.backGround.frame = CGRectMake( self.backGround.frame.origin.x, 0, self.backGround.frame.size.width, self.backGround.frame.size.height);
            
        } completion:^(BOOL finished) {
            
        }];
    }else{
        [self close];
    }
}

- (void)close
{
    if(mIsShow){
        mIsShow = NO;
        [UIView animateWithDuration:0.5 animations:^{
            self.backGround.frame = CGRectMake( self.backGround.frame.origin.x, -self.backGround.frame.size.height, self.backGround.frame.size.width, self.backGround.frame.size.height);
            self.alpha = 0;
            self.imgArrow.image = [UIImage imageNamed:@"ic_arrow_up"];
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
        
    }
}

- (IBAction)btnCloseOnTouch:(id)sender
{
    [self close];
}
@end
