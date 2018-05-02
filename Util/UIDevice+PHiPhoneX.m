//
//  UIDevice+PHiPhoneX.m
//  PalmHospitalTongJi
//
//  Created by Weefeng Ma on 2017/12/22.
//  Copyright © 2017年 lvxian. All rights reserved.
//

#import "UIDevice+PHiPhoneX.h"

@implementation UIDevice (PHiPhoneX)
-(BOOL)isiPhoneX{
    if ([UIScreen mainScreen].bounds.size.height == 812) {
        return YES;
    }
    return NO;
}
@end
