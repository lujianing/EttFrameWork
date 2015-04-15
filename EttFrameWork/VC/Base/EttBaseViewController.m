//
//  ETTBaseViewController.m
//  ETTParents
//
//  Created by Jin on 15-1-12.
//  Copyright (c) 2015年 kingxl. All rights reserved.
//

#import "EttBaseViewController.h"
#import <MBProgressHUD.h>
#import <UIView+Toast.h>
#import "MJRefresh.h"
#import "MJRefreshHeader.h"
#import "MJRefreshFooter.h"


@interface EttBaseViewController ()
@property (nonatomic, strong) MBProgressHUD *hud;


/**
 *  没网情况下的图片
 */
@property (nonatomic, strong) UIView *networkFailureView;
@property (nonatomic, strong) UIImageView *networkFailureImage;
@property (nonatomic, strong) UIButton *networkFailureButton;
@property (nonatomic, strong) UILabel *networkFailureText;
@property (nonatomic, strong) UILabel *networkFailureLoad;


@end

@implementation EttBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = WHITE_COLOR;
    [self setupNavigationBar];
    [self configNavBar];
}

#pragma mark - setup
- (void)setupNavigationBar
{
//    _navBackgroundView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, IOS7Later?64:44)];
//    _navBackgroundView.userInteractionEnabled = YES;
//    _navBackgroundView.backgroundColor = NAV_COLOR;
//    [self.view addSubview:_navBackgroundView];
//    
//    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(BTNMargin+BTNWIDTH, IOS7Later?20:0, SCREEN_WIDTH-BTNMargin*2-BTNWIDTH*2, BTNHEIGHT)];
//    _titleLabel.backgroundColor = CLEAR_COLOR;
//    _titleLabel.textAlignment = NSTextAlignmentCenter;
//    _titleLabel.textColor = WHITE_COLOR;
//    _titleLabel.font = FONT(17);
//    _titleLabel.userInteractionEnabled = YES;
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showMenu:)];
//    [_titleLabel addGestureRecognizer:tap];
//    [_navBackgroundView addSubview:_titleLabel];
//    
//    _leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_leftBarButton addTarget:self action:@selector(clickLeftBar) forControlEvents:UIControlEventTouchUpInside];
//    _leftBarButton.hidden = YES;
//    //_leftBarButton.backgroundColor = GRAY_COLOR;
//    _leftBarButton.frame = CGRectMake(0,BTNMarginTop , BTNWIDTH, BTNHEIGHT);
//    _leftBarButton.titleLabel.font = FONT(14);
//    [_leftBarButton setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
//    [_navBackgroundView addSubview:_leftBarButton];
//    
//    _rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_rightBarButton addTarget:self action:@selector(clickRightBar) forControlEvents:UIControlEventTouchUpInside];
//    _rightBarButton.hidden = YES;
//    //_rightBarButton.backgroundColor = BLACK_COLOR;
//    _rightBarButton.frame = CGRectMake(SCREEN_WIDTH-BTNWIDTH, BTNMarginTop, BTNWIDTH, BTNHEIGHT);
//    _rightBarButton.titleLabel.font = FONT(14);
//    //_rightBarButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//    [_navBackgroundView addSubview:_rightBarButton];
//    
//    if (IOS7Later) {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
}



#pragma mark - button click
- (void)configNavBar{};
- (void)clickLeftBar{};
- (void)clickRightBar{};
- (void)showMenu:(UITapGestureRecognizer *)tap{};

- (void)hideNavBarWithAnimationDurtion:(float)durtion
{
//    [UIView animateWithDuration:durtion delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
//        _navBackgroundView.frame = CGRectMake(0, -KNAVIGATION_HEIGHT, SCREEN_WIDTH, KNAVIGATION_HEIGHT);
//    } completion:^(BOOL finished) {
//        _navBackgroundView.hidden = YES;
//    }];
}

- (void)showNavBarWithAnimationDurtion:(float)durtion
{
//    [UIView animateWithDuration:durtion delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
//        _navBackgroundView.hidden = NO;
//        _navBackgroundView.frame = CGRectMake(0, 0, SCREEN_WIDTH, KNAVIGATION_HEIGHT);
//    } completion:^(BOOL finished) {
//        
//    }];
}


#pragma mark - loading & toas
- (void)showLoading
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [MBProgressHUD HUDForView:self.view].userInteractionEnabled = NO;
}
- (void)showLoadingWithTitle:(NSString *)title
{
    //TODO: IF NEEDED
}
- (void)hideLoading
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

#pragma mark - toast
- (void)showToast:(NSString *)msg
{
    [self showToast:msg duration:2.0];
}
- (void)showToast:(NSString *)msg duration:(NSTimeInterval)time
{
    [self.view makeToast:msg duration:time position:CSToastPositionCenter];
}

