//
//  UILabel+Extend.m
//  HealthJiangSu
//
//  Created by 实习生 on 16/8/8.
//  Copyright © 2017 WeDoctor Group. All rights reserved.
//

#import "UILabel+Extend.h"

@implementation UILabel (Extend)
-(CGFloat)GetFontHeight{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    CGSize size =  [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    return size.height;
}
-(CGFloat)GetFontWidth{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    CGSize size =  [self.text boundingRectWithSize:CGSizeMake(MAXFLOAT, self.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    return size.width;

}
//按钮样式1
- (UILabel*) setStyleOne{
    [self setBackgroundColor:LCFromRGB(220,220,220)];
    return self;
}
//样式2白字透明低
- (UILabel*) setStyleTow{
    [self setBackgroundColor:[UIColor clearColor]];
    [self setTextColor:[UIColor whiteColor]];
    return self;
}
@end
