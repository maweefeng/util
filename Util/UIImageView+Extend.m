//
//  UIImageView+Extend.m
//  HealthChengDuTKT
//
//  Created by lijing on 2016/12/23.
//  Copyright © 2017 WeDoctor Group. All rights reserved.
//

#import "UIImageView+Extend.h"

@implementation UIImageView (Extend)
CGRect oldHidFrame;


-(void)showImage:(UIImageView *)avatarImageView atHidTapView:(UITapGestureRecognizer*)tapGest atOldFrame:(CGRect)oldFrame{
    UIImage *image = avatarImageView.image;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    oldFrame = [avatarImageView convertRect:avatarImageView.bounds toView:window];
    oldHidFrame = oldFrame;
    backgroundView.backgroundColor=[UIColor blackColor];
    backgroundView.alpha = 0;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:oldFrame];
    imageView.image = image;
    imageView.tag = 1;
    imageView.userInteractionEnabled = YES;
    imageView.layer.masksToBounds = YES;
    [backgroundView addSubview:imageView];
    [window addSubview:backgroundView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    tapGest = tap;
    [backgroundView addGestureRecognizer: tap];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=CGRectMake(0,([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
        [imageView setContentMode:UIViewContentModeScaleAspectFit];
        
        //uiimage添加缩放 移动手势
        
        UIPinchGestureRecognizer *recognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self                                                                       action:@selector(handlePinch:)];
        [imageView addGestureRecognizer:recognizer];

        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self                                                                                action:@selector(handlePan:)];
        [imageView addGestureRecognizer:panRecognizer];
        
        backgroundView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

//图片缩小放大
- (void)handlePinch:(UIPinchGestureRecognizer *)recognizer {
    CGFloat scale = recognizer.scale;
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, scale, scale); //在已缩放大小基础下进行累加变化；区别于：使用 CGAffineTransformMakeScale 方法就是在原大小基础下进行变化
    recognizer.scale = 1.0;
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer{
    //视图前置操作
    [recognizer.view.superview bringSubviewToFront:recognizer.view];
    
    CGPoint center = recognizer.view.center;
    CGFloat cornerRadius = recognizer.view.frame.size.width / 2;
    CGPoint translation = [recognizer translationInView:recognizer.view];
    //NSLog(@"%@", NSStringFromCGPoint(translation));
    recognizer.view.center = CGPointMake(center.x + translation.x, center.y + translation.y);
    [recognizer setTranslation:CGPointZero inView:recognizer.view];
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        //计算速度向量的长度，当他小于200时，滑行会很短
        CGPoint velocity = [recognizer velocityInView:recognizer.view];
        CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
        CGFloat slideMult = magnitude / 200;
        //NSLog(@"magnitude: %f, slideMult: %f", magnitude, slideMult); //e.g. 397.973175, slideMult: 1.989866
        
        //基于速度和速度因素计算一个终点
        float slideFactor = 0.1 * slideMult;
        CGPoint finalPoint = CGPointMake(center.x + (velocity.x * slideFactor),
                                         center.y + (velocity.y * slideFactor));
        //限制最小［cornerRadius］和最大边界值［self.view.bounds.size.width - cornerRadius］，以免拖动出屏幕界限
        finalPoint.x = MIN(MAX(finalPoint.x, cornerRadius),
                           recognizer.view.bounds.size.width - cornerRadius);
        finalPoint.y = MIN(MAX(finalPoint.y, cornerRadius),
                           recognizer.view.bounds.size.height - cornerRadius);
        
        //使用 UIView 动画使 view 滑行到终点
        //                 [UIView animateWithDuration:slideFactor*2
        //                                                delay:0
        //                                                options:UIViewAnimationOptionCurveEaseOut
        //                                             animations:^{
        //                                                     recognizer.view.center = finalPoint;
        //                                          }
        //                         completion:nil];
    }
}


-(void)hideImage:(UITapGestureRecognizer*)tapGest{
    UIView *backgroundView = tapGest.view;
    UIImageView *imageView = (UIImageView*)[tapGest.view viewWithTag:1];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame = oldHidFrame;
        backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
}

@end
