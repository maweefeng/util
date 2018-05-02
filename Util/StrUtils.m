//
//  StrUtils.m
//  PalmHospitalTongJi
//
//  Created by mardin partytime on 13-11-28.
//  Copyright (c) 2013年 lvxian. All rights reserved.
//

#import "StrUtils.h"
#import <CoreFoundation/CoreFoundation.h>
@implementation StrUtils

+ (NSString *)distance:(NSString *)aDis
{
    if (aDis == nil || [aDis isEqualToString:@""]) {
        return @"";
    }
    NSString *result;
    double dis_l = [aDis doubleValue];
    if (dis_l < 1000.0) {
        result = [[NSString alloc] initWithFormat:@"%@米",aDis];
    }else {
        int tmp =  (int)dis_l / 100;
        result = [[NSString alloc] initWithFormat:@"%d.%d千米",tmp/10, tmp%10];
    }
    
    return result;
}

+ (NSString *)timeParse:(NSString *)aStr
{
    if (aStr == nil || [aStr isEqualToString:@""]) {
        return aStr;
    }
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [format dateFromString:aStr];
    
    NSDateFormatter *newFormat = [[NSDateFormatter alloc] init];
    [newFormat setDateFormat:@"yyyy'年'MM'月'dd'日'"];
    NSString *newStr = [newFormat stringFromDate:date];
    return newStr;
}

+ (NSString *)timeNumToStr:(NSString *)aStr
{
    if (aStr == nil || [aStr isEqualToString:@""]) {
        return aStr;
    }
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy'-'MM'-'dd"];
    NSDate *date = [format dateFromString:aStr];
    
    NSDateFormatter *newFormat = [[NSDateFormatter alloc] init];
    [newFormat setDateFormat:@"yyyy'年'MM'月'dd'日'"];
    NSString *newStr = [newFormat stringFromDate:date];
    
    NSArray *dayArray = [[NSArray alloc] initWithObjects:  @"周日",@"周一", @"周二", @"周三", @"周四", @"周五", @"周六",nil];
    [newFormat setDateFormat:@"c"];
    NSString *day_l = (NSString *)[dayArray objectAtIndex:([[newFormat stringFromDate:date] integerValue]) - 1];
    
    NSString *resultStr = [[NSString alloc] initWithFormat:@"%@.%@", newStr, day_l];
    
    return resultStr;
}



+ (NSString *)timeNumToBubbleStr:(NSString *)aStr
{
    if (aStr == nil || [aStr isEqualToString:@""]) {
        return aStr;
    }
    
    NSArray *dayArray = [[NSArray alloc] initWithObjects:  @"周日",@"周一", @"周二", @"周三", @"周四", @"周五", @"周六",nil];
    //   NSDictionary *dayDic = [[NSDictionary alloc] initWithObjects:<#(NSArray *)#> forKeys:<#(NSArray *)#>];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy'-'MM'-'dd"];
    NSDate *date = [format dateFromString:aStr];
    
    
    
    NSDateFormatter *newFormat = [[NSDateFormatter alloc] init];
    
    [newFormat setDateFormat:@"c"];
    NSString *day_l = (NSString *)[dayArray objectAtIndex:([[newFormat stringFromDate:date] integerValue]) - 1];
    
    [newFormat setDateFormat:@"MM'/'dd"];
    NSString *newStr = [newFormat stringFromDate:date];
    NSString *resultStr = [[NSString alloc] initWithFormat:@"%@.%@",newStr, day_l];
    return resultStr;
}

+ (NSString *)priceParse:(NSNumber *)aNumber
{
    NSString *price = nil;
    if([aNumber intValue] != 0){
        float num = [aNumber floatValue];
        price = [NSString stringWithFormat:@"%.1f",(num / 100.0)];
    }
    return price;
    
}

+ (NSString *)commentTime:(NSString *)aStr
{
    NSArray *array_l = [aStr componentsSeparatedByString:@" "];
    if (array_l != nil && array_l.count > 0) {
        //    NSLog(@"time:%@", [array_l objectAtIndex:0]);
        return [array_l objectAtIndex:0];
    }
    return @"";
}

