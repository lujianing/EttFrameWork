//
//  EWShareSheet.h
//  EasyWork
//
//  Created by Jin on 15-1-26.
//  Copyright (c) 2015年 kingxl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EWShareSheetCell;

@protocol EWShareSheetDelegate <NSObject>

- (NSInteger)numberOfItemsInShareSheet;
- (EWShareSheetCell*)cellForItemAtIndex:(NSInteger)index;
- (void)didSelectedItemAtIndex:(NSInteger)index;

@end

@interface EWShareSheet : UIWindow

-(instancetype)initWithDelegate:(id<EWShareSheetDelegate>)delegate count:(NSInteger)count;
- (void)show;

@property (nonatomic, strong) UIButton *collect;
@property (nonatomic, assign) BOOL showCollect;

@end


@interface EWShareSheetCell : UIView
@property (nonatomic, strong) UIImageView* iconView;
@property (nonatomic, strong) UILabel*     titleLabel;
@property (nonatomic, assign) NSInteger          index;
@end