//
//  RadioGroup.h
//
//  Created by 凌洛寒 on 14-5-14.
//  Copyright (c) 2014年 凌洛寒. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RadioGroup;
@class RadioBox;
@protocol RadioGroupDelegate <NSObject>

-(void) radioGroupDidSelect:(RadioGroup*)radioGroup radioBox:(RadioBox*)radioBox select:(BOOL) isSelect;

@end
@interface RadioGroup : UIScrollView

@property (nonatomic, strong) NSString *selectText;
@property (nonatomic) NSInteger selectValue;

@property (nonatomic, strong) UIColor *onTintColor;
@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic, strong) UIColor *boxColor;
@property (nonatomic, strong) UIColor *boxBgColor;

@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic) NSInteger index;
@property (nonatomic,strong) NSDictionary* value;

@property (nonatomic,assign) id <RadioGroupDelegate> delegate;

- (id)initWithFrame:(CGRect)frame WithControl:(NSArray*)controls;
@end
