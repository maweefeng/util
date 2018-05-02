//
//  UIView+Animation.h
//  HealthChengDuTKT
//
//  Created by lijing on 2016/12/15.
//  Copyright © 2017 WeDoctor Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Animation)
-(UIView*)uiViewAnimation:(UIView*)view setFrame:(CGRect)frame setDuration:(float)num;
-(UIView*)uiViewAnimation:(UIView*)view setFrame:(CGRect)frame setDuration:(float)num  callback:(void(^)(bool))callback;
-(void)addRoundedCorners:(UIRectCorner)corners withRadii:(CGSize)radii;
-(CALayer*)maskForRoundedCorners:(UIRectCorner)corners withRadii:(CGSize)radii;
@end