+(NSInteger)getAgeFromId:(NSString *)aStr
{
    if (aStr == nil && [aStr isEqualToString:@""]) {
        return 0;
    }
    
    NSString *ageStr_l;
    if (aStr.length == 15) {
        NSRange range_l = {6,2};
        NSString *time_l = [aStr substringWithRange:range_l];
        ageStr_l = [[NSString alloc] initWithFormat:@"19%@",time_l];
    }else if (aStr.length == 18) {
        NSRange range_l = {6,4};
        ageStr_l = [aStr substringWithRange:range_l];
    }
    
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy"];
    NSString *nowYear_l = [format stringFromDate:[NSDate date]];
    
    NSInteger age = [nowYear_l integerValue] - [ageStr_l integerValue];
    return age;
}

+ (NSInteger)getGenderFromId:(NSString *)aStr
{
    if (aStr == nil && [aStr isEqualToString:@""]) {
        return 0;
    }
    if (aStr.length == 15) {
        NSRange range_l = {14,1};
        NSString *bit_l = [aStr substringWithRange:range_l];
        if ( bit_l.integerValue % 2 == 0 ) {
            return 2;
        }else {
            return 1;
        }
    }else if (aStr.length == 18) {
        NSRange range_l = {16,1};
        NSString *bit_l = [aStr substringWithRange:range_l];
        if ( bit_l.integerValue % 2 == 0 ) {
            return 2;
        }else {
            return 1;
        }
    }
    return 0;
}

+ (BOOL)checkPwd:(NSString *)aStr
{
    if (aStr == nil) {
        return NO;
    }
    
    if (aStr.length >= 6 && aStr.length <= 16) {
        return YES;
    }else
        return NO;
}

+ (BOOL)checkMobileNumber:(NSString *)aStr
{
    if (aStr == nil) {
        return NO;
    }
    NSString * mobileFormat = @"^((13[0-9])|(15[^(4,\\D)])|(18[0-9]))\\d{8}$";
    
    NSPredicate *regexMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileFormat];
    if ([regexMobile evaluateWithObject:aStr]) {
        return YES;
    }else {
        return NO;
    }
}

+ (BOOL)isValidateIDCard:(NSString *)IDCard
{
    //    NSString *IDCardRegex15 = @"^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$";
    //    NSString *IDCardRegex18 = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}[\\d|x|X]$";
    //    NSPredicate *predicate15 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", IDCardRegex15];
    //    NSPredicate *predicate18 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", IDCardRegex18];
    //    return [predicate15 evaluateWithObject:IDCard] || [predicate18 evaluateWithObject:IDCard];
    return [self checkIdentity:IDCard];
}

/// <summary>
/// 验证身份证号码
/// </summary>
/// <param name="Id">身份证号码</param>
/// <returns>验证成功为YES，否则为NO</returns>
+ (BOOL)checkIdentity:(NSString *)cardId
{
    NSString* checkId = cardId;
    if(cardId.length == 15){
        checkId = [self convertCard15To18:cardId];
        return [self CheckIDCard18:checkId];
    }
    else if(cardId.length == 18){
        return [self CheckIDCard18:cardId];
    }
    return NO;
}


//验证18位身份证号码
+ (BOOL)CheckIDCard18:(NSString*)cardId
{
    NSArray* address =  @[@"11",@"22",@"35",@"44",@"53",@"12",@"23",@"36",@"45",
                          @"54",@"13",@"31",@"37",@"46",@"61",@"14",@"32",@"41",
                          @"50",@"62",@"15",@"33",@"42",@"51",@"63",@"21",@"34",
                          @"43",@"52",@"64",@"65",@"71",@"81",@"82",@"91"];
    for( int i = 0; i < [address count]; ++i){
        if ([[cardId substringWithRange:NSMakeRange(0, 2)] isEqualToString:address[i]]){
            break;//省份验证正确
        }
        else if (i == [address count] - 1){
            return false;//省份验证错误
        }
    }
    
    NSString* birth = [cardId substringWithRange:NSMakeRange(6, 8)];
    if(![self CheckDate:[birth substringWithRange:NSMakeRange(0, 4)]
                  month:[birth substringWithRange:NSMakeRange(4, 2)]
                    day:[birth substringWithRange:NSMakeRange(6, 2)]]){
        return NO;//生日验证错误
    }
    if(![self VarifyCode:cardId]){
        return NO;//最后一位校验错误
    }
    return YES;
}

