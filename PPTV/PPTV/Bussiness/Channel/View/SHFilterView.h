//
//  SHFilterView.h
//  crowdfunding-arcturus
//
//  Created by sheely.paean.Nightshade on 14-4-28.
//  Copyright (c) 2014年 WSheely. All rights reserved.
//

#import "SHView.h"

@interface SHFilterView : SHView

{
    BOOL mIsShow;
}

@property (weak, nonatomic) IBOutlet UIView *backGround;
@property (weak, nonatomic) IBOutlet UIImageView *imgArrow;

- (IBAction)btnCloseOnTouch:(id)sender;

- (void)showIn:(UIView *) view :(CGRect) rect;

- (void)close;
@end
