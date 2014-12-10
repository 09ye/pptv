//
//  RadioGroup.m
//
//  Created by 凌洛寒 on 14-5-14.
//  Copyright (c) 2014年 凌洛寒. All rights reserved.
//

#import "RadioGroup.h"
#import "RadioBox.h"

@interface RadioGroup ()

- (void)handleSwitchEvent:(id)sender;

@end

@implementation RadioGroup

- (id)initWithFrame:(CGRect)frame WithControl:(NSArray*)controls
{
    self = [super initWithFrame:frame];
    if (self) {
        for (id control in controls) {
            [self addSubview:control];
        }
        RadioBox * radBoxLast=[controls objectAtIndex:controls.count-1];
        self.contentSize = CGSizeMake(radBoxLast.frame.origin.x+radBoxLast.frame.size.width+10,0);
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self commonInit];
    }
    
    return self;
}

-(void)setTintColor:(UIColor *)tintColor
{
    for (UIView *control in self.subviews) {
        if ([control isKindOfClass:[RadioBox class]]) {
            [(RadioBox*)control setTintColor:tintColor];
        }
    }
}

-(void)setOnTintColor:(UIColor *)onTintColor
{
    for (UIView *control in self.subviews) {
        if ([control isKindOfClass:[RadioBox class]]) {
            [(RadioBox*)control setOnTintColor:onTintColor];
        }
    }
}

-(void)setBoxBgColor:(UIColor *)boxBgColor
{
    for (UIView *control in self.subviews) {
        if ([control isKindOfClass:[RadioBox class]]) {
            [(RadioBox*)control setBoxBgColor:boxBgColor];
        }
    }
}

-(void)setBoxColor:(UIColor *)boxColor
{
    for (UIView *control in self.subviews) {
        if ([control isKindOfClass:[RadioBox class]]) {
            [(RadioBox*)control setBoxColor:boxColor];
        }
    }
}

-(void)setTextColor:(UIColor *)textColor
{
    for (UIView *control in self.subviews) {
        if ([control isKindOfClass:[RadioBox class]]) {
            [(RadioBox*)control setTextColor:textColor];
        }
    }
}

-(void)setTextFont:(UIFont *)textFont
{
    for (UIView *control in self.subviews) {
        if ([control isKindOfClass:[RadioBox class]]) {
            [(RadioBox*)control setTextFont:textFont];
        }
    }
}

- (void)setSelectValue:(NSInteger)selectValue
{
    for (UIView *control in self.subviews) {
        if ([control isKindOfClass:[RadioBox class]]) {
            if (((RadioBox*)control).index == selectValue) {
                [(RadioBox*)control setIsClick:YES];
                [(RadioBox*)control setOn:YES];
            }
        }
    }
}


- (void)commonInit
{
    for (UIView *control in self.subviews) {
        if ([control isKindOfClass:[RadioBox class]]) {
            [(RadioBox*)control addTarget:self action:@selector(handleSwitchEvent:) forControlEvents:UIControlEventValueChanged];
        }
    }

   

}

- (void)handleSwitchEvent:(id)sender
{
    RadioBox* radioBox = (RadioBox*)sender;
    if(self.delegate && [self.delegate respondsToSelector:@selector(radioGroupDidSelect:radioBox:select:)]){
        [self.delegate radioGroupDidSelect:self radioBox:radioBox select:radioBox.isOn];
    }
    for (UIView *control in self.subviews) {
        if ([control isKindOfClass:[RadioBox class]]) {
            if (!((RadioBox*)control).isClick) {
                continue;
            }
            if ([self.subviews indexOfObject:control] != [self.subviews indexOfObject:sender]) {
                [(RadioBox*)control setIsClick:NO];
                if (((RadioBox*)control).isOn) {
                    [(RadioBox*)control setOn:NO];
                }
            }
            else
            {
                self.selectText = ((RadioBox*)control).text;
                self.selectValue = ((RadioBox*)control).index;
            }
        }
    }
}

@end
