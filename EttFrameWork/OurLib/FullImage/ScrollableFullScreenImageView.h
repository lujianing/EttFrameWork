//
//  ScrollableFullScreenImageView.h
//  ScrollableFullScreenImageViewDemo
//
//  Created by lixian on 15-3-12.   
//

#import <UIKit/UIKit.h>

@interface ScrollableFullScreenImageView : UIImageView

@property (nonatomic,retain) NSArray * imageURLStringArray;
@property (nonatomic,retain) NSMutableArray * imageViewFrameArray;
@property (nonatomic,assign) NSInteger currentImageIndex;

@end
