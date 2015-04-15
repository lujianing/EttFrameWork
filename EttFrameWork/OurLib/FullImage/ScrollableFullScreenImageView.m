//
//  ScrollableFullScreenImageView.m
//  ScrollableFullScreenImageViewDemo
//
//  Created by Jin on 15-3-12.
//  Copyright (c) 2015年 kingxl. All rights reserved.
//

#define TRANSITION_ANIMATION_DURATION   0.3
#define IMAGE_GAP   16
#define MAX_ZOOM_SCALE  2
#define PAGE_CONTROL_HEIGHT 20
#define PAGE_CONTROL_BOTTOM_SPACING 10

#define MAIN(block) dispatch_async(dispatch_get_main_queue(), block)

#import "ScrollableFullScreenImageView.h"
#import "UIImageView+WebCache.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "UIImageView+Tools.h"

@interface ScrollableFullScreenImageView () <UIScrollViewDelegate, UIActionSheetDelegate>

@property (nonatomic,retain) UIScrollView * backgroundScrollView;
@property (nonatomic,retain) UIPageControl * pageControl;
@property (nonatomic,retain) UIImageView * transitionImageView;
@property (nonatomic,retain) NSArray * bigImageURLStringArray;

@end

@implementation ScrollableFullScreenImageView
{
    UIImage * _waitToSaveImage;
}
@synthesize currentImageIndex = _currentImageIndex;

- (void)dealloc
{
    self.backgroundScrollView = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image
{
    self = [super initWithImage:image];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage
{
    self = [super initWithImage:image highlightedImage:highlightedImage];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.userInteractionEnabled = YES;
    self.contentMode = UIViewContentModeScaleAspectFill;
    self.clipsToBounds = YES;

    UITapGestureRecognizer * rawImageTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rawImageTap:)];
    [self addGestureRecognizer:rawImageTap];
    
    self.pageControl = [[UIPageControl alloc]init];
}

- (void)rawImageTap:(UITapGestureRecognizer *)tap
{
    self.pageControl.frame = CGRectMake(0, self.window.frame.size.height - PAGE_CONTROL_HEIGHT - PAGE_CONTROL_BOTTOM_SPACING, self.window.frame.size.width, PAGE_CONTROL_HEIGHT);
    self.pageControl.hidesForSinglePage = YES;
    self.pageControl.currentPage = self.currentImageIndex;
    [self.window addSubview:self.pageControl];
    
    self.transitionImageView = [[UIImageView alloc]initWithFrame:[self convertRect:self.bounds toView:self.window]];
    self.transitionImageView.image = self.image;
    self.transitionImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.transitionImageView.clipsToBounds = self.clipsToBounds;
    self.transitionImageView.userInteractionEnabled = YES;
    [self.window addSubview:self.transitionImageView];

    [UIView animateWithDuration:TRANSITION_ANIMATION_DURATION animations:^{
    
        self.transitionImageView.frame = self.window.bounds;
        self.transitionImageView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.9];
    } completion:^(BOOL finished) {
    
        self.transitionImageView.image = nil;
        self.backgroundScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, (self.window.bounds.size.width + IMAGE_GAP), self.window.bounds.size.height)];
        self.backgroundScrollView.contentSize = CGSizeMake((self.window.bounds.size.width + IMAGE_GAP) * self.imageURLStringArray.count, self.window.bounds.size.height);
        self.backgroundScrollView.delegate = self;
        self.backgroundScrollView.pagingEnabled = YES;
        
        CGPoint backgroundScrollViewContentOffset = self.backgroundScrollView.contentOffset;
        backgroundScrollViewContentOffset.x = self.backgroundScrollView.frame.size.width * self.currentImageIndex;
        self.backgroundScrollView.contentOffset = backgroundScrollViewContentOffset;
        
        for (int i = 0; i < self.imageURLStringArray.count; i++) {
            
            UIScrollView * imageZoomScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(self.backgroundScrollView.frame.size.width * i, 0, self.window.frame.size.width, self.window.frame.size.height)];
            imageZoomScrollView.contentSize = imageZoomScrollView.frame.size;
            imageZoomScrollView.delegate = self;
            imageZoomScrollView.minimumZoomScale = 1;
            imageZoomScrollView.maximumZoomScale = MAX_ZOOM_SCALE;
            
            [self.backgroundScrollView addSubview:imageZoomScrollView];
            
            UITapGestureRecognizer * imageZoomScrollViewSingleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageZoomScrollViewSingleTap:)];
            [imageZoomScrollView addGestureRecognizer:imageZoomScrollViewSingleTap];
            
            UITapGestureRecognizer * imageZoomScrollViewDoubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageZoomScrollViewDoubleTap:)];
            imageZoomScrollViewDoubleTap.numberOfTapsRequired = 2;
            [imageZoomScrollView addGestureRecognizer:imageZoomScrollViewDoubleTap];
            [imageZoomScrollViewSingleTap requireGestureRecognizerToFail:imageZoomScrollViewDoubleTap];
            
            UILongPressGestureRecognizer * imageZoomScrollViewLongPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(imageZoomScrollViewLongPress:)];
            [imageZoomScrollView addGestureRecognizer:imageZoomScrollViewLongPress];
            
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, imageZoomScrollView.frame.size.width, imageZoomScrollView.frame.size.height)];
            
            NSString * imageURLString = self.imageURLStringArray[i];
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageURLString] placeholderImage:DefaultPostPic];
            [imageView sd_setImageWithURL:[NSURL URLWithString:_bigImageURLStringArray[i]] placeholderImage:imageView.image options:SDWebImageDelayPlaceholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                imageZoomScrollView.frame = imageView.imageFrame;
//                imageView.frame = imageZoomScrollView.bounds;
            }];
            
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            imageView.clipsToBounds = YES;
            [imageZoomScrollView addSubview:imageView];
        }
        
        [self.window addSubview:self.backgroundScrollView];
        [self.window bringSubviewToFront:self.pageControl];
    }];
}

