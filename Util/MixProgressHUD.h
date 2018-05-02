//
//  MixProgressHUD.h
//  PalmHospitalTongJi
//
//  Created by leon on 13-11-28.
//  Copyright (c) 2013年 lvxian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "ProgressHUD.h"
//#import "CommonDataInit.h"

@interface MixProgressHUD : NSObject

+ (void)dismiss;
+ (void)show;
+ (void)show:(NSString *)status;
+ (void)showSuccess:(NSString *)status;
+ (void)showErrorinfo:(NSError *)strMsg;
+ (void)showError:(NSString *)status;
+ (void)showSuccess:(NSString *)status dissmissDelay:(CGFloat)delay;
+ (void)showError:(NSString *)status dissmissDelay:(CGFloat)delay;
+ (void)showWzDialogue:(NSString *)status;

@end
