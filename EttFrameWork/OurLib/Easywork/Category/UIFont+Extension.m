//
//  UIFont+Extension.m
//  ETTParents
//
//  Created by Jin on 15-3-5.
//  Copyright (c) 2015年 kingxl. All rights reserved.
//

#import "UIFont+Extension.h"

@implementation UIFont (Extension)

- (CGFloat)ew_lineHeight
{
    return (self.ascender-self.descender) + 1;
}
@end
