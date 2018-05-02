//
//  FileUtils.m
//  HealthChengDuTKT
//
//  Created by lijing on 2017/1/8.
//  Copyright © 2017 WeDoctor Group.. All rights reserved.
//

#import "FileUtils.h"
#import "VoiceConverter.h"

@implementation FileUtils

+(NSString*)getDocumentDirectory{
   return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

+(NSString*)getFileName:(NSString*)filePatch
{
    NSString *requestFile = [filePatch stringByDeletingPathExtension];
    NSString *fileName = [requestFile lastPathComponent];
    return fileName;
}

+ (void)downFileFromServer:(NSString*)url atSavePath:(NSString*)path callback:(void(^)(NSString *saveUrl))callback{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request
                                                    completionHandler:
                          ^(NSURL *location, NSURLResponse *response, NSError *error) {
                              NSData* data = [NSData dataWithContentsOfURL:location];
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  [data writeToFile:path atomically:NO];
                                  NSLog(@"文件下载成功:%@",path);
                                  callback(path);
                              });
                          }];  
    [task resume];
}

+ (void)downAllVoice:(NSString*)voicePath{
    if (![StrUtils isEmpty:voicePath]) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([voicePath rangeOfString:@"https://"].location != NSNotFound||[voicePath rangeOfString:@"http://"].location != NSNotFound) {
            NSString* playNameAMR = [NSString stringWithFormat:@"%@%@",[FileUtils getFileName:voicePath],@".amr"];
            NSString* playNameWAV = [NSString stringWithFormat:@"%@%@",[FileUtils getFileName:voicePath],@".wav"];
            NSString* filePathAMR = [[FileUtils getDocumentDirectory] stringByAppendingPathComponent:playNameAMR];
            NSString* filePathWAV = [[FileUtils getDocumentDirectory] stringByAppendingPathComponent:playNameWAV];
            if([fileManager fileExistsAtPath:filePathWAV]){
                return;
            }
            
            [FileUtils downFileFromServer:voicePath atSavePath:filePathAMR callback:^(NSString *saveUrl) {
                if ([VoiceConverter ConvertAmrToWav:saveUrl wavSavePath:filePathWAV]>0){
                    NSLog(@"AMR转WAV音频成功");
                }else{
                    NSLog(@"AMR转WAV音频失败");
                }
            }];
        }
    }
}

+ (void)downAllVoice:(NSString*)voicePath callback:(void(^)(NSString *saveUrl))callback{
    
    if (![StrUtils isEmpty:voicePath]) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([voicePath rangeOfString:@"https://"].location != NSNotFound||[voicePath rangeOfString:@"http://"].location != NSNotFound) {
            NSString* playNameAMR = [NSString stringWithFormat:@"%@%@",[FileUtils getFileName:voicePath],@".amr"];
            NSString* playNameWAV = [NSString stringWithFormat:@"%@%@",[FileUtils getFileName:voicePath],@".wav"];
            NSString* filePathAMR = [[FileUtils getDocumentDirectory] stringByAppendingPathComponent:playNameAMR];
            NSString* filePathWAV = [[FileUtils getDocumentDirectory] stringByAppendingPathComponent:playNameWAV];
            if([fileManager fileExistsAtPath:filePathWAV]){
                return;
            }
    
            [FileUtils downFileFromServer:voicePath atSavePath:filePathAMR callback:^(NSString *saveUrl) {
                if ([VoiceConverter ConvertAmrToWav:saveUrl wavSavePath:filePathWAV]>0){
                    NSLog(@"AMR转WAV音频成功");
                    callback(@"下载成功");
                }else{
                    NSLog(@"AMR转WAV音频失败");
                }
            }];
        }
    }
}





+(NSString*)getVoicePlayTime:(NSString*)voicePath{
    NSString* time = @"";
    NSError *playerError;
    AVAudioPlayer* player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:voicePath] error:&playerError];
    float voiceNum = [player duration];
    if (voiceNum<1) {
        voiceNum = 1;
    }
    time = [NSString stringWithFormat:@"%00.f",voiceNum];
    return time;
}

+ (BOOL)setExtendedAttribute:(NSString*)attribute forKey:(NSString*)key withPath:(NSString*)path{
    NSData *data = [NSPropertyListSerialization dataWithPropertyList:attribute format:NSPropertyListBinaryFormat_v1_0 options:0 error:nil];
    NSError *error;
    BOOL sucess = [[NSFileManager defaultManager] setAttributes:@{@"NSFileExtendedAttributes":@{key:data}}
                                                   ofItemAtPath:path error:&error];
    return sucess;
}
+ (id)getExtendedAttributeForKey:(NSString*)key  withPath:(NSString*)path{
    NSError *error;
    NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:&error];
    if (!attributes) {
        return nil;
    }
    NSDictionary *extendedAttributes = [attributes objectForKey:@"NSFileExtendedAttributes"];
    if (!extendedAttributes) {
        return nil;
    }
    NSData *data = [extendedAttributes objectForKey:key];
    
    id plist = [NSPropertyListSerialization propertyListWithData:data options:0 format:NSPropertyListImmutable error:nil];
    
    return [plist description];
}
@end
