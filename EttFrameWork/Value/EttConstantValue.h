//
//  EttConstantValue.h
//  EttFrameWork
//
//  Created by lujianing on 15/4/11.
//  Copyright (c) 2015年 ett. All rights reserved.
//  全局常量 命名应根据 类型，模块以及页面路径
//  [注意:常量会被多个页面修改，修改一份可能会影响多个地方]

#ifndef EttFrameWork_EttConstantValue_h
#define EttFrameWork_EttConstantValue_h

//开发 服务器地址
static NSString *const BASE_URL =@"";
static NSString *const COMMON_BASE_URL =@"";

//app相关
static NSString *const APP_NAME = @"";
static NSString *const APP_ID = @"";
static float const NET_REQUEST_TIMEOUT =10.0f;


//页面常量
static NSString *const HOME_PAGE_TITLE = @"首页";


/* TOAST 提示*/
//
static NSString *const TOAST_ERROR = @"系统开小差了,请稍后再试";
static NSString *const TOAST_NET_ERROR =@"网络似乎出了点问题";



#endif
