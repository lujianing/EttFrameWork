//
//  ResponseCacheManager.h
//  CacheImplementationDemo
//
//  Created by Jin on 15-3-16.
//  Copyright (c) 2015年 etiantian. All rights reserved.
//  http返回的值 通过文件缓存

#import <Foundation/Foundation.h>

@interface ResponseCacheManager : NSObject

+ (instancetype)sharedManager;

- (BOOL)saveCache:(NSDictionary *)cache ofUrlString:(NSString *)urlString;
- (NSDictionary *)findCacheStringByUrlString:(NSString *)urlString;

/**
 *  @param parameterDictionary 不能包含会导致URL完整地址每次不同的随机性参数，如时间戳等等
 */
- (NSString *)completeURLStringOfWholePath:(NSString *)wholePath parameterDictionary:(NSDictionary *)parameterDictionary;

@end
