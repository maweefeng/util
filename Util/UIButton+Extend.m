//
//  UIButton+Extend.m
//  HealthLongJiang
//
//  Created by 实习生 on 16/10/10.
//  Copyright © 2017 WeDoctor Group. All rights reserved.
//

#import "UIButton+Extend.h"
@implementation UIButton (Extend)
//按钮样式1
- (UIButton*) setStyleOne{
    [self setBackgroundColor:COLOR_BLUE];
    self.layer.cornerRadius = 3.0;
    self.titleLabel.font = [UIFont systemFontOfSize: 13.0];
    return self;
}
//按钮样式2
- (UIButton*) setStyleTow{
    [self setTitleColor:COLOR_Blue forState:UIControlStateNormal];
    [self setBackgroundColor:[UIColor whiteColor]];
    self.titleLabel.font = [UIFont systemFontOfSize: 13.0];
    return self;
}
@end
