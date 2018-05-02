//
//  UIView+Animation.m
//  HealthChengDuTKT
//
//  Created by lijing on 2016/12/15.
//  Copyright © 2017 WeDoctor Group. All rights reserved.
//

#import "UIView+Animation.h"

@implementation UIView (Animation)

-(UIView*)uiViewAnimation:(UIView*)view setFrame:(CGRect)frame setDuration:(float)num
{
    [UIView beginAnimations:@"滑动" context:NULL];
    [UIView setAnimationDuration:num];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationRepeatCount:1];
    [view setFrame:frame];
    [UIView commitAnimations];
    return view;
}

-(UIView*)uiViewAnimation:(UIView*)view setFrame:(CGRect)frame setDuration:(float)num  callback:(void(^)(bool))callback
{
    [UIView beginAnimations:@"滑动" context:NULL];
    [UIView setAnimationDuration:num];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationRepeatCount:1];
    [view setFrame:frame];
    [UIView commitAnimations];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        callback(YES);
    });
    return view;
}

-(void)addRoundedCorners:(UIRectCorner)corners withRadii:(CGSize)radii {
    CALayer *tMaskLayer = [self maskForRoundedCorners:corners withRadii:radii];
    self.layer.mask = tMaskLayer;
}

-(CALayer*)maskForRoundedCorners:(UIRectCorner)corners withRadii:(CGSize)radii {
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    
    UIBezierPath *roundedPath = [UIBezierPath bezierPathWithRoundedRect:
                                 maskLayer.bounds byRoundingCorners:corners cornerRadii:radii];
    maskLayer.fillColor = [[UIColor whiteColor] CGColor];
    maskLayer.backgroundColor = [[UIColor clearColor] CGColor];
    maskLayer.path = [roundedPath CGPath];
    
    return maskLayer;
}
@end
