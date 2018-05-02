//
//  UINavigationBar+Extend.h
//  HomeDoctor
//
//  Created by walker on 20/11/2017.
//  Copyright © 2017 WeDoctor Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (Extend)

@property (nonatomic, strong) UIImage *originalBackgroundImage;
@property (nonatomic, strong) UIImage *originalShadowImage;

//@property (nonatomic, strong) UIImage *barBackgroundImage;
- (void)wz_setClearBackground;
- (void)wz_setBackgroundColor:(UIColor *)backgroundColor;
- (void)wz_reset;

@end
