//
//  UIView+Extension.h
//  HealthChengDuTKT
//
//  Created by walker on 23/12/2016.
//  Copyright © 2017 WeDoctor Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
/**
 清空一个 UIView, 包括所有的subviews, sublayers
 */
- (void)emptyAllSubViewsAndLayers;

- (UIView*)subViewOfClassName:(NSString*)className;
//错误提示界面
+ (UIView*)errorView:(CGRect)frame;
//错误提示移除
+ (void)errorViewRemove:(UIView*)selfView;
+ (UIView*)errorView:(CGRect)frame type:(NSInteger)type;
@end
