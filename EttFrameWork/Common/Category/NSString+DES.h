//
//  NSString+DES.h
//  DeveloperLxDemo
//
//  Created by Jin on 15-4-1.
//  Copyright (c) 2015年 DeveloperLx. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const Security_Key = @"*#JZQ2015*#";

@interface NSString (DES)

- (NSString *)desEncryptWithKey:(NSString *)key;
- (NSString *)desDecryptWithKey:(NSString *)key;

@end
