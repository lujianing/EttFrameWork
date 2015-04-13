//
//  EttHttpManager.m
//  EttFrameWork
//
//  Created by lujianing on 15/4/11.
//  Copyright (c) 2015年 ett. All rights reserved.
//

#import "EttHttpManager.h"

@implementation EttHttpManager

+ (instancetype)instance
{
    static EttHttpManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[EttHttpManager alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        
        manager.requestSerializer.timeoutInterval = NET_REQUEST_TIMEOUT;
    });
    return manager;
}


@end
