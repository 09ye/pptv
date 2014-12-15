//
//  UIViewAdditions.h
//  Weibo
//
//  Created by junmin liu on 10-9-29.
//  Copyright 2010 Openlab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>



@interface UIView (Addtions)


/**
 * Shortcut for frame.origin.x.
 *
 * Sets frame.origin.x = left
 */
@property (nonatomic) CGFloat left;

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic) CGFloat top;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic) CGFloat right;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic) CGFloat bottom;

/**
 * Shortcut for frame.size.width
 *
 * Sets frame.size.width = width
 */
@property (nonatomic) CGFloat width;

/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property (nonatomic) CGFloat height;

/**
 * Shortcut for center.x
 *
 * Sets center.x = centerX
 */
@property (nonatomic) CGFloat centerX;

/**
 * Shortcut for center.y
 *
 * Sets center.y = centerY
 */
@property (nonatomic) CGFloat centerY;

/**
 * Return the x coordinate on the screen.
 */
@property (nonatomic, readonly) CGFloat ttScreenX;

/**
 * Return the y coordinate on the screen.
 */
@property (nonatomic, readonly) CGFloat ttScreenY;

/**
 * Return the x coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGFloat screenViewX;

/**
 * Return the y coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGFloat screenViewY;

/**
 * Return the view frame on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGRect screenFrame;

/**
 * Shortcut for frame.origin
 */
@property (nonatomic) CGPoint origin;

/**
 * Shortcut for frame.size
 */
@property (nonatomic) CGSize size;



- (UIView*)descendantOrSelfWithClass:(Class)cls;

- (UIView*)ancestorOrSelfWithClass:(Class)cls;
 

- (void)removeAllSubviews;


#pragma mark  -============================
#pragma mark  -=======UIView(LayerEffects)

// set round corner
- (void) setCornerRadius : (CGFloat) radius;
// set inner border
- (void) setBorder : (UIColor *) color width : (CGFloat) width;
// set the shadow
// Example: [view setShadow:[UIColor blackColor] opacity:0.5 offset:CGSizeMake(1.0, 1.0) blueRadius:3.0];
- (void) setShadow : (UIColor *)color opacity:(CGFloat)opacity offset:(CGSize) offset blurRadius:(CGFloat)blurRadius;


#pragma mark  -============================
#pragma mark  -=======UIView(RelativePositioning) 
float radiansForDegrees(int degrees);
 
- (void)positionAboveView:(UIView *)view;
- (void)positionBeneathView:(UIView *)view;

- (void)positionAboveView:(UIView *)view withMargin:(CGFloat)margin;
- (void)positionBeneathView:(UIView *)view withMargin:(CGFloat)margin;

- (void)positionAboveView:(UIView *)view withMargin:(CGFloat)margin animated:(BOOL)animated;
- (void)positionBeneathView:(UIView *)view withMargin:(CGFloat)margin animated:(BOOL)animated;
// lqh77
- (void)positionExchangeView:(UIView *)view withMargin:(CGFloat)margin animated:(BOOL)animated;

- (void)positionToRightView:(UIView *)view withMargin:(CGFloat)margin animated:(BOOL)animated;
- (void)positionToLeftView:(UIView *)view withMargin:(CGFloat)margin animated:(BOOL)animated;


-(CABasicAnimation *)opacityForever_Animation:(float)time; //永久闪烁的动画

-(CABasicAnimation *)moveX:(float)time X:(NSNumber *)x  withFillMode:(int )mode;//横向移动
-(CABasicAnimation *)moveY:(float)time Y:(NSNumber *)y; //纵向移动



// Moves
- (void)moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option;
- (void)moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option delegate:(id)delegate callback:(SEL)method;
- (void)raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack;
- (void)raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack delegate:(id)delegate callback:(SEL)method;

// Transforms
- (void)rotate:(int)degrees secs:(float)secs delegate:(id)delegate callback:(SEL)method;
- (void)scale:(float)secs x:(float)scaleX y:(float)scaleY delegate:(id)delegate callback:(SEL)method;
- (void)spinClockwise:(float)secs;
- (void)spinCounterClockwise:(float)secs;

// Transitions
- (void)curlDown:(float)secs;
- (void)curlUpAndAway:(float)secs;
- (void)drainAway:(float)secs;

// Effects
- (void)changeAlpha:(float)newAlpha secs:(float)secs;
- (void)pulse:(float)secs continuously:(BOOL)continuously;


#pragma  mark ====================================================
#pragma  mark =  imageRepresentation
- (UIImage *)imageRepresentation;

//UIView (Shadow)

- (void)setShadowHidden:(BOOL)yesOrNo;

- (void)setShadowHidden:(BOOL)yesOrNo offset:(CGSize)size;

- (void)setShadowColor:(UIColor *)color hidden:(BOOL)yesOrNo offset:(CGSize)size;

+ (CGSize)makeSize:(CGSize)size toFitWidth:(float)width;

// UIView (Corner)
- (void)makeRoundCornerWithRadius:(CGFloat)radius showShadow:(BOOL)isShow;

- (void)makeRoundCornerWithRadius:(CGFloat)radius;

- (void)hide;
- (void)show;

- (void)fadeOut;
- (void)fadeOutAndPerformSelector:(SEL)selector;
- (void)fadeOutAndPerformSelector:(SEL)selector withObject:(id)object;

- (void)fadeIn;
- (void)fadeInAndPerformSelector:(SEL)selector;
- (void)fadeInAndPerformSelector:(SEL)selector withObject:(id)object;

- (void)fadeAlphaTo:(CGFloat)targetAlpha;
- (void)fadeAlphaTo:(CGFloat)targetAlpha andPerformSelector:(SEL)selector;
- (void)fadeAlphaTo:(CGFloat)targetAlpha andPerformSelector:(SEL)selector withObject:(id)object;


#pragma  mark  =========================================
#pragma  mark  visual
/*
 *  Sets a corners with radius, given stroke size & color
 */
-(void)cornerRadius: (CGFloat)radius
         strokeSize: (CGFloat)size
              color: (UIColor *)color;

/*
 *  Draws shadow with properties
 */
-(void)shadowWithColor: (UIColor *)color
                offset: (CGSize)offset
               opacity: (CGFloat)opacity
                radius: (CGFloat)radius;

/*
 *  Removes from superview with fade
 */
-(void)removeFromSuperviewWithFadeDuration: (NSTimeInterval)duration;

/*
 *  Adds a subview with given transition & duration
 */
-(void)addSubview: (UIView *)view withTransition: (UIViewAnimationTransition)transition duration: (NSTimeInterval)duration;

/*
 *  Removes from superview with given transition & duration
 */
-(void)removeFromSuperviewWithTransition: (UIViewAnimationTransition)transition duration: (NSTimeInterval)duration;


#pragma  mark  ======================
#pragma  mark  UIView+Hierarchy.h

 

//
- (void) showBorder;
- (void) hideBorder;

- (void) setBorderColor:(UIColor *)color;
- (void) setBorderWidth:(CGFloat)width;



-(int)getSubviewIndex;

-(void)bringToFront;
-(void)sentToBack;

-(void)bringOneLevelUp;
-(void)sendOneLevelDown;

-(BOOL)isInFront;
-(BOOL)isAtBack;

-(void)swapDepthsWithView:(UIView*)swapView;

- (void)setFrame:(CGRect)frame animated:(BOOL)animated;


@end
