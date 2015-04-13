//
//  EttImageUtil.h
//  EttFrameWork
//
//  Created by lujianing on 15/4/11.
//  Copyright (c) 2015年 ett. All rights reserved.
//  图片操作相关方法

#import <Foundation/Foundation.h>

@interface EttImageUtil : NSObject



/**
 *  等比例剪切图片 返回固定宽高
 *
 *  @param sourceImage 原图
 *  @param size    设置宽高
 *
 *  @return 新图
 */
+ (UIImage *)imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;


/**
 *  等比例剪切图片
 *
 *  @param img       原图
 *  @param max_value 宽或高最大值
 *
 *  @return 新图
 */
+ (UIImage *)imageCompressForSize:(UIImage *)img max:(CGFloat)max_value;


/**
 *  把图片变为指定宽高的图片
 *
 *  @param img  原图
 *  @param size 设置宽高
 *
 *  @return 新图
 */
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;


/**
 *  把图片变为竖着
 *
 *  @param aImage 原图
 *
 *  @return 新图
 */
+ (UIImage *)fixOrientation:(UIImage *)aImage;
@end
