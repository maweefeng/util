//
//  viewControllerUtils.h
//  HealthChengDuTKT
//
//  Created by lijing on 2016/12/27.
//  Copyright © 2017 WeDoctor Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface viewControllerUtils : NSObject
+ (UIViewController*)viewController:(id)atSelf;
+ (id)naviFindControll:(id)atSelf atFindControll:(Class)cv;
+ (id)naviAllFindControll:(UITabBarController*)tabr atFindControll:(Class)cv;
//找到顶层窗体viewController
+ (UIViewController*)currentViewController;
@end
