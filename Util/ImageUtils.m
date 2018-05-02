//
//  ImageUtils.m
//
//  Created by leon on 13-9-11.
//  Copyright (c) 2013年 xxx All rights reserved.
//

#import "ImageUtils.h"

@implementation ImageUtils

+ (UIImage*)captureView:(UIView*)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage*)noCachedImageNamed:(NSString *)name
{
    if(name == nil)
        return nil;
    NSString* imageFile = [[NSString alloc] initWithFormat:@"%@/%@",[[NSBundle mainBundle] resourcePath],name];
    UIImage* image = [[UIImage alloc] initWithContentsOfFile:imageFile];
    return image;
}

+ (UIImage*)stretchableImageNamed:(NSString*)name
{
    if(name == nil)
        return nil;
    NSString* imageFile = [[NSString alloc] initWithFormat:@"%@/%@",[[NSBundle mainBundle] resourcePath],name];
    UIImage* image = [[UIImage alloc] initWithContentsOfFile:imageFile];
    UIImage* stretchableImage = [image stretchableImageWithLeftCapWidth:image.size.width / 2 topCapHeight:image.size.height / 2];
    return stretchableImage;
}
+ (UIImage*)stretchableImageNamedEx:(NSString*)name
{
    UIImage* imgtemp=  [UIImage imageNamed:name];
    UIImage* stretchableImage = [imgtemp stretchableImageWithLeftCapWidth:imgtemp.size.width / 2 topCapHeight:imgtemp.size.height / 2];
    return stretchableImage;
}

+ (UIImage *)addText:(UIImage *)img text:(NSString *)someText{
	int w = img.size.width;
	int h = img.size.height;
    
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst |kCGBitmapByteOrder32Little);
	CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    
	char* text= (char *)[someText cStringUsingEncoding:NSASCIIStringEncoding];
	CGContextSelectFont(context, "Arial",20, kCGEncodingMacRoman);
	CGContextSetTextDrawingMode(context, kCGTextFill);
	CGContextSetRGBFillColor(context, 0, 0, 0, 1);
	CGContextShowTextAtPoint(context,10,10,text, strlen(text));
	CGImageRef imgCombined = CGBitmapContextCreateImage(context);
	
	CGContextRelease(context);
	CGColorSpaceRelease(colorSpace);
	
	UIImage *retImage = [UIImage imageWithCGImage:imgCombined];
	CGImageRelease(imgCombined);
	
	return retImage;
}

+ (void)setImageCenterWihtImageView:(UIImageView *)imageView
{
    if (!imageView.image) return;
    UIImage *image = imageView.image;
    
    float rateX = image.size.width/imageView.frame.size.width;
    float rateY = image.size.height/imageView.frame.size.height;
    if (rateX >= 1 && rateY >= 1) {
        if (rateX >= rateY) {
            float orginX = (imageView.frame.size.width-image.size.width/rateY)/2.0;
            imageView.frame = CGRectMake(orginX, 0, image.size.width/rateY, imageView.frame.size.height);
        }else{
            float orginY = (imageView.frame.size.height-image.size.height/rateX)/2.0;;
            imageView.frame = CGRectMake(0, orginY, imageView.frame.size.width, image.size.height/rateX);
        }
    }else if (rateX < 1 && rateY < 1){
        if (rateX >= rateY) {
            float orginX = (image.size.width-imageView.frame.size.width/rateY)/2.0;
            imageView.frame = CGRectMake(orginX, 0, imageView.frame.size.width/rateY, image.size.height);
        }else{
            float orginY = (image.size.height-imageView.frame.size.height/rateX)/2.0;;
            imageView.frame = CGRectMake(0, orginY, image.size.width, imageView.frame.size.height/rateX);
        }
    }else{
        
    }
}

/**
 *  图片裁剪
 *
 *  @param image   原始图片
 *  @param newSize 需要拆件的大小
 *
 *  @return 裁剪后的图片
 */
