//
//  UIView+Border.h
//  testIGListKit
//
//  Created by walker on 16/12/2016.
//  Copyright © 2016 walker. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, UIViewBorder) {
    UIViewBorderLeft,
    UIViewBorderRight,
    UIViewBorderTop,
    UIViewBorderBottom,
};

@interface UIView (Border)

- (void)addBorderTo:(UIViewBorder)border withColor:(UIColor *)color borderWidth:(CGFloat)width;

- (void)addBorderTo:(UIViewBorder)border withColor:(UIColor *)color;


@end
