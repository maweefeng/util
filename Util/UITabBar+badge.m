//
//  UITabBar+badge.m
//  FamilyDoctor
//
//  Created by lijing on 2018/3/5.
//  Copyright © 2018年 WeDoctor Group. All rights reserved.
//

#import "UITabBar+badge.h"

#define TabbarItemNums 5.0    //tabbar的数量 如果是5个设置为5.0

@implementation UITabBar (badge)
//显示小红点
- (void)showBadgeOnItemIndex:(int)index{
    //移除之前的小红点
    [self removeBadgeOnItemIndex:index];
    
    //新建小红点
    UILabel *badgeView = [[UILabel alloc] init];
    [badgeView setTextAlignment:NSTextAlignmentCenter];
    [badgeView setTextColor:[UIColor whiteColor]];
    [badgeView setFont:[UIFont systemFontOfSize:12]];
    badgeView.tag = 888 + index;
    badgeView.clipsToBounds = YES;
    badgeView.layer.cornerRadius = 4;//圆形
    badgeView.backgroundColor = [UIColor redColor];//颜色：红色
//    [badgeView setText:@"99"];
    CGRect tabFrame = self.frame;
    
    //确定小红点的位置
    float percentX = (index +0.6) / TabbarItemNums;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    if(kTabBarHeight > 49) {
        y = ceilf(0.2 * tabFrame.size.height);
    }
    badgeView.frame = CGRectMake(x, y, 8, 8);
    [self addSubview:badgeView];
}

-(void)setBadgeNum:(NSInteger)index badgeNum:(NSInteger)badgeNum{
    for (UILabel *lbl in self.subviews) {
        CGSize size = [StrUtils getStrongWidth:[NSString stringWithFormat:@"%ld",badgeNum] atFont:[UIFont systemFontOfSize:12]];
        CGRect rect =  lbl.frame;
        if(size.width>=16){
//            rect.size.width = size.width + 10;
//            lbl.frame = rect;
        }
        if (lbl.tag == 888+index) {
            //badgeNum
//            [lbl setText:[NSString stringWithFormat:@"%ld",badgeNum]];
        }
    }
}

//隐藏小红点
- (void)hideBadgeOnItemIndex:(int)index{
    //移除小红点
    [self removeBadgeOnItemIndex:index];
}

//移除小红点
- (void)removeBadgeOnItemIndex:(int)index{
    //按照tag值进行移除
    for (UIView *subView in self.subviews) {
        if (subView.tag == 888+index) {
            [subView removeFromSuperview];
        }
    }
}
@end
