//
//  UITabBarController+Rotate.m
//  四中网校-ios
//
//  Created by 老岳 on 15-1-6.
//  Copyright (c) 2015年 老岳. All rights reserved.
//

#import "UITabBarController+Rotate.h"

@implementation UITabBarController (Rotate)
//ios5.X
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
}

//ios6.X and later
- (BOOL)shouldAutorotate
{
//    return YES;
    if (self.childViewControllers.firstObject) {
        return YES;
    }else{
        return NO;
    }
}


@end
