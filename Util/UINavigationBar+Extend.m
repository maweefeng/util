//
//  UINavigationBar+Extend.m
//  HomeDoctor
//
//  Created by walker on 20/11/2017.
//  Copyright © 2017 WeDoctor Group. All rights reserved.
//

#import "UINavigationBar+Extend.h"
#import <objc/runtime.h>

@implementation UINavigationBar (Extend)

- (UIImage *)originalBackgroundImage {
    return objc_getAssociatedObject(self, @selector(originalBackgroundImage));
}

- (void)setOriginalBackgroundImage:(UIImage *)originalBackgroundImage {
    objc_setAssociatedObject(self, @selector(originalBackgroundImage), originalBackgroundImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)originalShadowImage {
    return objc_getAssociatedObject(self, @selector(originalShadowImage));
}

- (void)setOriginalShadowImage:(UIImage *)originalShadowImage {
    objc_setAssociatedObject(self, @selector(setOriginalShadowImage:), originalShadowImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)wz_setClearBackground {
    if(!self.originalBackgroundImage) {
        self.originalBackgroundImage = [self backgroundImageForBarMetrics:UIBarMetricsDefault];
    }
    if(!self.originalShadowImage) {
        self.originalShadowImage = self.shadowImage;
    }
    [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self setShadowImage:[UIImage new]];
}

- (void)wz_setBackgroundColor:(UIColor *)backgroundColor{
    [self setBackgroundImage:[self imageWithColor:backgroundColor] forBarMetrics:UIBarMetricsDefault];
}

- (void)wz_reset{
    [self setBackgroundImage:self.originalBackgroundImage forBarMetrics:UIBarMetricsDefault];
    [self setShadowImage:self.originalShadowImage];
    // 如果需要恢复颜色, 请改为项目里的实际颜色
    [self setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor darkGrayColor]}];
}

- (UIImage *)imageWithColor:(UIColor *)color {
    //创建1像素区域并开始图片绘图
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    
    //创建画板并填充颜色和区域
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    //从画板上获取图片并关闭图片绘图
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
