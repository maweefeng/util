//
//  UITableViewUtils.m
//  HealthChengDuTKT
//
//  Created by lijing on 2017/1/13.
//  Copyright © 2017 WeDoctor Group.. All rights reserved.
//

#import "UITableViewUtils.h"

@implementation UITableViewUtils
+(void)scrollToRow:(UITableView*)tableView atToRow:(NSInteger)row atToSection:(NSInteger)section{
    [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section] atScrollPosition:UITableViewScrollPositionTop animated:NO];
}
@end
