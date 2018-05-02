//
//  UIAlertController+Evan.m
//  HealthChengDuTKT
//
//  Created by Evan on 22/02/2017.
//  Copyright © 2017 WeDoctor Group. All rights reserved.
//

#import "UIAlertController+Evan.h"
#import "PMTabBarController.h"
#import "PMViewController.h"

@implementation UIAlertController(Evan)

- (void) alertTitle:(NSString*)alertTitle alertMessage:(NSString*)alertMessage leftCancelTitle:(NSString*)leftCancelTitle leftCancel:(void(^)(UIAlertAction * action))leftCancel rightTitle:(NSString*)rightTitle rightOK:(void(^)(UIAlertAction * action))rightOK{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:alertTitle message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
    if (rightTitle) {
        UIAlertAction *actionOK = [UIAlertAction actionWithTitle:rightTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            rightOK(action);
        }];
        [alertController addAction:actionOK];
    }
    if (leftCancelTitle) {
        UIAlertAction *actionCancel = [UIAlertAction actionWithTitle:leftCancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (leftCancel != nil) {
                leftCancel(action);
            }
            
        }];
        [alertController addAction:actionCancel ];
    }
    PMTabBarController *tabView = (PMTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *pmView = (UINavigationController*)tabView.viewControllers[tabView.selectedIndex];
    NSArray<PMViewController*> *arrayView = pmView.viewControllers;
    PMViewController *fristView = arrayView[[arrayView count]-1];
    [fristView presentViewController:alertController animated:YES completion:nil];
}

@end
