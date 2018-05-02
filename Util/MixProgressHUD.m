//
//  MixProgressHUD.m
//  PalmHospitalTongJi
//
//  Created by leon on 13-11-28.
//  Copyright (c) 2013年 lvxian. All rights reserved.
//

#import "MixProgressHUD.h"

#define HUD_IMAGE_SUCCESS		[UIImage imageNamed:@"success-white.png"]
#define HUD_IMAGE_ERROR			[UIImage imageNamed:@"error-white.png"]

static MBProgressHUD* g_mbHud;
static UIWindow* g_window;

@interface MixProgressHUD()
+ (UIWindow*) window;

+ (MBProgressHUD*)mbHud;

@end

@implementation MixProgressHUD

+ (UIWindow*) window;
{
    if(g_window == nil){
        g_window = [[UIApplication sharedApplication] keyWindow];
    }
    return g_window;
}

+ (MBProgressHUD*)mbHud
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        g_mbHud = [[MBProgressHUD alloc] initWithView:[MixProgressHUD window]];
    });
    return g_mbHud;
}

+ (void)dismiss
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if(isIos7){
            [ProgressHUD dismiss];
        }else{
            [[MixProgressHUD mbHud] hideAnimated:YES];
            [[MixProgressHUD mbHud] removeFromSuperview];
        }
//        [SVProgressHUD dismiss];
    });
}

+ (void)show{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (isIos7) {
            [ProgressHUD show:@""];
        }else{
            [[MixProgressHUD mbHud] setCustomView:nil];
            [[MixProgressHUD mbHud] setMode:MBProgressHUDModeIndeterminate];
            [[MixProgressHUD mbHud].label setText:@""];
            [[MixProgressHUD mbHud].detailsLabel setText:@""];
            [[MixProgressHUD window] addSubview:[MixProgressHUD mbHud]];
            [[MixProgressHUD mbHud] showAnimated:YES];
            //    [SVProgressHUD show];
            //        [[MixProgressHUD mbHud] hide:YES afterDelay:10.0];
        }
    });
}

+ (void)show:(NSString *)status
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if(isIos7){
            [ProgressHUD show:status];
        }else{
            [[MixProgressHUD mbHud] setCustomView:nil];
            [[MixProgressHUD mbHud] setMode:MBProgressHUDModeIndeterminate];
            [[MixProgressHUD mbHud].label setText:@""];
            [[MixProgressHUD mbHud].detailsLabel setText:status];
            [[MixProgressHUD window] addSubview:[MixProgressHUD mbHud]];
            [[MixProgressHUD mbHud] showAnimated:YES];
        }
        //    [SVProgressHUD showWithStatus:status maskType:SVProgressHUDMaskTypeNone];
    });
}

+ (void)showSuccess:(NSString *)status
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if(status && ![status isEqualToString:@""]){
            if(isIos7){
                [ProgressHUD showSuccess:status];
            }else{
                [[MixProgressHUD mbHud] setCustomView:[[UIImageView alloc] initWithImage:HUD_IMAGE_SUCCESS]];
                [[MixProgressHUD mbHud] setMode:MBProgressHUDModeCustomView];
                [[MixProgressHUD mbHud].label setText:@""];
                [[MixProgressHUD mbHud].detailsLabel setText:status];
                [[MixProgressHUD window] addSubview:[MixProgressHUD mbHud]];
                [[MixProgressHUD mbHud] showAnimated:YES];
                [[MixProgressHUD mbHud] hideAnimated:YES afterDelay:2.0];
            }
        }
        //    [SVProgressHUD showSuccessWithStatus:status];
    });
}

+ (void)showWzDialogue:(NSString *)status
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if(status && ![status isEqualToString:@""]){
            if(isIos7){
                [ProgressHUD showSuccess:status];
            }else{
                [[MixProgressHUD mbHud] setCustomView:[[UIImageView alloc] initWithImage:HUD_IMAGE_SUCCESS]];
                [[MixProgressHUD mbHud] setMode:MBProgressHUDModeCustomView];
                [[MixProgressHUD mbHud].label setText:@""];
                [[MixProgressHUD mbHud].detailsLabel setText:status];
                [[MixProgressHUD window] addSubview:[MixProgressHUD mbHud]];
                [[MixProgressHUD mbHud] showAnimated:YES];
                [[MixProgressHUD mbHud] hideAnimated:YES afterDelay:2.0];
            }
        }
        //    [SVProgressHUD showSuccessWithStatus:status];
    });
}

+ (void)showErrorinfo:(NSError *)strMsg
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if(!strMsg) return [self showError:@"有错误发生"];
        NSString *status = [[strMsg userInfo] objectForKey:@"NSLocalizedDescription"];
        [self showError:status];
    });
}


+ (void)showError:(NSString *)status
{
    NSLog(@"Error: %@", status);
    dispatch_async(dispatch_get_main_queue(), ^{
        if(status && ![status isEqualToString:@""]){
            if(isIos7){
                [ProgressHUD showError:status];
            }else{
                [[MixProgressHUD mbHud] setCustomView:[[UIImageView alloc] initWithImage:HUD_IMAGE_ERROR]];
                [[MixProgressHUD mbHud] setMode:MBProgressHUDModeCustomView];
                [[MixProgressHUD mbHud].label setText:@""];
                [[MixProgressHUD mbHud].detailsLabel setText:status];
                [[MixProgressHUD window] addSubview:[MixProgressHUD mbHud]];
                [[MixProgressHUD mbHud] showAnimated:YES];
                CGFloat delay = 3.0;
#ifdef DEBUG
                delay = 2.0;
#endif
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [[MixProgressHUD mbHud] hideAnimated:YES];
//                    [MixProgressHUD dismiss];
                    
                });
//                [[MixProgressHUD mbHud] hideAnimated:YES afterDelay:delay];
            }
        }else{
            [MixProgressHUD dismiss];
        }
    });
}

+ (void)showSuccess:(NSString *)status dissmissDelay:(CGFloat)delay
{
    [MixProgressHUD showSuccess:status];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [MixProgressHUD dismiss];
    });
}

+ (void)showError:(NSString *)status dissmissDelay:(CGFloat)delay
{
    [MixProgressHUD showError:status];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [MixProgressHUD dismiss];
    });
}
@end
