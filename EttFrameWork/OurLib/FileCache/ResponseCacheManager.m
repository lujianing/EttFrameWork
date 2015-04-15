//
//  ResponseCacheManager.m
//  CacheImplementationDemo
//
//  Created by Jin on 15-3-16.
//  Copyright (c) 2015年 etiantian. All rights reserved.
//

#import "ResponseCacheManager.h"
#import <CommonCrypto/CommonDigest.h>

/**
 *  Cache 存储地址 （SandBox）/Library/Caches/(current user_id)/
 */

@implementation ResponseCacheManager

+ (instancetype)sharedManager
{
    static ResponseCacheManager * sharedManager = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        sharedManager = [[ResponseCacheManager alloc]init];
    });
    return sharedManager;
}

- (NSString *)cachesDirectory
{
    NSString * cachesDirectory = NSHomeDirectory();
    cachesDirectory = [cachesDirectory stringByAppendingPathComponent:@"Library"];
    cachesDirectory = [cachesDirectory stringByAppendingPathComponent:@"Caches"];
//    cachesDirectory = [cachesDirectory stringByAppendingPathComponent:USER_ID];
    
    BOOL isDirectory = NO;
    BOOL directoryExists = [[NSFileManager defaultManager] fileExistsAtPath:cachesDirectory isDirectory:&isDirectory];
    
    NSError * error;
    if (!isDirectory || !directoryExists) {
        BOOL createDirectorySuccess = [[NSFileManager defaultManager]createDirectoryAtPath:cachesDirectory withIntermediateDirectories:YES attributes:nil error:&error];
        if (!createDirectorySuccess) {
            NSLog(@"创建缓存目录失败：%@", error.localizedDescription);
            return nil;
        }
    }
    
    return cachesDirectory;
}

- (BOOL)saveCache:(NSDictionary *)cache ofUrlString:(NSString *)urlString
{
    if (urlString.length == 0 || cache.count == 0) {
        return NO;
    }
    NSString * cachePath = [self cachesDirectory];
    
    NSString * cacheFileName = [self md5EncryptString:urlString];
    cachePath = [cachePath stringByAppendingPathComponent:cacheFileName];
    
    BOOL isDirectory = NO;
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:cachePath isDirectory:&isDirectory];
    
    if (!fileExists || isDirectory) {
        
        BOOL createFileSuccess = [[NSFileManager defaultManager]createFileAtPath:cachePath contents:nil attributes:nil];
        
        if (!createFileSuccess) {
            NSLog(@"创建缓存文件失败"); //
            return createFileSuccess;
        }
    }
    
    BOOL saveSuccess = [cache writeToFile:cachePath atomically:YES];
    if (!saveSuccess) {
        NSLog(@"储存缓存记录失败"); //
        return NO;
    }
    else {
        return YES;
    }
}

- (NSDictionary *)findCacheStringByUrlString:(NSString *)urlString
{
    if (urlString.length == 0) {
        return nil;
    }
    
    NSString * cachePath = [self cachesDirectory];
    NSString * cacheFileName = [self md5EncryptString:urlString];
    cachePath = [cachePath stringByAppendingPathComponent:cacheFileName];
    
    BOOL isDirectory = NO;
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:cachePath isDirectory:&isDirectory];
    
    if (!fileExists || isDirectory) {
        NSLog(@"未找到缓存文件"); //
        return nil;
    }

    NSDictionary * cache = [NSDictionary dictionaryWithContentsOfFile:cachePath];

    return cache;
}

- (NSString *)md5EncryptString:(NSString *)plaintext
{
    const char * plaintextCString = plaintext.UTF8String;
    unsigned char result[16];
    CC_MD5(plaintextCString, (CC_LONG)strlen(plaintextCString), result);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x", result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7], result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
}

- (NSString *)completeURLStringOfWholePath:(NSString *)wholePath parameterDictionary:(NSDictionary *)parameterDictionary
{
    if (parameterDictionary.count == 0) {
        return wholePath;
    }
    NSMutableArray * parameterArray = [NSMutableArray array];
    for (NSString * key in parameterDictionary) {
        [parameterArray addObject:[NSString stringWithFormat:@"%@=%@", key, parameterDictionary[key]]];
    }
    NSString * parameterString = [parameterArray componentsJoinedByString:@"&"];
    
    return [NSString stringWithFormat:@"%@?%@", wholePath, parameterString];
}

@end
