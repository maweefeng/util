//
//  UITabBar+badge.h
//  FamilyDoctor
//
//  Created by lijing on 2018/3/5.
//  Copyright © 2018年 WeDoctor Group. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (badge)
- (void)showBadgeOnItemIndex:(int)index;   //显示小红点
- (void)hideBadgeOnItemIndex:(int)index; //隐藏小红点
-(void)setBadgeNum:(NSInteger)index badgeNum:(NSInteger)badgeNum;
@end
