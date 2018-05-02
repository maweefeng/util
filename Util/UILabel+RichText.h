//
//  UILabel+RichText.h
//  Label 富文本
//
//  Created by 高源 on 2017/4/27.
//  Copyright © 2017年 高源. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (RichText)

- (void)setText:(NSString *)text highlightText:(NSString *)highlightText highlightColor:(UIColor *)highlightColor  highlightTextFont:(UIFont *)highlightTextFont;

@end
