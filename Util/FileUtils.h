//
//  FileUtils.h
//  HealthChengDuTKT
//
//  Created by lijing on 2017/1/8.
//  Copyright © 2017 WeDoctor Group.. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileUtils : NSObject
+(NSString*)getDocumentDirectory;
+(NSString*)getFileName:(NSString*)filePatch;
+ (void)downFileFromServer:(NSString*)url atSavePath:(NSString*)path callback:(void(^)(NSString *saveUrl))callback;
+ (void)downAllVoice:(NSString*)voicePath callback:(void(^)(NSString *saveUrl))callback;
+ (void)downAllVoice:(NSString*)voicePath;
//获取语音时间
+(NSString*)getVoicePlayTime:(NSString*)voicePath;
//文件扩展属性设置
+ (BOOL)setExtendedAttribute:(NSString*)attribute forKey:(NSString*)key withPath:(NSString*)path;
//文件扩展属性读取
+ (id)getExtendedAttributeForKey:(NSString*)key  withPath:(NSString*)path;
@end
