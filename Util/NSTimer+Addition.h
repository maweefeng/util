//
//  NSTimer+Addition.h
//  UIScrollViewHomework
//
//  Created by GJ1991 on 16/1/30.
//  Copyright © Gidoor All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Addition)

/**
 *  让NSTimer暂停
 */
- (void)pauseTimer;

/**
 *  重新启动
 */
- (void)resumeTimer;

/**
 *  让NSTimer几秒之后重新启动
 *
 *  @param interval 间隔的时间
 */
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;


@end