- (void)imageZoomScrollViewSingleTap:(UITapGestureRecognizer *)tap
{
    [self.pageControl removeFromSuperview];
    
    UIScrollView * imageZoomScrollView = (UIScrollView *)tap.view;
    
    for (UIView * subV in imageZoomScrollView.subviews) {
        if ([subV isKindOfClass:[UIImageView class]]) {
            UIImageView * imageView = (UIImageView *)subV;
            self.transitionImageView.image = imageView.image;
            break;
        }
    }
    
    [self.backgroundScrollView removeFromSuperview];
    
    self.transitionImageView.backgroundColor = [UIColor clearColor];
    [UIView animateWithDuration:TRANSITION_ANIMATION_DURATION animations:^{
        
        if (self.imageViewFrameArray.count > self.currentImageIndex) {
            
            NSValue * imageViewFrameValue = self.imageViewFrameArray[self.pageControl.currentPage];
            CGRect imageViewFrame = imageViewFrameValue.CGRectValue;
            
            CGRect imageViewFrameToWindow = [self.superview convertRect:imageViewFrame toView:self.window];
            
            self.transitionImageView.frame = imageViewFrameToWindow;
        }
        
    } completion:^(BOOL finished) {
    
        [self.transitionImageView removeFromSuperview];
        self.transitionImageView = nil;
    }];
}

- (void)imageZoomScrollViewDoubleTap:(UITapGestureRecognizer *)tap
{
    UIScrollView * imageZoomScrollView = (UIScrollView *)tap.view;
    
    if (imageZoomScrollView.zoomScale > MAX_ZOOM_SCALE/2) {
        [imageZoomScrollView setZoomScale:1 animated:YES];
    }
    else {
        [imageZoomScrollView setZoomScale:MAX_ZOOM_SCALE animated:YES];
//        CGPoint tapLocation = [tap locationInView:tap.view];
//        CGPoint newContentOffset = CGPointMake(tapLocation.x * (MAX_ZOOM_SCALE - 1), tapLocation.y * (MAX_ZOOM_SCALE - 1));
//        newContentOffset.x = MIN(W(imageZoomScrollView) * (MAX_ZOOM_SCALE - 1), newContentOffset.x);
//        newContentOffset.x = MAX(0, newContentOffset.x);
//        newContentOffset.y = MIN(H(imageZoomScrollView) * (MAX_ZOOM_SCALE - 1), newContentOffset.y);
//        newContentOffset.y = MAX(0, newContentOffset.y);
//        
//        [UIView animateWithDuration:TRANSITION_ANIMATION_DURATION animations:^{
//            imageZoomScrollView.zoomScale = MAX_ZOOM_SCALE;
//            imageZoomScrollView.contentOffset = newContentOffset;
//        } completion:^(BOOL finished) {
//            
//        }];
    }
}

