//
//  VerticallyAlignedLabel.h
//  四中网校-ios
//
//  Created by 老岳 on 14-8-25.
//  Copyright (c) 2014年 老岳. All rights reserved.
//
//  顶端对齐的label

#import <Foundation/Foundation.h>

typedef enum VerticalAlignment {
    VerticalAlignmentTop,
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;

@interface VerticallyAlignedLabel : UILabel {
@private
    VerticalAlignment verticalAlignment_;
}

@property (nonatomic, assign) VerticalAlignment verticalAlignment;

@end