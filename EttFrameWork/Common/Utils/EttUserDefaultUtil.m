//
//  EttUserDefault.m
//  EttFrameWork
//
//  Created by lujianing on 15/4/11.
//  Copyright (c) 2015年 ett. All rights reserved.
//  NSUserDefaults操作的工具类

#import "EttUserDefaultUtil.h"

@implementation EttUserDefaultUtil

#pragma mark - UserDefault
+ (void)setObject:(id)data key:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)removeObject:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+ (id)getObjectForKey:(NSString *)key
{
    return  [[NSUserDefaults standardUserDefaults] objectForKey:key];
}


@end