//实现身份证的15位转18位
+ (NSString*)convertCard15To18:(NSString*)cardId
{
    if(cardId.length != 15){
        return @"";
    }
    int iS = 0;
    
    //加权因子常数
    NSArray* iW = @[@7, @9, @10, @5, @8, @4, @2, @1, @6, @3, @7, @9, @10, @5, @8, @4, @2];
    //校验码常数
    NSString* LastCode = @"10X98765432";
    //新身份证号
    NSMutableString* idNew = [[NSMutableString alloc] init];
    [idNew appendString:[cardId substringWithRange:NSMakeRange(0, 6)]];
    //填在第6位及第7位上填上‘1’，‘9’两个数字
    [idNew appendString:@"19"];
    [idNew appendString:[cardId substringWithRange:NSMakeRange(6, 9)]];
    for(int i = 0; i < idNew.length && i < [iW count]; ++i){
        iS += ([[idNew substringWithRange:NSMakeRange(i, 1)] intValue] * [[iW objectAtIndex:i] intValue]);
    }
    //取模运算，得到模值
    int iY = iS % 11;
    //从LastCode中取得以模为索引号的值，加到身份证的最后一位，即为新身份证号。
    [idNew appendString:[LastCode substringWithRange:NSMakeRange(iY, 1)]];
    return idNew;
}


+ (BOOL)CheckDate:(NSString*)year month:(NSString*)month day:(NSString*)day
{
    int iYear  = [year intValue];
    int iMonth = [month intValue];
    int iDay = [day intValue];
    NSMutableArray* Days = [NSMutableArray arrayWithObjects:@31,@28,@31,@30,@31,@30,@31,@31,@30,@31,@30,@31,nil];
    if(iMonth < 1 || iMonth>12)
        return   NO;
    
    BOOL b_IsLeapYear = NO;
    if(iYear % 4 == 0){
        b_IsLeapYear = YES;
        if(!(iYear % 100 == 0 && iYear % 400 == 0))
            b_IsLeapYear = NO;
    }
    
    if(b_IsLeapYear){
        [Days replaceObjectAtIndex:1 withObject:@29];
    }
    else{
        [Days replaceObjectAtIndex:1 withObject:@28];
    }
    
    if(iDay < 0 || iDay > [[Days objectAtIndex:iMonth - 1] intValue])
        return NO;
    
    return YES;
}

+ (BOOL)VarifyCode:(NSString*)cardId
{
    int iS = 0;
    //加权因子常数
    NSArray* iW = @[@7, @9, @10, @5, @8, @4, @2, @1, @6, @3, @7, @9, @10, @5, @8, @4, @2];
    //校验码常数
    NSString* LastCode = @"10X98765432";
    
    for(int i = 0;i < 17;i++){
        iS += ([[cardId substringWithRange:NSMakeRange(i, 1)] intValue] * [[iW objectAtIndex:i] intValue]);
    }
    
    //取模运算，得到模值
    int iY = iS % 11;
    if(iY < [LastCode length]){
        NSString* lastChar = [LastCode substringWithRange:NSMakeRange(iY, 1)];
        NSString *upperLast = [[cardId substringFromIndex:cardId.length - 1] uppercaseString] ;
        if([lastChar isEqualToString:upperLast]){
            return YES;
        }
    }
    return NO;
}

+ (BOOL)checkEmail:(NSString *)aStr
{
    if (aStr == nil) {
        return NO;
    }
    //    NSString *emailFormat = @"^\\s*\\w+(?:\\.{0,1}[\\w-]+)*@[a-zA-Z0-9]+(?:[-.][a-zA-Z0-9]+)*\\.[a-zA-Z]+\\s*$";
    NSString *emailFormat = @"\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*";
    NSPredicate *regexEmail = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailFormat];
    if ([regexEmail evaluateWithObject:aStr]) {
        return YES;
    }else {
        return NO;
    }
    
}

