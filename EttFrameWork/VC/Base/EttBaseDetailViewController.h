//
//  BaseDetailViewController.h
//  ETTParents
//
//  Created by lujianing on 15/2/26.
//  Copyright (c) 2015年 kingxl. All rights reserved.
//

#import "EttBaseViewController.h"



@interface EttBaseDetailViewController : EttBaseViewController

//评论列表tableview
@property (nonatomic, strong) UITableView *listView;
//评论列表数组
@property (nonatomic, strong) NSMutableArray *listData;

//分享资源id  --详情页加载时赋值
@property (nonatomic, strong) NSString *rootId;
//分享资源内容 --详情页加载时赋值
@property (nonatomic, strong) NSString *rootContent;
//分享资源类型 --详情页加载时赋值
@property (nonatomic, strong) NSString *targetType;
//分享的标题   --详情页加载时赋值
@property (nonatomic, strong) NSString *rootTitle;
//分享的图片   --详情页加载时赋值
@property (nonatomic, strong) UIImage *shareImage;

//是否允许显示提示  （天天悦读 评论后 提示发表成功）
@property (nonatomic, assign) BOOL showToast;

//当前评论索引
@property (nonatomic, strong) NSIndexPath *cellIndexPath;

//资源是否被收藏了
@property (nonatomic, assign) int isCollection;
//是否显示收藏按钮
@property (nonatomic, assign) bool showCollection;


/**
 *  当前资源在父页面tableview中的索引
 */
@property (nonatomic, strong) NSIndexPath *tableIndexPath;

//第三方分享模块
@property (nonatomic, strong) NSArray *snsTitleArray;
@property (nonatomic, strong) NSArray *snsIconArray;
@property (nonatomic, strong) EWShareSheet *sheet;


@end
