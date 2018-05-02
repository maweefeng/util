//
//  NSString+pinyin.h
//  MenuSelectView
//
//  Created by Weefeng Ma on 2018/1/12.
//  Copyright © 2018年 maweefeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (pinyin)


/**
 返回文字的拼音

 @param chinese 文字
 @return 文字转化成拼音
 */
+ (NSString *)transform:(NSString *)chinese;

/**
 返回文字的拼音的首字母

 @param chinese 文字
 @return 拼音的首字母
 */
+ (NSString *)getFirstLetter:(NSString *)chinese;
@end