+ (BOOL)isEmpty:(NSString *)aStr
{
    if (aStr == nil || [aStr isEqual:[NSNull null]] || aStr.length == 0 || [aStr isEqualToString:@""]) {
        return YES;
    }
    
    return NO;
}

+ (NSString*)NilToEmptyString:(NSString*)str
{
    return str ? str : @"";
}

+ (NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    
    return html;
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

+ (NSString *)formatterDate:(NSString *)datetime dateform:(NSString*)dateform{
    double dateNumber = [[NSString stringWithFormat:@"%@", datetime] doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dateNumber];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:dateform];
    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    return [formatter stringFromDate:date];
}

+(NSMutableAttributedString*)updateStringColor:(NSString*)string begNum:(NSInteger)begNum endStrLength:(NSInteger)endNum color:(UIColor*)color{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:string];
    [str addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(begNum,endNum)];
    return str;
}

+(NSString*)formatterDate:(NSString*)datetime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[formatter dateFromString:datetime];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    
    if ([StrUtils isEmpty:currentDateStr]) {
        return datetime;
    }
    
    return currentDateStr;
}

+(NSString*)formatterDate:(NSString*)datetime formatterStyle:(NSString*)formatterStyle formatterNewStyle:(NSString*)formatterNewStyle
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:formatterStyle];
    NSDate *date=[formatter dateFromString:datetime];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatterNewStyle];
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    
    if ([StrUtils isEmpty:currentDateStr]) {
        return datetime;
    }
    
    return currentDateStr;
}

+(NSString*)formatterTime:(NSString*)datetime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:datetime];
    NSString *currentDateStr = [formatter stringFromDate:date];
    return currentDateStr;
}

+(NSString*)getTimeString{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%0.f", a];
    return timeString;
}

+(NSAttributedString *)getAttributeString:(NSString *)str withFontSize:(CGFloat)size andFontColor:(UIColor *)color {
    return [[NSAttributedString alloc]
            initWithString:str
            attributes:@{
                         NSForegroundColorAttributeName: color,
                         NSFontAttributeName: [UIFont systemFontOfSize:size]
                         }];
}

+(NSMutableAttributedString *)attributeString:(NSString *)mainText withFontSize:(CGFloat)fontsize fontColor:(UIColor *)fontColor andImage:(UIImage *)image imageOffset:(CGPoint)offset imagePositionLeft:(BOOL)isLeft{
    NSAttributedString *attrText = [[NSAttributedString alloc]
                                    initWithString:mainText
                                    attributes:@{
                                                 NSForegroundColorAttributeName: fontColor,
                                                 NSFontAttributeName: [UIFont systemFontOfSize:fontsize]
                                                 }];
    NSTextAttachment *imageAttatch = [NSTextAttachment new];
    imageAttatch.image = image;
    imageAttatch.bounds = CGRectMake(offset.x, offset.y, imageAttatch.image.size.width, imageAttatch.image.size.height);
    NSAttributedString *imageAttrStr = [NSAttributedString attributedStringWithAttachment:imageAttatch];
    NSMutableAttributedString *result = [NSMutableAttributedString new];
    [result appendAttributedString:attrText];
    if(isLeft) {
        [result insertAttributedString:imageAttrStr atIndex:0];
    }else {
        [result appendAttributedString:imageAttrStr];
    }
    return result;
}

+(CGRect)getStrongTextFontLength:(NSString*)str atFontSize:(NSInteger)fontSize atContainerWidth:(float)width{
    NSAttributedString *name = [[NSAttributedString alloc]initWithString:str attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}];
    CGRect nameRect = [name boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    return nameRect;
}

+(CGSize)getStrongWidth:(NSString*)str atFont:(UIFont*)font{
    CGSize size = [str sizeWithAttributes:@{NSFontAttributeName:font}];
    return size;
}

