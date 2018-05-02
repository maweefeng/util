//
//  UITextField+Extend.h
//  PalmHospitalTongJi
//
//  Created by Stephen on 11/13/13.
//  Copyright (c) 2013 lvxian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Extend)
- (void)setBackgroundViewWithBorderColor:(UIColor *)borderColor leftSpace:(float)lSpace rightSpace:(float)rSpace;
- (void)setLogicNextField:(UITextField*)theNextField;
- (void)setLogicEndField;
- (UITextField*) setStyleOne;
@end
