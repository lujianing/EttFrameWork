//
//  EttDefine.h
//  EttFrameWork
//
//  Created by lujianing on 15/4/11.
//  Copyright (c) 2015年 ett. All rights reserved.
//  公共宏定义 在EttCommon.h中进行引用

#ifndef EttFrameWork_EttDefine_h
#define EttFrameWork_EttDefine_h

#define BLACK_COLOR         [UIColor blackColor]
#define DARKGRAY_COLOR      [UIColor darkGrayColor]
#define LIGHTGRAY_COLOR     [UIColor lightGrayColor]
#define WHITE_COLOR         [UIColor whiteColor]
#define GRAY_COLOR          [UIColor grayColor]
#define RED_COLOR           [UIColor redColor]
#define GREEN_COLOR         [UIColor greenColor]
#define BLUE_COLOR          [UIColor blueColor]
#define CYAN_COLOR          [UIColor cyanColor]
#define YELLOW_COLOR        [UIColor yellowColor]
#define MAGENTA_COLOR       [UIColor magentaColor]
#define ORANGE_COLOR        [UIColor orangeColor]
#define PURPLE_COLOR        [UIColor purpleColor]
#define BROWN_COLOR         [UIColor brownColor]
#define CLEAR_COLOR         [UIColor clearColor]
#define RGB_COLOR(R,G,B)    [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1]
#define RGBA_COLOR(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0  alpha:A]

#define COLOR_N(INT)        [UIColor colorWithRed:(INT/255.0f) green:(INT/255.0f) blue:(INT/255.0f) alpha:1]
#define COLOR_F(Float)      [UIColor colorWithRed:(Float) green:(Float) blue:(Float) alpha:1]


#pragma mark - Size

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#pragma mark - Font
#define FONT(A)  [UIFont systemFontOfSize:(A+1)]


#pragma mark - Device

#define iPad    ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)?YES:NO
#define iPhone  ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)?YES:NO


#pragma mark - SDK Version

#define SystemVersion [[UIDevice currentDevice] systemVersion]
#define AppVersion    [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]

#define IOS7Later ([SystemVersion floatValue] >=7.0)

#define IOS8Later ([SystemVersion floatValue] >=8.0)


#pragma mark - 坐标 -
//计算相邻坐标
#define NextView_X(view)  (view.frame.origin.x + view.frame.size.width)  //view右侧边缘的x坐标
#define NextView_Y(view)  (view.frame.origin.y + view.frame.size.height)  //view下方边缘的y坐标
#define X(view) (view.frame.origin.x)
#define Y(view) (view.frame.origin.y)
#define W(view) (view.frame.size.width)
#define H(view) (view.frame.size.height)

#pragma mark -占位图-

#define ImageWithFile(name) ([UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:nil]])
#define ImageNamed(name) [UIImage imageNamed:name]

#pragma mark -NSLog 开发版显示 release不打印-

#if DEBUG
#warning NSLogs will be shown
#else
#define NSLog(...) {}
#endif


#endif
