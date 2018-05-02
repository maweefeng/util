//
//  StringUtils.m
//  PalmHospitalTongJi
//
//  Created by leon on 13-11-27.
//  Copyright (c) 2013年 lvxian. All rights reserved.
//

#import "StringUtils.h"

static NSDateFormatter* g_dateFormatter;

@interface StringUtils()
+ (BOOL)CheckIDCard18:(NSString*)cardId;

+ (NSString*)convertCard15To18:(NSString*)cardId;

+ (BOOL)CheckDate:(NSString*)year month:(NSString*)month day:(NSString*)day;

+ (BOOL)VarifyCode:(NSString*)cardId;

@end


@implementation StringUtils
+ (NSInteger)getAgeFromId:(NSString *)aStr
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


    if(g_dateFormatter == nil){
        g_dateFormatter = [[NSDateFormatter alloc] init];
    }
    [g_dateFormatter setDateFormat:@"yyyy"];
    NSString *nowYear_l = [g_dateFormatter stringFromDate:[NSDate date]];

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

+ (BOOL)isValidateMobile:(NSString *)mobile
{
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

+ (BOOL)isValidateIDCard:(NSString *)IDCard
{
//    NSString *IDCardRegex15 = @"^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$";
//    NSString *IDCardRegex18 = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}[\\d|x|X]$";
//    NSPredicate *predicate15 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", IDCardRegex15];
//    NSPredicate *predicate18 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", IDCardRegex18];
//    return [predicate15 evaluateWithObject:IDCard] || [predicate18 evaluateWithObject:IDCard];
    return [StringUtils CheckIDCard:IDCard];
}

/// <summary>
/// 验证身份证号码
/// </summary>
/// <param name="Id">身份证号码</param>
/// <returns>验证成功为YES，否则为NO</returns>
+ (BOOL)CheckIDCard:(NSString*)cardId
{
    NSString* checkId = cardId;
    if(cardId!=nil)
    {
        cardId=cardId.uppercaseString;
        checkId=cardId.uppercaseString;
    }else{
        NO;
    }
    if(cardId.length == 15){
        checkId = [StringUtils convertCard15To18:cardId];
        return [StringUtils CheckIDCard18:checkId];
    }
    else if(cardId.length == 18){
        return [StringUtils CheckIDCard18:cardId];
    }
    return NO;
}

+ (BOOL)CheckIDCard18:(NSString*)cardId
{
    if (cardId.length != 18) {
        return  NO;
    }
    NSArray* codeArray = [NSArray arrayWithObjects:@"7",@"9",@"10",@"5",@"8",@"4",@"2",@"1",@"6",@"3",@"7",@"9",@"10",@"5",@"8",@"4",@"2", nil];
    NSDictionary* checkCodeDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1",@"0",@"X",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2", nil]  forKeys:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil]];
    
    NSScanner* scan = [NSScanner scannerWithString:[cardId substringToIndex:17]];
    
    int val;
    BOOL isNum = [scan scanInt:&val] && [scan isAtEnd];
    if (!isNum) {
        return NO;
    }
    int sumValue = 0;
    
    for (int i =0; i<17; i++) {
        sumValue+=[[cardId substringWithRange:NSMakeRange(i , 1) ] intValue]* [[codeArray objectAtIndex:i] intValue];
    }
    
    NSString* strlast = [checkCodeDic objectForKey:[NSString stringWithFormat:@"%d",sumValue%11]];
    
    if ([strlast isEqualToString: [[cardId substringWithRange:NSMakeRange(17, 1)]uppercaseString]]) {
        return YES;
    }
    return  NO;
}

////验证18位身份证号码
//+ (BOOL)CheckIDCard18:(NSString*)cardId
//{
//    NSArray* address =  @[@"11",@"22",@"35",@"44",@"53",@"12",@"23",@"36",@"45",
//                          @"54",@"13",@"31",@"37",@"46",@"61",@"14",@"32",@"41",
//                          @"50",@"62",@"15",@"33",@"42",@"51",@"63",@"21",@"34",
//                          @"43",@"52",@"64",@"65",@"71",@"81",@"82",@"91"];
//    for( int i = 0; i < [address count]; ++i){
//        if ([[cardId substringWithRange:NSMakeRange(0, 2)] isEqualToString:address[i]]){
//            break;//省份验证正确
//        }
//        else if (i == [address count] - 1){
//            return false;//省份验证错误
//        }
//    }
//
//    NSString* birth = [cardId substringWithRange:NSMakeRange(6, 8)];
//    if(![StringUtils CheckDate:[birth substringWithRange:NSMakeRange(0, 4)]
//                        month:[birth substringWithRange:NSMakeRange(4, 2)]
//                           day:[birth substringWithRange:NSMakeRange(6, 2)]]){
//        return NO;//生日验证错误
//    }
//    if(![StringUtils VarifyCode:cardId]){
//        return NO;//最后一位校验错误
//    }
//    return YES;
//}

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
        if([lastChar isEqualToString:[cardId substringFromIndex:cardId.length - 1]]){
            return YES;
        }
    }
    return NO;
} 

@end