- (void)imageZoomScrollViewLongPress:(UILongPressGestureRecognizer *)longPress
{
    if (longPress.state != UIGestureRecognizerStateEnded) {
        return;
    }
    
    UIScrollView * imageZoomScrollView = (UIScrollView *)longPress.view;
    
    for (UIView * subV in imageZoomScrollView.subviews) {
        
        if ([subV isKindOfClass:[UIImageView class]]) {
            UIImageView * imageView = (UIImageView *)subV;
            _waitToSaveImage = imageView.image;
            
            UIActionSheet * saveImageActionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"保存图片" otherButtonTitles:nil, nil];
            [saveImageActionSheet showInView:self.window];
            break;
        }
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            ALAssetsLibrary * assetsLibrary = [[ALAssetsLibrary alloc]init];
            
            [assetsLibrary writeImageToSavedPhotosAlbum:_waitToSaveImage.CGImage orientation:(ALAssetOrientation)self.image.imageOrientation completionBlock:^(NSURL *assetURL, NSError *error) {
                if (error) {
                    NSLog(@"保存相片到本地相册失败 assetURL = %@,error = %@", assetURL,error.localizedDescription);//
                }
                else {
                    NSLog(@"保存相片到本地相册成功 assetURL = %@", assetURL);//
                }
            }];
        }
            break;
        case 1:
        {
        //    DBLog(@"");
        }
            break;
        default:
            break;
    }
}

- (void)setImageURLStringArray:(NSArray *)imageURLStringArray
{
    if (_imageURLStringArray != imageURLStringArray) {
        
        NSMutableArray *array = [[NSMutableArray alloc]init];
        for(int i=0 ;i<imageURLStringArray.count; i++){
            if ([EttUtils getPictureBig:imageURLStringArray[i]] != nil) {
                [array addObject:[EttUtils getPictureBig:imageURLStringArray[i]]];
            }
        }
        
        _imageURLStringArray = imageURLStringArray;
        _bigImageURLStringArray = array;
        self.pageControl.numberOfPages = imageURLStringArray.count;
    }
}

- (void)setCurrentImageIndex:(NSInteger)currentImageIndex
{
    _currentImageIndex = currentImageIndex;
    self.pageControl.currentPage = currentImageIndex;
    CGPoint backgroundScrollViewContentOffset = self.backgroundScrollView.contentOffset;
    backgroundScrollViewContentOffset.x = self.backgroundScrollView.frame.size.width * currentImageIndex;
    self.backgroundScrollView.contentOffset = backgroundScrollViewContentOffset;
}

- (NSInteger)currentImageIndex
{
    return _currentImageIndex;
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    if (scrollView == self.backgroundScrollView) {
        return nil;
    }
    else {
        
//        UIImageView * imageView = nil;
//        for (UIView * subV in scrollView.subviews) {
//            if ([subV isKindOfClass:[UIImageView class]]) {
//                imageView = (UIImageView *)subV;
//                break;
//            }
//        }
//        scrollView.frame = imageView.imageFrame;
//        imageView.frame = scrollView.bounds;
//        return imageView;
        
        for (UIView * subV in scrollView.subviews) {
            if ([subV isKindOfClass:[UIImageView class]]) {
                return subV;
            }
        }
        return nil;
    }
    return nil;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView != self.backgroundScrollView) {
        return;
    }

    self.pageControl.currentPage = (NSInteger)(self.backgroundScrollView.contentOffset.x / self.backgroundScrollView.frame.size.width);
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView != self.backgroundScrollView || decelerate) {
        return;
    }
    
    self.pageControl.currentPage = (NSInteger)(self.backgroundScrollView.contentOffset.x / self.backgroundScrollView.frame.size.width);
}

@end
