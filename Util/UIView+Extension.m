//
//  UIView+Extension.m
//  HealthChengDuTKT
//
//  Created by walker on 23/12/2016.
//  Copyright © 2017 WeDoctor Group. All rights reserved.
//

#import "UIView+Extension.h"
#import "ErrorView.h"
#import "WzConfig.h"

@implementation UIView (Extension)

- (void)emptyAllSubViewsAndLayers {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    [self setNeedsFocusUpdate];
}

- (UIView*)subViewOfClassName:(NSString*)className {
    for (UIView* subView in self.subviews) {
        if ([NSStringFromClass(subView.class) isEqualToString:className]) {
            return subView;
        }
        UIView* resultFound = [subView subViewOfClassName:className];
        if (resultFound) {
            return resultFound;
        }
    }
    return nil;
}

+ (UIView*)errorView:(CGRect)frame {
    ErrorView* view = [[ErrorView alloc] initWithFrame:frame];
    return view;
}

+ (UIView*)errorView:(CGRect)frame type:(NSInteger)type{
    ErrorView* view = [[ErrorView alloc] initWithFrame:frame];
    if (type==0) {
        [view setBackgroundColor:[UIColor clearColor]];
        [view.lblText setTextColor:COLOR_WZ_BTN_FONT_HUI];
        [view.imageView setHidden:YES];
    }
    return view;
}

+ (void)errorViewRemove:(UIView*)selfView{
    for (UIView *view in selfView.subviews) {
        if (view.tag == 100001&&[view isKindOfClass:[ErrorView class]]) {
            [view removeFromSuperview];
        }
    }
}

@end
