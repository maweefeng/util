//
//  ImageUtils.h
//
//  Created by leon on 13-9-11.
//  Copyright (c) 2013年 xxx All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageUtils : NSObject

//截取view当前的image对象
+ (UIImage*)captureView:(UIView*)view;

//创建不缓存image对象
+ (UIImage*)noCachedImageNamed:(NSString *)name;

//创建可拉伸image对象
+ (UIImage*)stretchableImageNamed:(NSString*)name;

//创建可拉伸image对象
+ (UIImage*)stretchableImageNamedEx:(NSString*)name;

//图片上添加文字
+ (UIImage *)addText:(UIImage *)img text:(NSString *)someText;

//居中的图片
+ (void)setImageCenterWihtImageView:(UIImageView *)imageView;

/**
 *  图片裁剪
 *
 *  @param image   原始图片
 *  @param newSize 需要拆件的大小
 *
 *  @return 裁剪后的图片
 */
+ (UIImage*)scaleFromImage:(UIImage*)image scaledToSize:(CGSize)newSize;

//处理ios拍照 安卓旋转90°的问题
+ (UIImage *)fixOrientation:(UIImage *)aImage;

//图片按宽度等比例缩放
+(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;

// 截取圆角图像
+(UIImage *)roundCornerImageWithImage:(UIImage *)inputImage radius:(CGFloat)radius;

// 给图像截取圆角并加边框
+(UIImage *)roundCornerImageWithImage:(UIImage *)inputImage borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth radius:(CGFloat)radius;

// 截取圆形图像
+(UIImage *)circularImageWithImage:(UIImage *)inputImage;

// 截取圆形图像并加边框
+(UIImage *)circularImageWithImage:(UIImage *)inputImage borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

// 纯色的圆角矩形
+(UIImage *)roundRectImageWithColor:(UIColor *)color size:(CGSize)size andRadius:(CGFloat)radius;

// 纯色的圆形, 其实就是纯色的特殊圆角矩形
+(UIImage *)cirCularImageWithColor:(UIColor *)color andDiameter:(CGFloat)diameter;

// 一个带边框的圆点
+(UIImage *)solidColorDotWithColor:(UIColor *)color diameter:(CGFloat)diameter borderColor:(UIColor *)borderColor andBorderWidth:(CGFloat)borderWidth;

// 添加一个圆点(badge)
+(UIImage *)addBadge:(UIImage *)badge toImage:(UIImage *)image;

@end
