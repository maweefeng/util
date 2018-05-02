//
//  viewControllerUtils.m
//  HealthChengDuTKT
//
//  Created by lijing on 2016/12/27.
//  Copyright © 2017 WeDoctor Group. All rights reserved.
//

#import "viewControllerUtils.h"
//#import "WenZhenViewController.h"

@implementation viewControllerUtils
+ (UIViewController*)viewController:(id)atSelf{
    for (UIView* next = [atSelf superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

+ (id)naviFindControll:(UINavigationController*)navi atFindControll:(Class)cv{
    for (UIViewController* fv in navi.viewControllers) {
        if ([fv isKindOfClass:[cv class]]){
            return fv;
        }
    }
    return nil;
}

+ (id)naviAllFindControll:(UITabBarController*)tabr atFindControll:(Class)cv{
    for (UINavigationController* navi in tabr.viewControllers) {
        for (UIViewController* fc in navi.viewControllers) {
            NSLog(@"找到:%@",[fc class]);
            if ([fc isKindOfClass:[cv class]]){
                return fc;
            }
        }
    }
    return nil;
}

+ (UIViewController*)currentViewController{
    UIViewController* vc = [self rootViewController];
    
    while (1) {
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
        
    }
    
    return vc;
}

+ (UIViewController *)rootViewController{
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    return window.rootViewController;
}
@end
