//
//  StringUtils.h
//  PalmHospitalTongJi
//
//  Created by leon on 13-11-27.
//  Copyright (c) 2013年 lvxian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StringUtils : NSObject
+ (NSInteger)getAgeFromId:(NSString *)aStr;

+ (NSInteger)getGenderFromId:(NSString *)aStr;

+ (BOOL)isValidateMobile:(NSString *)mobile;

+ (BOOL)isValidateIDCard:(NSString *)IDCard;

+ (BOOL)CheckIDCard:(NSString*)cardId;

@end
