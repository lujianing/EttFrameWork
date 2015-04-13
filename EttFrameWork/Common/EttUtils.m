//
//  EttUtils.m
//  EttFrameWork
//
//  Created by lujianing on 15/4/13.
//  Copyright (c) 2015年 ett. All rights reserved.
//  项目相关的一些公共方法

#import "EttUtils.h"

@implementation EttUtils

+(NSString *)getUserPhotoBig:(NSString *)userPhoto
{
    return [NSString stringWithFormat:@"%@_480_480.%@", userPhoto.stringByDeletingPathExtension, userPhoto.pathExtension];
}

+(NSString *)getPictureBig:(NSString *)pic{
    return [NSString stringWithFormat:@"%@_1.%@", pic.stringByDeletingPathExtension, pic.pathExtension];
}

+ (NSString *)URLSignature:(NSString *)url
                 parameter:(NSMutableDictionary *)parameter
{
    @autoreleasepool {
        //time stamp
        [parameter setValue:[NSDate ew_timeStamp] forKey:@"time"];
        
        
        
        NSArray *allKeys = parameter.allKeys;
        
        //filter
        for (NSString *key in allKeys) {
            if ([[(NSString *)parameter[key] ew_removeSpacesAndLineBreaks] length] == 0) {
                [parameter removeObjectForKey:key];
            }
        }
        
        allKeys = parameter.allKeys;
        
        //sort
        allKeys = [allKeys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            NSComparisonResult result = [obj1 compare:obj2];
            return result==NSOrderedDescending;
        }];
        
        //拼接字符串
        NSMutableString *tempStr = [NSMutableString string];
        
        [allKeys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            if (idx == allKeys.count-1) {
                [tempStr appendFormat:@"%@=%@",obj,[parameter[obj] ew_urlEncode]];
            }else{
                [tempStr appendFormat:@"%@=%@&",obj,[parameter[obj] ew_urlEncode]];
            }
        }];
        
        NSString *string = [NSString stringWithFormat:@"%@&%@%@",url,tempStr,APP_SECURITY_KEY];
        
        NSString *encodeStr = [[[string ew_md5Encrypt] ew_base64Encode] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"="]];
        
        return encodeStr;
        
    }
}


@end
