//
//  BaseDetailViewController.m
//  ETTParents
//
//  Created by lujianing on 15/2/26.
//  Copyright (c) 2015年 kingxl. All rights reserved.
//  提取的详情页操作类 用于帖子详情页 评论详情页  视频详情页 继承使用


#import "EttBaseDetailViewController.h"

@implementation EttBaseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //监测键盘的弹出与消失(用于评论输入框)
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
