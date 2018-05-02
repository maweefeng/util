//
//  UIAlertController+Evan.h
//  HealthChengDuTKT
//
//  Created by Evan on 22/02/2017.
//  Copyright © 2017 WeDoctor Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController(Evan)

- (void) alertTitle:(NSString*)alertTitle alertMessage:(NSString*)alertMessage leftCancelTitle:(NSString*)leftCancelTitle leftCancel:(void(^)(UIAlertAction * action))leftCancel rightTitle:(NSString*)rightTitle rightOK:(void(^)(UIAlertAction * action))rightOK;

@end
