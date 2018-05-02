//
//  NSString+Extend.h
//  TsyScgl
//
//  Created by walker on 14/7/13.
//  Copyright (c) 2014 tsy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define FileHashDefaultChunkSizeForReadingData 1024*8

@interface NSString (Extend)

-(BOOL)isEmptyOrWhitespace;
-(NSString *)replace:(NSString *)pattern with:(NSString *)newStr; //正则替换
- (int)convertToInt;//判断字符串的长度
-(CGSize)getSizeWithFontSize:(CGFloat)fontSize andWidth:(CGFloat)width;
-(CGSize)getSizeWithFontSize:(CGFloat)fontSize;
#pragma mark - Encodeing
- (NSString *)URLEncodedString;
- (NSString*)URLDecodedString;

- (NSString*)MD5;
/**
 *  获取文件的MD5
 *
 *  @param path 文件路径
 *
 *  @return 返回文件的MD5
 */
+(NSString*)getFileMD5WithPath:(NSString*)path;
@end
