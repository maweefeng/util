//
//  NSString+pinyin.m
//  MenuSelectView
//
//  Created by Weefeng Ma on 2018/1/12.
//  Copyright © 2018年 maweefeng. All rights reserved.
//

#import "NSString+pinyin.h"

@implementation NSString (pinyin)
+ (NSString *)transform:(NSString *)chinese
{
    NSMutableString *pinyin = [chinese mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
//    NSLog(@"%@", pinyin);
    return [pinyin uppercaseString];
}
+ (NSString *)getFirstLetter:(NSString *)chinese
{
    NSMutableString *pinyin = [chinese mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
//    NSLog(@"%@", pinyin);
    
    return [[pinyin substringToIndex:1] uppercaseString];
}

@end