+(CGSize)getStrongTextFontLength:(NSString*)str atFontSize:(NSInteger)size{
    
    CGSize fontSize = [str sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    return fontSize;
}

+(void)NsLogError:(NSError*)error{
    if (error) {
        NSLog(@"错误:%@",error);
    }
}

+ (NSString *)timeFormatted:(long)totalSeconds
{
    
    long seconds = totalSeconds % 60;
    long minutes = (totalSeconds / 60) % 60;
    long hours = totalSeconds / 3600;
    
    if (hours == 0) {
        return [NSString stringWithFormat:@"%02ld分%02ld秒", minutes, seconds];
    }else{
        return [NSString stringWithFormat:@"%02ld小时%02ld分%02ld秒",hours, minutes, seconds];
    }
}

+(NSString *) compareCurrentTime:(NSDate*)compareDate
{
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
}

+ (NSString *) getUrlParams:(NSString *) url withParam:(NSString *)param{
    
    NSError *error;
    NSString *regTags=[[NSString alloc] initWithFormat:@"(^|&|\\?)+%@=+([^&]*)(&|$)",param];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regTags
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    
    // 执行匹配的过程
    NSArray *matches = [regex matchesInString:url
                                      options:0
                                        range:NSMakeRange(0, [url length])];
    for (NSTextCheckingResult *match in matches) {
        NSString *tagValue = [url substringWithRange:[match rangeAtIndex:2]];  // 分组2所对应的串
        return tagValue;
    }
    return nil;
}

+(NSString*)getNSDictionaryValue:(NSDictionary*)dict atFind:(NSString*)str{
    NSString* findStr = @"";
    for (id key in dict) {
        if ([key isEqualToString:str]) {
            findStr = [dict objectForKey:str];
        }
    }
    return findStr;
}

+(NSInteger)getSumOfDaysInMonth:(NSString*)year month:(NSString*)month{
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"]; // 年-月
    NSString * dateStr = [NSString stringWithFormat:@"%@-%@",year,month];
    NSDate * date = [formatter dateFromString:dateStr];
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit
                                   inUnit: NSMonthCalendarUnit
                                  forDate:date];
    return range.length;
}

+(NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    //    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期天", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"0", @"1", @"2", @"3", @"4", @"5", @"6", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/SuZhou"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

+(NSString*)weekdayStringTextFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期天", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    //    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"0", @"1", @"2", @"3", @"4", @"5", @"6", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/SuZhou"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

+(NSString *)birthdayStrFromIdentityCard:(NSString *)numberStr
{
    NSMutableString *result = [NSMutableString stringWithCapacity:0];
    NSString *year = nil;
    NSString *month = nil;
    BOOL isAllNumber = YES;
    NSString *day = nil;
    if([numberStr length]<18)
        return result;
    //**从第6位开始 截取8个数
    NSString *fontNumer = [numberStr substringWithRange:NSMakeRange(6, 8)];
    //**检测前12位否全都是数字;
    const char *str = [fontNumer UTF8String];
    const char *p = str;
    while (*p!='\0') {
        if(!(*p>='0'&&*p<='9'))
            isAllNumber = NO;
        p++;
    }
    if(!isAllNumber)
        return result;
    year = [NSString stringWithFormat:@"19%@",[numberStr substringWithRange:NSMakeRange(8, 2)]];
    month = [numberStr substringWithRange:NSMakeRange(10, 2)];
    day = [numberStr substringWithRange:NSMakeRange(12,2)];
    [result appendString:year];
    
    [result appendString:@"-"];
    
    [result appendString:month];
    
    [result appendString:@"-"];
    
    [result appendString:day];
    return result;
}

+(NSString *)getIdentityCardAge:(NSString *)numberStr
{
    NSDateFormatter *formatterTow = [[NSDateFormatter alloc]init];
    [formatterTow setDateFormat:@"yyyy-MM-dd"];
    NSDate *bsyDate = [formatterTow dateFromString:[self birthdayStrFromIdentityCard:numberStr]];
    NSTimeInterval dateDiff = [bsyDate timeIntervalSinceNow];
    int age = trunc(dateDiff/(60*60*24))/365;
    return [NSString stringWithFormat:@"%d",-age];
}

-(NSString *)getNDay:(NSInteger)n{
    
    NSDate*nowDate = [NSDate date];
    
    NSDate* theDate;
    
    if(n!=0){
        
        NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
        theDate = [nowDate initWithTimeIntervalSinceNow: oneDay*n ];//initWithTimeIntervalSinceNow是从现在往前后推的秒数
        
    }else{
        
        theDate = nowDate;
    }
    
    NSDateFormatter *date_formatter = [[NSDateFormatter alloc] init];
    [date_formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *the_date_str = [date_formatter stringFromDate:theDate];
    
    return the_date_str;
}

/*
 *根据身份证查性别
 * 1:男，0：女，2：身份证错误
 */
+ (NSInteger)getIdCardSex:(NSString*)idcard{
    if ([self checkIdentity:idcard]) {
        int sex1=[[idcard substringWithRange:NSMakeRange(16,1)] intValue];
        if(sex1%2!=0)
        {
            return 1;//男
        }
        else
        {
            return 0;
        }
    }else{
        return 2;//错误的身份证号
    }
}

+(NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(NSInteger)month
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setMonth:month];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:0];
    return mDate;
}

