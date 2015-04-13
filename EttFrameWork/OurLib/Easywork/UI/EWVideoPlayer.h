//
//  EWVideoPlayer.h
//  Easywork
//
//  Created by Jin on 15-1-16.
//  Copyright (c) 2015年 kingxl. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, EWVideoPlayerStatus)
{
    EWVideoPlayerStatusDidPause = 0,
    EWVideoPlayerStatusDidResume,
    EWVideoPlayerStatusDidEndPlaying,
    EWVideoPlayerStatusDidEnterFullScreen,
    EWVideoPlayerStatusDidLeaveFullScreen
};


@interface EWVideoPlayer : UIView

@property (nonatomic, strong) NSURL *path;
//@property (nonatomic, weak) id<>

@end

@protocol EWVideoPlayerDelegate <NSObject>

@optional



@end
