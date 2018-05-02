//
//  UIView+Border.m
//  testIGListKit
//
//  Created by walker on 16/12/2016.
//  Copyright © 2016 walker. All rights reserved.
//

#import "UIView+Border.h"

@implementation UIView (Border)

- (void)addBorderTo:(UIViewBorder)border withColor:(UIColor *)color borderWidth:(CGFloat)width{
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    CGSize size = self.bounds.size;
    // default draw a top line
    CGPoint point_start = CGPointMake(0, 0);
    CGPoint point_end = CGPointMake(size.width, 0);
    switch (border) {
        case UIViewBorderLeft:
            point_end = CGPointMake(0, size.height);
            break;
        case UIViewBorderRight:{
            point_start = CGPointMake(size.width, 0);
            point_end = CGPointMake(size.width, size.height);
            break;
        }
        case UIViewBorderBottom:{
            point_start = CGPointMake(0, size.height);
            point_end = CGPointMake(size.width, size.height);
        }
        default:
            break;
    }
    [linePath moveToPoint:point_start];
    [linePath addLineToPoint:point_end];
    lineLayer.path = linePath.CGPath;
    lineLayer.lineWidth = width;
    lineLayer.strokeColor = color.CGColor;
    [self.layer addSublayer:lineLayer];
}

- (void)addBorderTo:(UIViewBorder)border withColor:(UIColor *)color{
    [self addBorderTo:border withColor:color borderWidth:1.0f];
}

@end