+ (UIImage*)scaleFromImage:(UIImage*)image scaledToSize:(CGSize)newSize{
    CGSize imageSize = image.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    if (width <= newSize.width && height <= newSize.height){
        return image;
    }
    if (width == 0 || height == 0) {
        return image;
    }
    CGFloat widthFactor = newSize.width / width;
    CGFloat heightFactor = newSize.height / height;
    CGFloat scaleFactor = widthFactor/heightFactor;
    CGFloat scaledWidth = width * widthFactor;
    CGFloat scaledHeight = height * heightFactor;
    CGSize targetSize = CGSizeMake(scaledWidth,scaledHeight);
    UIGraphicsBeginImageContext(targetSize);
    [image drawInRect:CGRectMake(0,0,scaledWidth,scaledHeight)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

+(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth{
    
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if(CGSizeEqualToSize(imageSize, size) == NO){
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if(widthFactor > heightFactor){
            
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
            
        }else if(widthFactor < heightFactor){
            
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        
        NSLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - Circular Image


// 截取圆角图像
+(UIImage *)roundCornerImageWithImage:(UIImage *)inputImage radius:(CGFloat)radius {
    CGRect rect = (CGRect){.origin=CGPointZero, .size=inputImage.size};
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    {
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
        [path addClip];
        [inputImage drawInRect:rect];
    }
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return outputImage;
}

// 给图像截取圆角并加边框
+(UIImage *)roundCornerImageWithImage:(UIImage *)inputImage borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth radius:(CGFloat)radius {
    CGRect rect = (CGRect){ .origin=CGPointZero, .size=inputImage.size };
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, inputImage.scale); {
        
        // Fill the entire circle with the border color.
        [borderColor setFill];
        [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius] fill];
        
        // Clip to the interior of the circle (inside the border).
        CGRect interiorBox = CGRectInset(rect, borderWidth, borderWidth);
        UIBezierPath *interior = [UIBezierPath bezierPathWithRoundedRect:interiorBox cornerRadius:radius];
        [interior addClip];
        
        [inputImage drawInRect:rect];
        
    }
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return outputImage;
}

// 截取圆形图像
+(UIImage *)circularImageWithImage:(UIImage *)inputImage {
    CGRect rect = (CGRect){.origin=CGPointZero, .size=inputImage.size};
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    {
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
        [path addClip];
        [inputImage drawInRect:rect];
    }
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return outputImage;
}

// 截取圆形图像并加边框
+(UIImage *)circularImageWithImage:(UIImage *)inputImage borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    CGRect rect = (CGRect){ .origin=CGPointZero, .size=inputImage.size };
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, inputImage.scale); {
        
        // Fill the entire circle with the border color.
        [borderColor setFill];
        [[UIBezierPath bezierPathWithOvalInRect:rect] fill];
        
        // Clip to the interior of the circle (inside the border).
        CGRect interiorBox = CGRectInset(rect, borderWidth, borderWidth);
        UIBezierPath *interior = [UIBezierPath bezierPathWithOvalInRect:interiorBox];
        [interior addClip];
        
        [inputImage drawInRect:rect];
        
    }
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return outputImage;
}

// 纯色的圆角矩形
+(UIImage *)roundRectImageWithColor:(UIColor *)color size:(CGSize)size andRadius:(CGFloat)radius{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    {
        [color setFill];
        [[UIBezierPath bezierPathWithRoundedRect:(CGRect){CGPointZero, size} cornerRadius:radius] fill];
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

// 纯色的圆形, 其实就是特殊的圆角矩形
+(UIImage *)cirCularImageWithColor:(UIColor *)color andDiameter:(CGFloat)diameter {
    CGRect rect = (CGRect){CGPointZero, {diameter, diameter}};
//    return [ImageUtils roundRectImageWithColor:color rect:rect andRadius:diameter/2]; // 测试作为特殊圆角矩形
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);{
        [color setFill];
        [[UIBezierPath bezierPathWithOvalInRect:rect] fill];
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

// 制作一个带边框的圆点
+(UIImage *)solidColorDotWithColor:(UIColor *)color diameter:(CGFloat)diameter borderColor:(UIColor *)borderColor andBorderWidth:(CGFloat)borderWidth {
    CGFloat fullDiameter = diameter + 2*borderWidth;
    CGRect rect = CGRectMake(0.0f, 0.0f, fullDiameter, fullDiameter);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    {
        [borderColor setFill];
        [[UIBezierPath bezierPathWithOvalInRect:rect] fill];
        
        CGRect interiorBox = CGRectInset(rect, borderWidth, borderWidth);
        UIBezierPath *interior = [UIBezierPath bezierPathWithOvalInRect:interiorBox];
        [color setFill];
        [interior fill];
    }
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return outputImage;
}

+(UIImage *)addBadge:(UIImage *)badge toImage:(UIImage *)image {
    CGSize size = {image.size.width + badge.size.width/2, image.size.height + badge.size.height/2};
    CGRect imageRect = (CGRect){CGPointMake(0.0f, badge.size.height/2), image.size};
    CGRect badgeRect = (CGRect){{size.width-badge.size.width, 0}, badge.size};
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    {
        [image drawInRect:imageRect];
        [badge drawInRect:badgeRect];
    }
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return outputImage;
}

@end
