//
//  UIImageView+Tools.m
//  ETTParents
//
//  Created by Jin on 15-3-24.
//  Copyright (c) 2015年 etiantian. All rights reserved.
//

#import "UIImageView+Tools.h"

@implementation UIImageView (Tools)

- (CGRect)imageFrame
{
    CGFloat selfWidth = self.frame.size.width;
    CGFloat selfHeight = self.frame.size.height;
    CGFloat imageWidth = self.image.size.width;
    CGFloat imageHeight = self.image.size.height;
    
    CGRect imageFrame = self.bounds;
    
    switch (self.contentMode) {
        case UIViewContentModeScaleToFill:
        {
        
        }
            break;
        case UIViewContentModeScaleAspectFit:
        {
            if (imageWidth/imageHeight > selfWidth/selfHeight) {
                imageFrame.size.height = imageFrame.size.width * imageHeight/imageWidth;
                imageFrame.origin.y = (selfHeight - imageFrame.size.height) / 2;
            }
            else {
                imageFrame.size.width = imageFrame.size.height * imageWidth/imageHeight;
                imageFrame.origin.x = (selfWidth - imageFrame.size.width) / 2;
            }
        }
            break;
        case UIViewContentModeScaleAspectFill:
        {
            
        }
            break;
        case UIViewContentModeRedraw:
        {
            
        }
            break;
        case UIViewContentModeCenter:
        {
            
        }
            break;
        case UIViewContentModeTop:
        {
            
        }
            break;
        case UIViewContentModeBottom:
        {
            
        }
            break;
        case UIViewContentModeLeft:
        {
            
        }
            break;
        case UIViewContentModeRight:
        {
            
        }
            break;
        case UIViewContentModeTopLeft:
        {
            
        }
            break;
        case UIViewContentModeTopRight:
        {
            
        }
            break;
        case UIViewContentModeBottomLeft:
        {
            
        }
            break;
        case UIViewContentModeBottomRight:
        {
            
        }
            break;
        default:
            break;
    }
    return imageFrame;
}

@end
