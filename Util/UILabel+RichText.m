//
//  UILabel+RichText.m
//  Label 富文本
//
//  Created by 高源 on 2017/4/27.
//  Copyright © 2017年 高源. All rights reserved.
//

#import "UILabel+RichText.h"

@implementation UILabel (RichText)

- (void)setText:(NSString *)text highlightText:(NSString *)highlightText highlightColor:(UIColor *)highlightColor  highlightTextFont:(UIFont *)highlightTextFont {
    self.text = text;
    if ([self respondsToSelector:@selector(setAttributedText:)]) {
        NSDictionary *attribs = @{
                                  NSForegroundColorAttributeName: self.textColor,
                                  NSFontAttributeName: self.font
                                  };
        NSMutableAttributedString *attributedText =
        [[NSMutableAttributedString alloc] initWithString:text
                                               attributes:attribs];
        NSRange redTextRange = [text rangeOfString:highlightText];//默认是从坐往右找高亮部分的 string
        [attributedText setAttributes:@{NSForegroundColorAttributeName:highlightColor,NSFontAttributeName: highlightTextFont}
                                range:redTextRange];
        
        self.attributedText = attributedText;
    }
}

@end
