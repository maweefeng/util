//
//  UIButtionUtils.m
//  HealthChengDuTKT
//
//  Created by lijing on 2016/12/15.
//  Copyright © 2017 WeDoctor Group. All rights reserved.
//

#import "UIButtionUtils.h"

@implementation UIButtionUtils

+(void)setAllButtonSelect:(UIView*)view{
    for (UIButton* btn in view.subviews)
    {
        if ([btn isKindOfClass:[UIButton class]]) {
            [btn setSelected:NO];
        }
    }
}

+(void)setButtonSelect:(UIButton*)button atView:(UIView*)view{
    for (UIButton* btn in view.subviews)
    {
        if ([btn isKindOfClass:[UIButton class]]) {
            if (btn == button) {
                [button setSelected:YES];
            }
            else
            {
                [btn setSelected:NO];
            }
        }
    }
}

@end
