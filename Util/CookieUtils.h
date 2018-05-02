//
//  CookieUtils.h
//  HealthChengDuTKT
//
//  Created by lijing on 2017/1/3.
//  Copyright © 2017 WeDoctor Group.. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CookieUtils : NSObject
+(void)setTKTCookie:(NSString *)urlStr;
+(void)removerAllCookie;
+(NSMutableURLRequest*)setCookie:(NSString *)url;
@end
