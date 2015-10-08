//
//  NBPopMenu.h
//  weibo
//
//  Created by yoga on 15/8/26.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    NBPopMenuArrowPositionCenter = 0,
    NBPopMenuArrowPositionLeft = 1,
    NBPopMenuArrowPositionRight = 2
} NBPopMenuArrowPosition;

@class NBPopMenu;

@protocol NBPopMenuDelegate <NSObject>

@optional
- (void)popMenuDidDismissed:(NBPopMenu *)popMenu;

@end

@interface NBPopMenu : UIView

@property (nonatomic , weak) id <NBPopMenuDelegate> delegate;

@property (nonatomic, assign) NBPopMenuArrowPosition arrowPosition;

@property (nonatomic, assign, getter = isDimBackground) BOOL dimBackground;


/**
 *  初始化方法
 */
- (instancetype)initWithContentView:(UIView *)contentView;
+ (instancetype)popMenuWithContentView:(UIView *)contentView;

/**
 *  设置菜单的背景图片
 */
- (void)setBackground:(UIImage *)background;

/**
 *  显示菜单
 */
- (void)showInRect:(CGRect)rect;

/**
 *  关闭菜单
 */
- (void)dismiss;

@end
