//
//  EttUserDefault.h
//  EttFrameWork
//
//  Created by lujianing on 15/4/11.
//  Copyright (c) 2015年 ett. All rights reserved.
//  NSUserDefaults操作的工具类

#import <Foundation/Foundation.h>

@interface EttUserDefaultUtil : NSObject

/** UserDefault */
+ (void)setObject:(id)data key:(NSString *)key;
+ (void)removeObject:(NSString *)key;
+ (id)getObjectForKey:(NSString *)key;


@end
