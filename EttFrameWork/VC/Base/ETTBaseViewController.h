//
//  ETTBaseViewController.h
//  ETTParents
//
//  Created by Jin on 15-1-12.
//  Copyright (c) 2015年 kingxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EttBaseViewController : UIViewController

@property (nonatomic, strong) UIImageView *navBackgroundView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *leftBarButton;
@property (nonatomic, strong) UIButton *rightBarButton;

/**
 *  没有数据情况加加载
 */
@property (nonatomic, strong) UIView *noDataView;
@property (nonatomic, strong) UIImageView *noDataImage;
@property (nonatomic, strong) UILabel *noDataLabel;//当没有数据或者资源被屏蔽时候用


//navigationBar button  left && right, default is  hidden, subclass override this method if needed.
- (void)configNavBar;  //config title  button image ,hide or show,selector
- (void)clickLeftBar;
- (void)clickRightBar;
- (void)showMenu:(UITapGestureRecognizer *)tap;

- (void)hideNavBarWithAnimationDurtion:(float)durtion;
- (void)showNavBarWithAnimationDurtion:(float)durtion;

//hud
- (void)showLoading;
- (void)showLoadingWithTitle:(NSString *)title;
- (void)hideLoading;

//toast
- (void)showToast:(NSString *)msg;
- (void)showToast:(NSString *)msg duration:(NSTimeInterval)time;


//网络请求失败——统一处理方法
-(void)httpFailure:(NSError *)error;

-(void)httpFailure:(NSError *)error toastText:(NSString *)text;


//添加下拉刷新
-(void)addHeaderFresh:(UIScrollView *)view;

//结束下拉刷新
-(void)endHeaderFresh:(UIScrollView *)view;

//隐藏下拉刷新
-(void)hideHeaderFresh:(UIScrollView *)view;

//显示下拉刷新
-(void)showHeaderFresh:(UIScrollView *)view;


//添加上拉刷新
-(void)addFooterFresh:(UIScrollView *)view;


//结束下拉刷新
-(void)endFooterFresh:(UIScrollView *)view;

//隐藏下拉刷新
-(void)hideFooterFresh:(UIScrollView *)view;

//显示下拉刷新
-(void)showFooterFresh:(UIScrollView *)view;

//结束上拉和下拉刷新
-(void)endFreshing:(UIScrollView *)view;

/**
 *  网络失败时候显示的图片
 */
- (void)showNetworkFailureViewOnView:(id)view;

- (void)hideNetworkFailureView;

- (void)afreshNetwork:(UIButton *)button;

/**
 *  没有数据的时候加载
 */
- (void)showNoDataViewOnView:(id)view;
- (void)hideNODataView;

@end
