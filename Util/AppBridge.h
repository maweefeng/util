//
//  AppBridge.h
//  HealthJiangSu
//
//  Created by Evan on 4/26/16.
//  Copyright © 2017 WeDoctor Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

//static JSContext *context;

@protocol APPJSBridgeJSExports <JSExport>

-(void)goHome:(NSString*) bankNo;

-(void)goContact:(NSString*) bankNo;


-(void)goLogin;

@end

@protocol appBridgeDelegate <NSObject>

-(void)goHomeData:(NSString*) bankNo;

-(void)goContactData:(NSString*) bankNo;

-(void)goLoginData;

@end

@interface AppBridge : NSObject<APPJSBridgeJSExports>

@property (nonatomic,assign) id<appBridgeDelegate> delegate;

@end
