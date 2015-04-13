//
//  NSDate+Extension.h
//  Easywork
//
//  Created by Kingxl on 1/5/15.
//  Copyright (c) 2015 Jin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)

/** Time stamp */
+ (NSString *)ew_timeStamp;

/**  */
- (NSDate *)ew_relativedDateWithInterval:(NSInteger)interval;
@end
