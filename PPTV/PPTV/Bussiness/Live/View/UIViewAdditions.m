//
//  UIViewAdditions.m
//  Weibo
//
//  Created by junmin liu on 10-9-29.
//  Copyright 2010 Openlab. All rights reserved.
//

#import "UIViewAdditions.h" 

//border
 #import <objc/runtime.h>

@implementation UIView (Addtions)



///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)left {
	return self.frame.origin.x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setLeft:(CGFloat)x {
	CGRect frame = self.frame;
	frame.origin.x = x;
	self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)top {
	return self.frame.origin.y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setTop:(CGFloat)y {
	CGRect frame = self.frame;
	frame.origin.y = y;
	self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)right {
	return self.frame.origin.x + self.frame.size.width;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setRight:(CGFloat)right {
	CGRect frame = self.frame;
	frame.origin.x = right - frame.size.width;
	self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)bottom {
	return self.frame.origin.y + self.frame.size.height;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setBottom:(CGFloat)bottom {
	CGRect frame = self.frame;
	frame.origin.y = bottom - frame.size.height;
	self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)centerX {
	return self.center.x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setCenterX:(CGFloat)centerX {
	self.center = CGPointMake(centerX, self.center.y);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)centerY {
	return self.center.y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setCenterY:(CGFloat)centerY {
	self.center = CGPointMake(self.center.x, centerY);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)width {
	return self.frame.size.width;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setWidth:(CGFloat)width {
	CGRect frame = self.frame;
	frame.size.width = width;
	self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)height {
	return self.frame.size.height;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setHeight:(CGFloat)height {
	CGRect frame = self.frame;
	frame.size.height = height;
	self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)ttScreenX {
	CGFloat x = 0;
	for (UIView* view = self; view; view = view.superview) {
		x += view.left;
	}
	return x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)ttScreenY {
	CGFloat y = 0;
	for (UIView* view = self; view; view = view.superview) {
		y += view.top;
	}
	return y;
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)screenViewX {
	CGFloat x = 0;
	for (UIView* view = self; view; view = view.superview) {
		x += view.left;
		
		if ([view isKindOfClass:[UIScrollView class]]) {
			UIScrollView* scrollView = (UIScrollView*)view;
			x -= scrollView.contentOffset.x;
		}
	}
	
	return x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)screenViewY {
	CGFloat y = 0;
	for (UIView* view = self; view; view = view.superview) {
		y += view.top;
		
		if ([view isKindOfClass:[UIScrollView class]]) {
			UIScrollView* scrollView = (UIScrollView*)view;
			y -= scrollView.contentOffset.y;
		}
	}
	return y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGRect)screenFrame {
	return CGRectMake(self.screenViewX, self.screenViewY, self.width, self.height);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGPoint)origin {
	return self.frame.origin;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setOrigin:(CGPoint)origin {
	CGRect frame = self.frame;
	frame.origin = origin;
	self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGSize)size {
	return self.frame.size;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setSize:(CGSize)size {
	CGRect frame = self.frame;
	frame.size = size;
	self.frame = frame;
}




///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIView*)descendantOrSelfWithClass:(Class)cls {
	if ([self isKindOfClass:cls])
		return self;
	
	for (UIView* child in self.subviews) {
		UIView* it = [child descendantOrSelfWithClass:cls];
		if (it)
			return it;
	}
	
	return nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIView*)ancestorOrSelfWithClass:(Class)cls {
	if ([self isKindOfClass:cls]) {
		return self;
	} else if (self.superview) {
		return [self.superview ancestorOrSelfWithClass:cls];
	} else {
		return nil;
	}
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)removeAllSubviews {
	while (self.subviews.count) {
		UIView* child = self.subviews.lastObject;
		[child removeFromSuperview];
	}
}



/* simple setting using the layer */
- (void) setCornerRadius : (CGFloat) radius {
	self.layer.cornerRadius = radius;
}

- (void) setBorder : (UIColor *) color width : (CGFloat) width  {
	self.layer.borderColor = [color CGColor];
	self.layer.borderWidth = width;
}

- (void) setShadow : (UIColor *)color opacity:(CGFloat)opacity offset:(CGSize)offset blurRadius:(CGFloat)blurRadius {
	CALayer *l = self.layer;
	l.shadowColor = [color CGColor];
	l.shadowOpacity = opacity;
	l.shadowOffset = offset;
	l.shadowRadius = blurRadius;
}

 

#pragma  mark  =============================================
#pragma  mark  RelatePositions


#define POSITION_ANIMATION_DURATION 0.50

- (void)positionAboveView:(UIView *)view
{
    [self positionAboveView:view withMargin:0.0];
}

- (void)positionBeneathView:(UIView *)view
{
    [self positionBeneathView:view withMargin:0.0];
}

- (void)positionAboveView:(UIView *)view withMargin:(CGFloat)margin
{
    [self positionAboveView:view withMargin:margin animated:NO];
}

- (void)positionBeneathView:(UIView *)view withMargin:(CGFloat)margin
{
    [self positionBeneathView:view withMargin:margin animated:NO];
}

- (void)positionAboveView:(UIView *)view withMargin:(CGFloat)margin animated:(BOOL)animated
{
    CGRect r = self.frame;
    NSLog(@"动画开始时的y坐标值为:%f",r.origin.y);
    r.origin.y = view.frame.origin.y - (self.frame.size.height + margin);
    
    [UIView animateWithDuration:(animated ? 1.0 : 0.2) animations:^{
        self.frame = r;
        NSLog(@"动画中和结束时的y坐标值为:%f",r.origin.y);
    }];
}

- (void)positionBeneathView:(UIView *)view withMargin:(CGFloat)margin animated:(BOOL)animated
{
    CGRect r = self.frame;
    r.origin.y = view.frame.origin.y + view.frame.size.height + margin;
    
    [UIView animateWithDuration:(animated ? POSITION_ANIMATION_DURATION : 0.1) animations:^{
        self.frame = r;
    }];
    [UIView commitAnimations];
}

// LQH77 ADD
- (void)positionExchangeView:(UIView *)view withMargin:(CGFloat)margin animated:(BOOL)animated
{
    CGRect r = self.frame;
    r.origin.x = view.frame.origin.x - (self.frame.size.width + margin);
    
    //     CGRect rr = view.frame;
    //    rr.origin.x=-320;
    
    [UIView animateWithDuration:(animated ? POSITION_ANIMATION_DURATION : 0.0) animations:^{
        self.frame = r;
        //        view.frame=rr;
        
    }];
}


// LQH77 ADD right
- (void)positionToRightView:(UIView *)view withMargin:(CGFloat)margin animated:(BOOL)animated
{
    CGRect r = self.frame;
    //r.origin.x = view.frame.origin.x - (self.frame.size.width + margin);
    r.origin.x=0;
    CGRect rr = view.frame;
    rr.origin.x=320;
    
    [UIView animateWithDuration:(animated ? POSITION_ANIMATION_DURATION : 0.0) animations:^{
        self.frame = r;
        view.frame=rr;
        
    }];
}

// LQH77 ADD  left
- (void)positionToLeftView:(UIView *)view withMargin:(CGFloat)margin animated:(BOOL)animated
{
    CGRect r = self.frame;
    //    r.origin.x = view.frame.origin.x - (self.frame.size.width + margin);
    
    r.origin.x=0;
    
    CGRect rr = view.frame;
    rr.origin.x=-320;
    
    [UIView animateWithDuration:(animated ? POSITION_ANIMATION_DURATION : 0.0) animations:^{
        self.frame = r;
        view.frame=rr;
        
    }];
    
    
    
}


//
//
//-(CABasicAnimation *)moveY:(float)time   Y:(NSNumber *)y    withView:(UIView *)a_view //纵向移动
//
//{
//
//    //    CABasicAnimation *theAnimation;
//    //    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
//    //    theAnimation.delegate = self;
//    //    theAnimation.duration = 0.5;
//    //    theAnimation.repeatCount = 0;
//    //    theAnimation.removedOnCompletion = TRUE;
//    //    theAnimation.fillMode = kCAFillModeForwards;
//    //    theAnimation.autoreverses = NO;
//    //    theAnimation.fromValue = [NSNumber numberWithFloat:IPHONE5?(460+88-80):(460-80)];
//    //    theAnimation.toValue = [NSNumber numberWithFloat:IPHONE5?(460+88):460];
//    //    [bottomView.layer addAnimation:theAnimation forKey:@"animateLayer"];
//
//    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
//
//    animation.toValue=y;
//    animation.delegate = self;
//    animation.duration = 0.5;
//    animation.repeatCount = 0;
//    animation.duration=time;
//
//    animation.removedOnCompletion=NO;
//
//    animation.fillMode=kCAFillModeForwards;
//
//
//
//    //bottomview
//    CABasicAnimation *theAnimation;
//    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
//    theAnimation.delegate = self;
//    theAnimation.duration = 0.1;
//    theAnimation.repeatCount = 0;
//    theAnimation.removedOnCompletion = TRUE;
//    theAnimation.fillMode = kCAFillModeForwards;
//    theAnimation.autoreverses = NO;
//    theAnimation.fromValue = [NSNumber numberWithFloat:IPHONE5?(460+88-80):(460-80)];
//    theAnimation.toValue = [NSNumber numberWithFloat:IPHONE5?(460+88):460];
//    [bottomView.layer addAnimation:theAnimation forKey:@"animateLayer"];
//
//
//    //contentview
//    CABasicAnimation *theAnimation2;
//    theAnimation2=[CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
//    theAnimation2.delegate = self;
//    theAnimation2.duration = 0.1;
//    theAnimation2.repeatCount = 0;
//    theAnimation2.removedOnCompletion = TRUE;
//    theAnimation2.fillMode = kCAFillModeForwards;
//    theAnimation2.autoreverses = NO;
//    theAnimation2.fromValue = [NSNumber numberWithFloat:-80];
//    theAnimation2.toValue = [NSNumber numberWithFloat:0];
//    [contentView.layer addAnimation:theAnimation2 forKey:@"animateLayer"];
//
//    return animation;
//}

-(CABasicAnimation *)opacityForever_Animation:(float)time //永久闪烁的动画

{
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    
    animation.fromValue=[NSNumber numberWithFloat:1.0];
    
    animation.toValue=[NSNumber numberWithFloat:0.0];
    
    animation.autoreverses=YES;
    
    animation.duration=time;
    
    animation.repeatCount=FLT_MAX;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    return animation;
    
}

-(CABasicAnimation *)moveX:(float)time X:(NSNumber *)x  withFillMode:(int )mode//横向移动

{
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    
    animation.toValue=x;
    
    animation.duration=time;
    
    animation.removedOnCompletion=NO;
    
    if (mode==1) {
        animation.fillMode= kCAFillModeForwards;
    }else if (mode==2){
        
        animation.fillMode= kCAFillModeForwards;
    }
    
    return animation;
    
}



-(CABasicAnimation *)moveY:(float)time   Y:(NSNumber *)y //纵向移动

{
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    
    animation.toValue=y;
    
    animation.duration=time;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    return animation;
    
}


-(CABasicAnimation *)scale:(NSNumber *)Multiple orgin:(NSNumber *)orginMultiple durTimes:(float)time Rep:(float)repeatTimes //缩放

{
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    animation.fromValue=orginMultiple;
    
    animation.toValue=Multiple;
    
    animation.duration=time;
    
    animation.autoreverses=YES;
    
    animation.repeatCount=repeatTimes;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    return animation;
    
}



-(CAAnimationGroup *)groupAnimation:(NSArray *)animationAry durTimes:(float)time Rep:(float)repeatTimes //组合动画

{
    
    CAAnimationGroup *animation=[CAAnimationGroup animation];
    
    animation.animations=animationAry;
    
    animation.duration=time;
    
    animation.repeatCount=repeatTimes;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    return animation;
    
}



-(CAKeyframeAnimation *)keyframeAniamtion:(CGMutablePathRef)path durTimes:(float)time Rep:(float)repeatTimes //路径动画

{
    
    CAKeyframeAnimation *animation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    animation.path=path;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    animation.autoreverses=NO;
    
    animation.duration=time;
    
    animation.repeatCount=repeatTimes;
    
    return animation;
    
}



-(CABasicAnimation *)movepoint:(CGPoint )point //点移动

{
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation"];
    
    animation.toValue=[NSValue valueWithCGPoint:point];
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    return animation;
    
}

-(CABasicAnimation *)rotation:(float)dur degree:(float)degree direction:(int)direction repeatCount:(int)repeatCount //旋转

{
    
    CATransform3D rotationTransform  = CATransform3DMakeRotation(degree, 0, 0,direction);
    
    CABasicAnimation* animation;
    
    animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    
    
    animation.toValue= [NSValue valueWithCATransform3D:rotationTransform];
    
    animation.duration= dur;
    
    animation.autoreverses= NO;
    
    animation.cumulative= YES;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    animation.repeatCount= repeatCount;
    
    animation.delegate= self;
    
    return animation;
    
}





// Very helpful function

float radiansForDegrees(int degrees) {
    return degrees * M_PI / 180;
}


#pragma mark - Moves

- (void)moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option {
    [self moveTo:destination duration:secs option:option delegate:nil callback:nil];
}

- (void)moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option delegate:(id)delegate callback:(SEL)method {
    [UIView animateWithDuration:secs delay:0.0 options:option
                     animations:^{
                         self.frame = CGRectMake(destination.x,destination.y, self.frame.size.width, self.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (delegate != nil) {
                            // [delegate performSelector:method];
                         }
                     }];
}

- (void)raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack {
    [self raceTo:destination withSnapBack:withSnapBack delegate:nil callback:nil];
}

- (void)raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack delegate:(id)delegate callback:(SEL)method {
    CGPoint stopPoint = destination;
    if (withSnapBack) {
        // Determine our stop point, from which we will "snap back" to the final destination
        int diffx = destination.x - self.frame.origin.x;
        int diffy = destination.y - self.frame.origin.y;
        if (diffx < 0) {
            // Destination is to the left of current position
            stopPoint.x -= 10.0;
        } else if (diffx > 0) {
            stopPoint.x += 10.0;
        }
        if (diffy < 0) {
            // Destination is to the left of current position
            stopPoint.y -= 10.0;
        } else if (diffy > 0) {
            stopPoint.y += 10.0;
        }
    }
    
    // Do the animation
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.frame = CGRectMake(stopPoint.x, stopPoint.y, self.frame.size.width, self.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (withSnapBack) {
                             [UIView animateWithDuration:0.1
                                                   delay:0.0
                                                 options:UIViewAnimationOptionCurveLinear
                                              animations:^{
                                                  self.frame = CGRectMake(destination.x, destination.y, self.frame.size.width, self.frame.size.height);
                                              }
                                              completion:^(BOOL finished) {
                                                 // [delegate performSelector:method];
                                              }];
                         } else {
                             //[delegate performSelector:method];
                         }
                     }];
}


#pragma mark - Transforms

- (void)rotate:(int)degrees secs:(float)secs delegate:(id)delegate callback:(SEL)method {
    [UIView animateWithDuration:secs
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.transform = CGAffineTransformRotate(self.transform, radiansForDegrees(degrees));
                     }
                     completion:^(BOOL finished) {
                         if (delegate != nil) {
                           //  [delegate performSelector:method];
                         }
                     }];
}

- (void)scale:(float)secs x:(float)scaleX y:(float)scaleY delegate:(id)delegate callback:(SEL)method {
    [UIView animateWithDuration:secs
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.transform = CGAffineTransformScale(self.transform, scaleX, scaleY);
                     }
                     completion:^(BOOL finished) {
                         if (delegate != nil) {
                           //  [delegate performSelector:method];
                         }
                     }];
}

- (void)spinClockwise:(float)secs {
    [UIView animateWithDuration:secs/4
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.transform = CGAffineTransformRotate(self.transform, radiansForDegrees(90));
                     }
                     completion:^(BOOL finished) {
                         [self spinClockwise:secs];
                     }];
}

- (void)spinCounterClockwise:(float)secs {
    [UIView animateWithDuration:secs/4
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.transform = CGAffineTransformRotate(self.transform, radiansForDegrees(270));
                     }
                     completion:^(BOOL finished) {
                         [self spinCounterClockwise:secs];
                     }];
}


#pragma mark - Transitions

- (void)curlDown:(float)secs {
    [UIView transitionWithView:self duration:secs
                       options:UIViewAnimationOptionTransitionCurlDown
                    animations:^ { [self setAlpha:1.0]; }
                    completion:nil];
}

- (void)curlUpAndAway:(float)secs {
    [UIView transitionWithView:self duration:secs
                       options:UIViewAnimationOptionTransitionCurlUp
                    animations:^ { [self setAlpha:0]; }
                    completion:nil];
}

- (void)drainAway:(float)secs {
	NSTimer *timer;
    self.tag = 20;
	timer = [NSTimer scheduledTimerWithTimeInterval:secs/50 target:self selector:@selector(drainTimer:) userInfo:nil repeats:YES];
}

- (void)drainTimer:(NSTimer*)timer {
	CGAffineTransform trans = CGAffineTransformRotate(CGAffineTransformScale(self.transform, 0.9, 0.9),0.314);
	self.transform = trans;
	self.alpha = self.alpha * 0.98;
	self.tag = self.tag - 1;
	if (self.tag <= 0) {
		[timer invalidate];
		[self removeFromSuperview];
	}
}

#pragma mark - Effects

- (void)changeAlpha:(float)newAlpha secs:(float)secs {
    [UIView animateWithDuration:secs
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.alpha = newAlpha;
                     }
                     completion:nil];
}

- (void)pulse:(float)secs continuously:(BOOL)continuously {
    [UIView animateWithDuration:secs/2
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         // Fade out, but not completely
                         self.alpha = 0.3;
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:secs/2
                                               delay:0.0
                                             options:UIViewAnimationOptionCurveLinear
                                          animations:^{
                                              // Fade in
                                              self.alpha = 1.0;
                                          }
                                          completion:^(BOOL finished) {
                                              if (continuously) {
                                                  [self pulse:secs continuously:continuously];
                                              }
                                          }];
                     }];
}



#pragma  mark ================================== ========
#pragma  mark =  imageRepresentation

- (UIImage *)imageRepresentation {
	UIGraphicsBeginImageContext(self.bounds.size);
	[self.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return image;
}


- (void)hide {
	self.alpha = 0.0;
}


- (void)show {
	self.alpha = 1.0;
}


- (void)fadeOut {
	[self fadeAlphaTo:0.0 andPerformSelector:NULL withObject:nil];
}


- (void)fadeOutAndPerformSelector:(SEL)selector {
	[self fadeAlphaTo:0.0 andPerformSelector:selector withObject:nil];
}


- (void)fadeOutAndPerformSelector:(SEL)selector withObject:(id)object {
	[self fadeAlphaTo:0.0 andPerformSelector:selector withObject:object];
}


- (void)fadeIn {
	[self fadeAlphaTo:1.0 andPerformSelector:NULL withObject:nil];
}


- (void)fadeInAndPerformSelector:(SEL)selector {
	[self fadeAlphaTo:1.0 andPerformSelector:selector withObject:nil];
}


- (void)fadeInAndPerformSelector:(SEL)selector withObject:(id)object {
	[self fadeAlphaTo:1.0 andPerformSelector:selector withObject:object];
}


- (void)fadeAlphaTo:(CGFloat)targetAlpha {
	[self fadeAlphaTo:targetAlpha andPerformSelector:NULL withObject:nil];
}


- (void)fadeAlphaTo:(CGFloat)targetAlpha andPerformSelector:(SEL)selector {
	[self fadeAlphaTo:targetAlpha andPerformSelector:selector withObject:nil];
}


- (void)fadeAlphaTo:(CGFloat)targetAlpha andPerformSelector:(SEL)selector withObject:(id)object {
	// Don't fade and perform selector if alpha is already target alpha
	if (self.alpha == targetAlpha) {
		return;
	}
	
	// Perform fade
	[UIView beginAnimations:@"fadealpha" context:nil];
	self.alpha = targetAlpha;
	[UIView commitAnimations];
	
	// Perform selector after animation
	if (selector) {
		[self performSelector:selector withObject:object afterDelay:0.21];
	}
}




- (void)setShadowHidden:(BOOL)yesOrNo
{
    [self setShadowHidden:yesOrNo offset:CGSizeMake(0, 2)];
}

- (void)setShadowHidden:(BOOL)yesOrNo offset:(CGSize)size
{
    [self setShadowColor:[UIColor blackColor] hidden:yesOrNo offset:size];
}

- (void)setShadowColor:(UIColor *)color hidden:(BOOL)yesOrNo offset:(CGSize)size
{
    if (!yesOrNo)
    {
        self.clipsToBounds = NO;
        self.layer.shadowColor = color.CGColor;
        self.layer.shadowRadius = 2.;
        self.layer.shadowOffset = size;
        self.layer.shadowOpacity = 0.4;
    }
    else
    {
        self.clipsToBounds = YES;
        self.layer.shadowColor = [UIColor clearColor].CGColor;
        self.layer.shadowRadius = 0.;
        self.layer.shadowOffset = CGSizeZero;
        self.layer.shadowOpacity = 0.;
    }
}

+(CGSize)makeSize:(CGSize)size toFitWidth:(float)width
{
    CGSize retSize = size;
    if (size.width > width)
    {
        retSize.height = width*size.height/size.width;
        retSize.width = width;
    }
    return retSize;
}




- (void)makeRoundCornerWithRadius:(CGFloat)radius showShadow:(BOOL)isShow
{
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
    
    if (isShow)
    {
        self.clipsToBounds = NO;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowRadius = 2.;
        self.layer.shadowOffset = CGSizeMake(0, 0);
        self.layer.shadowOpacity = 0.4;
    }
    else
    {
        self.clipsToBounds = YES;
        self.layer.shadowColor = [UIColor clearColor].CGColor;
        self.layer.shadowRadius = 0.;
        self.layer.shadowOffset = CGSizeZero;
        self.layer.shadowOpacity = 0.;
    }
}

- (void)makeRoundCornerWithRadius:(CGFloat)radius
{
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

#pragma  mark  =============================================
#pragma  mark UIView (Visuals)

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////

-(void)cornerRadius: (CGFloat)radius strokeSize: (CGFloat)size color: (UIColor *)color
{
    self.layer.cornerRadius = radius;
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = size;
}

///////////////////////////////////////////////////////////////////////////////////////////////////

-(void)shadowWithColor: (UIColor *)color
                offset: (CGSize)offset
               opacity: (CGFloat)opacity
                radius: (CGFloat)radius
{
    self.clipsToBounds = NO;
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowRadius = radius;
}

///////////////////////////////////////////////////////////////////////////////////////////////////

-(void)removeFromSuperviewWithFadeDuration: (NSTimeInterval)duration
{
    [UIView beginAnimations: nil context: NULL];
	[UIView setAnimationBeginsFromCurrentState: YES];
	[UIView setAnimationDuration: duration];
    [UIView setAnimationDelegate: self];
    [UIView setAnimationDidStopSelector: @selector(removeFromSuperview)];
    self.alpha = 0.0;
	[UIView commitAnimations];
}

///////////////////////////////////////////////////////////////////////////////////////////////////

-(void)addSubview: (UIView *)subview withTransition: (UIViewAnimationTransition)transition duration: (NSTimeInterval)duration;
{
	[UIView beginAnimations: nil context: NULL];
	[UIView setAnimationDuration: duration];
	[UIView setAnimationTransition: transition forView: self cache: YES];
	[self addSubview: subview];
	[UIView commitAnimations];
}

///////////////////////////////////////////////////////////////////////////////////////////////////

-(void)removeFromSuperviewWithTransition: (UIViewAnimationTransition)transition duration: (NSTimeInterval)duration
{
	[UIView beginAnimations: nil context: NULL];
	[UIView setAnimationDuration: duration];
	[UIView setAnimationTransition: transition forView: self.superview cache: YES];
	[self removeFromSuperview];
	[UIView commitAnimations];
}



#pragma  mark===================================================
#pragma  mark== UIView(Hierarchy)

-(int)getSubviewIndex
{
	return [self.superview.subviews indexOfObject:self];
}

-(void)bringToFront
{
	[self.superview bringSubviewToFront:self];
}

-(void)sentToBack
{
	[self.superview sendSubviewToBack:self];
}

-(void)bringOneLevelUp
{
	int currentIndex = [self getSubviewIndex];
	[self.superview exchangeSubviewAtIndex:currentIndex withSubviewAtIndex:currentIndex+1];
}

-(void)sendOneLevelDown
{
	int currentIndex = [self getSubviewIndex];
	[self.superview exchangeSubviewAtIndex:currentIndex withSubviewAtIndex:currentIndex-1];
}

-(BOOL)isInFront
{
	return ([self.superview.subviews lastObject]==self);
}

-(BOOL)isAtBack
{
	return ([self.superview.subviews objectAtIndex:0]==self);
}

-(void)swapDepthsWithView:(UIView*)swapView
{
	[self.superview exchangeSubviewAtIndex:[self getSubviewIndex] withSubviewAtIndex:[swapView getSubviewIndex]];
}



- (void)setFrame:(CGRect)frame animated:(BOOL)animated
{
    if (animated) {
        [UIView animateWithDuration:0.4 animations:^{
            [self setFrame:frame];
        }];
    }
    else
    {
        [self setFrame:frame];
    }
}

//==============

- (void) showBorder
{
    
    if (![self borderColor]) {
        [self setBorderColor:[UIColor redColor]];
    }
    
    if (![self borderWidth]) {
        [self setBorderWidth:1.0];
    }
    
    [[self layer] setBorderColor:[self borderColor].CGColor];
    [[self layer] setBorderWidth:[self borderWidth]];
}

- (void) hideBorder{
    [[self layer] setBorderWidth:0.0];
    [[self layer] setBorderColor:[UIColor clearColor].CGColor];
}

#pragma mark - Border Color

static char * kBorderColorKey = "border color key";

- (void) setBorderColor:(UIColor *)color
{
    objc_setAssociatedObject(self, kBorderColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)borderColor
{
    return objc_getAssociatedObject(self, kBorderColorKey);
}

#pragma mark - Border Width

static char * kBorderWidthKey = "border width key";

- (void) setBorderWidth:(CGFloat)width
{
    objc_setAssociatedObject(self, kBorderWidthKey, @(width), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)borderWidth
{
    return [objc_getAssociatedObject(self, kBorderWidthKey) floatValue];
}



@end
