//
//  NBEmotionToolbar.h
//  weibo
//
//  Created by yoga on 15/10/7.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//  表情底部的工具条

#import <UIKit/UIKit.h>


@class NBEmotionToolbar;

typedef enum {
    NBEmotionTypeRecent, // 最近
    NBEmotionTypeDefault, // 默认
    NBEmotionTypeEmoji, // Emoji
    NBEmotionTypeLxh // 浪小花
} NBEmotionType;

@protocol NBEmotionToolbarDelegate <NSObject>

@optional
- (void)emotionToolbar:(NBEmotionToolbar *)toolbar didSelectedButton:(NBEmotionType)emotionType;
@end


@interface NBEmotionToolbar : UIView

@property (nonatomic , weak) id<NBEmotionToolbarDelegate> delegate;

@end
