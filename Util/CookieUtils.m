//
//  CookieUtils.m
//  HealthChengDuTKT
//
//  Created by lijing on 2017/1/3.
//  Copyright © 2017 WeDoctor Group.. All rights reserved.
//

#import "CookieUtils.h"
#import "UserCenter.h"

@implementation CookieUtils
+(void)setTKTCookie:(NSString *)urlStr
{
    NSString *token = [UserCenter shareCenter].authToken;
    NSArray *headeringCookie = [NSHTTPCookie cookiesWithResponseHeaderFields:
                                [NSDictionary dictionaryWithObject:
                                 [[NSString alloc] initWithFormat:@"%@=%@",@"__wyt__", token]
                                                            forKey:@"Set-Cookie"]
                                                                      forURL:[NSURL URLWithString:urlStr]];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookies:headeringCookie forURL:[NSURL URLWithString:urlStr] mainDocumentURL:nil];
}

+(void)removerAllCookie{
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie *cookie in [storage cookies])
    {
        NSLog(@"name:%@ value:%@",cookie.name,cookie.value);
        [storage deleteCookie:cookie];
    }
}

+(NSMutableURLRequest*)setCookie:(NSString *)url{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
//    NSDictionary *properties1 = [NSDictionary dictionaryWithObjectsAndKeys:
//                                 @"cdzyy.j.guahao-inc.com/policlinic/precheck/20170216001", NSHTTPCookieDomain,
//                                 @"/", NSHTTPCookiePath,
//                                 @"__wyt__", NSHTTPCookieName,
//                                 [UserCenter shareCenter].authToken, NSHTTPCookieValue,
//                                 nil];
//    NSHTTPCookie *cookie1 = [NSHTTPCookie cookieWithProperties:properties1];
//    NSArray* cookies = [NSArray arrayWithObjects: cookie1, nil];
//    NSDictionary * headers = [NSHTTPCookie requestHeaderFieldsWithCookies:cookies];
//    request.allHTTPHeaderFields = headers;
    
    
    NSString* wzcookie = [NSString stringWithFormat:@"%@=%@",@"__wyt__",[UserCenter shareCenter].authToken];
    [request addValue:wzcookie forHTTPHeaderField:@"Cookie"];
    return request;
}
@end