//根据文字获得文本的高度
- (CGSize)getLabelHeightWithRect:(CGSize)size text:(NSString *)text withFont:(UIFont *)font{
    CGSize newsize = [text boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size;
    return newsize;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)httpFailure:(NSError *)error{
    
    [self httpFailure:error showToast:NO toastText:error.localizedDescription];
    
}

-(void)httpFailure:(NSError *)error toastText:(NSString *)text
{
    [self httpFailure:error showToast:NO toastText:text];
}

-(void)httpFailure:(NSError *)error showToast:(BOOL)show toastText:(NSString *)text{
    
    [self hideLoading];
    
    if(show){
        [self showToast:[text isKindOfClass:[NSString class]]?text:error.localizedDescription];
    }
    
    
}

-(void)addHeaderFresh:(UIScrollView *)view
{
    
/*
    // 添加动画图片的下拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    [view addGifHeaderWithRefreshingTarget:self refreshingAction:@selector(startHeaderRefresh:)];
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
//    for (NSUInteger i = 1; i<=60; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
//        [idleImages addObject:image];
//    }
    for (NSUInteger i = 1; i<=11; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"ett_loading_%zd.jpg", i]];
        image = [ETTUtils scaleToSize:image size:CGSizeMake(60, 60)];
        [idleImages addObject:image];
    }

    
    [view.gifHeader setImages:idleImages forState:MJRefreshHeaderStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
//    for (NSUInteger i = 1; i<=3; i++) {
//        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
//        [refreshingImages addObject:image];
//    }
    
    for (NSUInteger i = 1; i<=15; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"ett_loading_%zd.jpg", i]];
        image = [ETTUtils scaleToSize:image size:CGSizeMake(60, 60)];

        [refreshingImages addObject:image];
    }

    [view.gifHeader setImages:refreshingImages forState:MJRefreshHeaderStatePulling];
    
    // 设置正在刷新状态的动画图片
    [view.gifHeader setImages:refreshingImages forState:MJRefreshHeaderStateRefreshing];
    // 在这个例子中，即将刷新 和 正在刷新 用的是一样的动画图片
    
    // 马上进入刷新状态
    //[self.listView.gifHeader beginRefreshing];
 
 */
    
    // 添加传统的下拉刷新
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    [view addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRefresh:)];

    
}

-(void)endHeaderFresh:(UIScrollView *)view
{
    
//    if(view.gifHeader){
//        [view.gifHeader endRefreshing];
//    }
// 
    if(view.header){
        [view.header endRefreshing];
    }
}

-(void)hideHeaderFresh:(UIScrollView *)view
{
   
//    if(view.gifHeader){
//        [view.gifHeader setHidden:YES];
//    }
// 
    if(view.header){
        [view.header setHidden:YES];
    }

}

-(void)showHeaderFresh:(UIScrollView *)view
{

//    if(view.gifHeader){
//        [view.gifHeader setHidden:NO];
//    }
    
    if(view.header){
        [view.header setHidden:NO];
    }

    
}


-(void)headerRefresh:(id)data
{
    
}

-(void)addFooterFresh:(UIScrollView *)view
{
    [view addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(loadMore:)];
    //普通闲置状态的文字 置为空 
    [view.footer setTitle:@"" forState:MJRefreshFooterStateIdle];

}

-(void)loadMore:(id)data
{
    
}

-(void)endFooterFresh:(UIScrollView *)view
{
    if(view.footer){
        [view.footer endRefreshing];
    }
}


-(void)hideFooterFresh:(UIScrollView *)view
{
    [view.footer setHidden:YES];
}

-(void)showFooterFresh:(UIScrollView *)view
{
    [view.footer setHidden:NO];
}

-(void)endFreshing:(UIScrollView *)view
{
    [self endHeaderFresh:view];
    [self endFooterFresh:view];
}

/**
 *  没网情况下加载
 */
- (void)showNetworkFailureViewOnView:(id)view{
//    UIView *superView = nil;
//    if ([view isKindOfClass:[UIView class]]) {
//        superView = (UIView *)view;
//    }else{
//        return;
//    }
//    [superView addSubview:self.networkFailureView];
//    self.networkFailureView.frame = CGRectMake(0,NAV_HEIGHT, SCREEN_WIDTH, ViewFH(superView)-NAV_HEIGHT);
//    self.networkFailureImage.frame = CGRectMake((SCREEN_WIDTH-170/2)/2, SCREEN_HEIGHT/2-130/2-NAV_HEIGHT-50, 170/2, 130/2);
//    [self.networkFailureView addSubview:self.networkFailureImage];
//    [self.networkFailureView addSubview:self.networkFailureText];
//    [self.networkFailureView addSubview:self.networkFailureLoad];
//    [self.networkFailureView addSubview:self.networkFailureButton];
//    
//    //设置坐标
//    self.networkFailureText.frame = CGRectMake(0, NextView_Y(self.networkFailureImage)+20, SCREEN_WIDTH, 30);
//    self.networkFailureLoad.frame = CGRectMake(0, NextView_Y(self.networkFailureText), SCREEN_WIDTH, 20);
//    self.networkFailureButton.frame = CGRectMake((SCREEN_WIDTH-80)/2, NextView_Y(self.networkFailureLoad)+35, 80, 35);
}

