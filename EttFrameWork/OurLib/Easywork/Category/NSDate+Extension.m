//
//  NSDate+Extension.m
//  Easywork
//
//  Created by Kingxl on 1/5/15.
//  Copyright (c) 2015 Jin. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

+ (NSString *)ew_timeStamp
{
    return [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970] * 1000];
}


- (NSDate *)ew_relativedDateWithInterval:(NSInteger)interval
{
    
    return nil;
}

@end
