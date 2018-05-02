//
//  UITextField+Extend.m
//  PalmHospitalTongJi
//
//  Created by Stephen on 11/13/13.
//  Copyright (c) 2013 lvxian. All rights reserved.
//

#define BORDERWIDTH     1.0
#define CORNERRADIUS    3.0

#import "UITextField+Extend.h"
#import <objc/runtime.h>
@interface UITextField (Logic)
@property (nonatomic, assign) UITextField* nextField;
@end

@implementation UITextField (Extend)
static char* kDHNextField = "nextField";

- (UITextField*) setStyleOne{
    [self setClearButtonMode:UITextFieldViewModeWhileEditing];
    [self setBackgroundColor:[UIColor clearColor]];
    [self setFont:[UIFont systemFontOfSize:14.0]];
    self.layer.cornerRadius = 3.0;
    self.layer.borderColor= COLOR_BAISE.CGColor;
    self.layer.borderWidth= 0.5f;
    return self;
}

- (void)setBackgroundViewWithBorderColor:(UIColor *)borderColor leftSpace:(float)lSpace rightSpace:(float)rSpace;
{
    CGRect originFrame  = self.frame;
    UIView *bgView      = [[UIView alloc] initWithFrame:originFrame];
    [bgView setBackgroundColor:[UIColor whiteColor]];
    [bgView.layer setBorderWidth:BORDERWIDTH];
    [bgView.layer setBorderColor:borderColor.CGColor];
    [bgView.layer setCornerRadius:CORNERRADIUS];
    originFrame.origin.x    = originFrame.origin.x+lSpace;
    originFrame.size.width  = originFrame.size.width -lSpace-rSpace;
    if ([[[UIDevice currentDevice] systemVersion] intValue] < 7) {
        originFrame.origin.y    = originFrame.origin.y +(originFrame.size.height- self.font.pointSize-4)/2.0;
        originFrame.size.height = self.font.pointSize+4;
    }
    self.frame = originFrame;
    
    [[self superview] insertSubview:bgView belowSubview:self];
}


- (void)setNextField:(UITextField *)nextField
{
    objc_setAssociatedObject(self, &kDHNextField, nextField, OBJC_ASSOCIATION_ASSIGN);
}
- (UITextField *)nextField
{
    return objc_getAssociatedObject(self, &kDHNextField);
}

- (void)setLogicNextField:(UITextField*)theNextField
{
    self.nextField = theNextField;
    [self setReturnKeyType:UIReturnKeyNext];
    [self addTarget:self action:@selector(textFieldLogicNext)
   forControlEvents:UIControlEventEditingDidEndOnExit];
}
- (void)setLogicEndField
{
    [self setReturnKeyType:UIReturnKeyDone];
    [self addTarget:self action:@selector(textFieldLogicDone)
   forControlEvents:UIControlEventEditingDidEndOnExit];
}
- (void)textFieldLogicNext
{
    if (self.nextField) {
        [self.nextField becomeFirstResponder];
    }else {
        [self resignFirstResponder];
    }
}
- (void)textFieldLogicDone
{
    [self resignFirstResponder];
}
@end
