//
//  EttUtils.h
//  EttFrameWork
//
//  Created by lujianing on 15/4/13.
//  Copyright (c) 2015年 ett. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EttUtils : NSObject


/**
 *  根据用户头像，查看用户大头像
 *
 *  @param userPhoto 用户头像
 *
 *  @return 用户头像_480_480.ext
 */
+(NSString *)getUserPhotoBig:(NSString *)userPhoto;

/**
 *  计算图片对应的大图
 *
 *  @param pic 小图
 *
 *  @return 图片_1.ext
 */
+(NSString *)getPictureBig:(NSString *)pic;

/**
 *  项目加密签名
 *
 *  @param url       请求方法名
 *  @param parameter 参数字典 （加入时间戳）
 *
 *  @return 返回加密签名
 */
+ (NSString *)URLSignature:(NSString *)method
                 parameter:(NSMutableDictionary *)parameter;


@end
