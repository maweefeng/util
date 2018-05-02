//
//  PHAlertView.m
//  PalmHospital
//
//  Created by leon on 14-1-12.
//  Copyright (c) 2014年 lvxian. All rights reserved.
//

#import "PHAlertView.h"


@implementation PHAlertView
+ (void)showAlertWithTitle:(NSString*)title
                   message:(NSString*)message
                leftButton:(NSString*)leftButton
               rightButton:(NSString*)rightButton
                leftAction:(leftActionBlock)leftActionBlock
               rightAction:(rightActionBlock)rightActionBlock
{
//    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:title andMessage:message];
//    if(leftButton){
//        [alertView addButtonWithTitle:leftButton
//                                 type:SIAlertViewButtonTypeCancel
//                              handler:^(SIAlertView *alertView) {
//                                  if(leftActionBlock){
//                                      [alertView dismissAnimated:YES];
//                                      leftActionBlock();
//                                  }
//                              }];
//    }
//
//    if(rightButton){
//        [alertView addButtonWithTitle:rightButton
//                                 type:SIAlertViewButtonTypeDefault
//                              handler:^(SIAlertView *alertView) {
//                                  if(rightActionBlock){
//                                      rightActionBlock();
//                                  }
//                              }];
//    }
//    alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
//    [alertView show];
}

@end
