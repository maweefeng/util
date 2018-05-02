//
//  PHAlertView.h
//  PalmHospital
//
//  Created by leon on 14-1-12.
//  Copyright (c) 2014年 lvxian. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "SIAlertView.h"

typedef void(^leftActionBlock)();
typedef void(^rightActionBlock)();


@interface PHAlertView : NSObject

+ (void)showAlertWithTitle:(NSString*)title
                   message:(NSString*)message
                leftButton:(NSString*)leftButton
               rightButton:(NSString*)rightButton
                leftAction:(leftActionBlock)leftActionBlock
               rightAction:(rightActionBlock)rightActionBlock;

@end
