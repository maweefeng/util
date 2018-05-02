//
//  AppBridge.m
//  HealthJiangSu
//
//  Created by Evan on 4/26/16.
//  Copyright © 2017 WeDoctor Group. All rights reserved.
//

#import "AppBridge.h"
#import <UIKit/UIKit.h>
//#import "userContactViewController.h"

@implementation AppBridge

-(void)goHome:(NSString*) bankNo{
     NSLog(@"H5回调首页窗口");
    if([_delegate respondsToSelector:@selector(goHomeData:)]){
        [_delegate goHomeData:bankNo];
    }
}

-(void)goContact:(NSString*) bankNo{
    NSLog(@"H5回调联系人窗口");
    if([_delegate respondsToSelector:@selector(goContactData:)]){
        [_delegate goContactData:bankNo];
    }
}

-(void)goLogin{
    NSLog(@"H5回调强制退出窗口");
    if([_delegate respondsToSelector:@selector(goLoginData)]){
        [_delegate goLoginData];
    }
}

@end
