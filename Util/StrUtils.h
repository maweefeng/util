//
//  StrUtils.h
//  PalmHospitalTongJi
//
//  Created by mardin partytime on 13-11-28.
//  Copyright (c) 2013年 lvxian. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "StringUtils.h"

@interface StrUtils : NSObject

+ (NSString *)distance:(NSString *)aDis;

+ (NSString *)timeParse:(NSString *)aStr;

+ (NSString *)timeNumToStr:(NSString *)aStr;

+ (NSString *)timeNumToBubbleStr:(NSString *)aStr;

+ (NSString *)priceParse:(NSNumber *)aNumber;

+ (NSString *)commentTime:(NSString *)aStr;

+(NSInteger)getAgeFromId:(NSString *)aStr;

+ (NSInteger)getGenderFromId:(NSString *)aStr;

+ (BOOL)checkPwd:(NSString *)aStr;

+ (BOOL)checkMobileNumber:(NSString *)aStr;

+ (BOOL)checkIdentity:(NSString *)aStr;

+ (BOOL)checkEmail:(NSString *)aStr;

+ (BOOL)isEmpty:(NSString *)aStr;

+ (NSString*)NilToEmptyString:(NSString*)str;

+ (NSString *)filterHTML:(NSString *)html;

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

+ (NSString *)formatterDate:(NSString *)datetime dateform:(NSString*)dateform;

+(NSString*)formatterTime:(NSString*)datetime;
+(NSString*)formatterDate:(NSString*)datetime formatterStyle:(NSString*)formatterStyle formatterNewStyle:(NSString*)formatterNewStyle;

+(NSMutableAttributedString*)updateStringColor:(NSString*)string begNum:(NSInteger)begNum endStrLength:(NSInteger)endStrLength color:(UIColor*)color;
+(NSString*)formatterDate:(NSString*)datetime;

+(NSString*)getTimeString;

+(NSAttributedString *)getAttributeString:(NSString *)str withFontSize:(CGFloat)size andFontColor:(UIColor *)color;
+(NSMutableAttributedString *)attributeString:(NSString *)mainText withFontSize:(CGFloat)fontsize fontColor:(UIColor *)fontColor andImage:(UIImage *)image imageOffset:(CGPoint)offset imagePositionLeft:(BOOL)isLeft;
+(CGRect)getStrongTextFontLength:(NSString*)str atFontSize:(NSInteger)fontSize atContainerWidth:(float)width;
+(CGSize)getStrongWidth:(NSString*)str atFont:(UIFont*)font;
+(CGSize)getStrongTextFontLength:(NSString*)str atFontSize:(NSInteger)size;
+(void)NsLogError:(NSError*)error;
+ (NSString *)timeFormatted:(long)totalSeconds;
+(NSString *) compareCurrentTime:(NSDate*) compareDate;
+ (NSString *) getUrlParams:(NSString *) url withParam:(NSString *)param;
+(NSString*)getNSDictionaryValue:(NSDictionary*)dict atFind:(NSString*)str;
+(NSInteger)getSumOfDaysInMonth:(NSString*)year month:(NSString*)month;
+(NSString*)weekdayStringFromDate:(NSDate*)inputDate;
+(NSString*)weekdayStringTextFromDate:(NSDate*)inputDate;
+(NSString *)birthdayStrFromIdentityCard:(NSString *)numberStr;
+(NSString *)getIdentityCardAge:(NSString *)numberStr;
-(NSString *)getNDay:(NSInteger)n;

///
///根据身份证查性别
///1:男，0：女，2：身份证错误
///
+ (NSInteger)getIdCardSex:(NSString*)idcard;

//获取某个日期 前几个月  后几个月的日期  正数后月 负数前月
+(NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(NSInteger)month;

//获取当前日期
+(NSString*)getCurrentTimes;
+(NSDate*)getCurrentDate;
+(NSString *)getNowTimeTimestamp;
//自定义对象 按字母排序
+(NSMutableArray*)arrStringSort:(NSString*)firstLetter arrString:(NSMutableArray*)arrString sortKey:(NSString*)sortKey;
+(NSString *)checkMesaageTime:(NSDate*)mesaageDate;
+(NSString *)checkMesaageInfoTime:(NSDate*)mesaageDate type:(NSInteger)type;

///验证是否是纯中文字符串
+ (BOOL)isChinese:(NSString *)userName;
@end