+(NSString*)getCurrentTimes{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    return currentTimeString;
}

+(NSDate*)getCurrentDate{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    return datenow;
}

+(NSString *)getNowTimeTimestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    
    return timeSp;
    
}



+(NSMutableArray*)arrStringSort:(NSString*)firstLetter arrString:(NSMutableArray*)arrString sortKey:(NSString*)sortKey{
    for (NSObject* model in arrString) {
        NSMutableString *ms = [[NSMutableString alloc] initWithString:[model valueForKey:sortKey]];
        if (CFStringTransform((__bridge CFMutableStringRef)ms, NULL, kCFStringTransformMandarinLatin, NO)) {
            if (CFStringTransform((__bridge CFMutableStringRef)ms, NULL, kCFStringTransformStripDiacritics, NO)) {
                NSString *bigStr = [ms uppercaseString];
                NSString *cha = [bigStr substringToIndex:1];
                [model setValue:cha forKey:firstLetter];
            }
        }
    }
    NSSortDescriptor *sortDes = [NSSortDescriptor sortDescriptorWithKey:firstLetter ascending:YES];
    [arrString sortUsingDescriptors:[NSMutableArray arrayWithObject:sortDes]];
    return arrString;
}

+(NSString *)checkMesaageTime:(NSDate*)mesaageDate{
//    [self getTimeString];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDateFormatter *formatterWithHours = [[NSDateFormatter alloc] init];
    [formatterWithHours setDateFormat:@"HH:mm"];
    NSDateFormatter *formatterWithTime = [[NSDateFormatter alloc] init];
    [formatterWithTime setDateFormat:@"YYYY-MM-dd"];
    NSString* mesaageTime = @"";
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval time = [dat timeIntervalSinceDate:mesaageDate];
    if (time<=180) {
        mesaageTime = @"刚刚";
    }else if(time>180&&[[formatter stringFromDate:dat] isEqualToString:[formatter stringFromDate:mesaageDate]]){
        mesaageTime = [formatterWithHours stringFromDate:mesaageDate];
    }else{
        mesaageTime = [formatterWithTime stringFromDate:mesaageDate];
    }
    return mesaageTime;
}

+(NSString *)checkMesaageInfoTime:(NSDate*)mesaageDate  type:(NSInteger)type{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDateFormatter *formatterWithHours = [[NSDateFormatter alloc] init];
    [formatterWithHours setDateFormat:@"HH:mm"];
    NSDateFormatter *formatterWithTime = [[NSDateFormatter alloc] init];
    [formatterWithTime setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSString* mesaageTime = @"";
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval time = [dat timeIntervalSinceDate:mesaageDate];
    if(time<=300){
        if (type==0) {
             mesaageTime = [formatterWithHours stringFromDate:mesaageDate];
        }else{
            mesaageTime = @"";
        }
    }
    else if([[formatter stringFromDate:dat] isEqualToString:[formatter stringFromDate:mesaageDate]]){
        mesaageTime = [formatterWithHours stringFromDate:mesaageDate];
    }else{
        mesaageTime = [formatterWithTime stringFromDate:mesaageDate];
    }
    return mesaageTime;
}

///验证是否是纯中文字符串
+ (BOOL)isChinese:(NSString *)userName
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:userName];
}


@end