- (void)hideNetworkFailureView{
    if (_networkFailureView) {
        [_networkFailureText removeFromSuperview];
        _networkFailureText = nil;
        
        [_networkFailureImage removeFromSuperview];
        _networkFailureImage = nil;
        
        [_networkFailureButton removeFromSuperview];
        _networkFailureButton  = nil;
        
        [_networkFailureLoad removeFromSuperview];
        _networkFailureLoad = nil;
        
        [_networkFailureView removeFromSuperview];
        _networkFailureView = nil;
    }
}

- (void)afreshNetwork:(UIButton *)button{
    
}


/**
 *  没有数据的时候加载
 */
- (void)showNoDataViewOnView:(id)view{
//    UIView *superView = nil;
//    if ([view isKindOfClass:[UIView class]]) {
//        superView = (UIView *)view;
//    }else{
//        return;
//    }
//    [superView addSubview:self.noDataView];
//    self.noDataView.frame = CGRectMake(0, NAV_HEIGHT, SCREEN_WIDTH, ViewFH(superView)-NAV_HEIGHT);
//    
//    
//    [self.noDataView addSubview:self.noDataImage];
//    self.noDataImage.frame = CGRectMake(0, (SCREEN_HEIGHT-NAV_HEIGHT)/2-150, SCREEN_WIDTH, 200);
//    
//    [self.noDataImage addSubview:self.noDataLabel];
//    self.noDataLabel.frame = CGRectMake(0,ViewFH(self.noDataImage)-30, SCREEN_WIDTH, 30);
}

- (void)hideNODataView{
    
}

#pragma mark - 懒加载 -
/**
 *  无网时候控件的懒加载
 *
 */
- (UIView *)networkFailureView{
    if (_networkFailureView == nil) {
        self.networkFailureView = [[UIView alloc] init];
        _networkFailureView.backgroundColor = WHITE_COLOR;
    }
    return _networkFailureView;
}

- (UIImageView *)networkFailureImage{
    if (_networkFailureImage == nil) {
        self.networkFailureImage = [[UIImageView alloc] init];
        _networkFailureImage.image = [UIImage imageNamed:@"network_failure_wifi"];
    }
    return _networkFailureImage;
}

- (UIButton *)networkFailureButton{
    if (_networkFailureButton == nil) {
        self.networkFailureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_networkFailureButton setBackgroundImage:[UIImage imageNamed:@"network_failure_button"] forState:UIControlStateNormal];
        [_networkFailureButton addTarget:self action:@selector(afreshNetwork:) forControlEvents:UIControlEventTouchUpInside];
        [_networkFailureButton setTitle:@"重新加载" forState:UIControlStateNormal];
        _networkFailureButton.titleLabel.font = FONT(14);
    }
    return _networkFailureButton;
}

- (UILabel *)networkFailureText{
    if (_networkFailureText == nil) {
        self.networkFailureText = [[UILabel alloc] init];
        _networkFailureText.textAlignment = NSTextAlignmentCenter;
        _networkFailureText.text = @"咦？数据加载失败了";
        _networkFailureText.font = FONT(17);
        _networkFailureText.backgroundColor = CLEAR_COLOR;
        _networkFailureText.textColor = RGB_COLOR(183, 183, 183);
    }
    return _networkFailureText;
}

- (UILabel *)networkFailureLoad{
    if (_networkFailureLoad == nil) {
        self.networkFailureLoad = [[UILabel alloc] init];
        _networkFailureLoad.text = @"请检查您的网络，重新加载吧";
        _networkFailureLoad.textColor = RGB_COLOR(183, 183, 183);
        _networkFailureLoad.font = FONT(14);
        _networkFailureLoad.textAlignment = NSTextAlignmentCenter;
    }
    return _networkFailureLoad;
}

/**
 *  没有数据时候控件的加载
 */
- (UIView *)noDataView{
    if (_noDataView == nil) {
        self.noDataView = [[UIView alloc] initWithFrame:CGRectZero];
        _noDataView.backgroundColor = WHITE_COLOR;
    }
    return _noDataView;
}

- (UIImageView *)noDataImage{
    if (_noDataImage == nil) {
        self.noDataImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        _noDataImage.image = ImageNamed(@"cute-mamtou-01");
        _noDataImage.contentMode = UIViewContentModeCenter;
    }
    return _noDataImage;
}

- (UILabel *)noDataLabel{
    if (_noDataLabel == nil) {
        self.noDataLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _noDataLabel.text = @"同城的其他家长还没加入呢!";
        _noDataLabel.textColor = LIGHTGRAY_COLOR;
        _noDataLabel.textAlignment = NSTextAlignmentCenter;
        _noDataLabel.font = FONT(14);
    }
    return _noDataLabel;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
