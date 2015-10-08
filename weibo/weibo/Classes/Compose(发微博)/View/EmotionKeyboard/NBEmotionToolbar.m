//
//  NBEmotionToolbar.m
//  weibo
//
//  Created by yoga on 15/10/7.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import "NBEmotionToolbar.h"

int const NBEmotionToolbarButtonMaxCount = 4;

@interface NBEmotionToolbar()

/** 记录当前选中的按钮 */
@property (nonatomic, weak) UIButton *selectedButton;

@end

@implementation NBEmotionToolbar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.添加4个按钮
        [self setupButton:@"最近" tag:NBEmotionTypeRecent];
        UIButton *defaultButton = [self setupButton:@"默认" tag:NBEmotionTypeDefault];
        [self setupButton:@"Emoji" tag:NBEmotionTypeEmoji];
        [self setupButton:@"浪小花" tag:NBEmotionTypeLxh];
        
        // 2.默认选中“默认”按钮
        [self buttonClick:defaultButton];
    }
    return self;
}

/**
 *  添加按钮
 *
 *  @param title 按钮文字
 */
- (UIButton *)setupButton:(NSString *)title tag:(NBEmotionType)tag
{
    UIButton *button = [[UIButton alloc] init];
    button.tag = tag;
    
    // 文字
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    
    // 添加按钮
    [self addSubview:button];
    
    // 设置背景图片
    NSUInteger count = self.subviews.count;
    if (count == 1) { // 第一个按钮
        [button setBackgroundImage:[UIImage resizeImageWithNamed:@"compose_emotion_table_left_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage resizeImageWithNamed:@"compose_emotion_table_left_selected"] forState:UIControlStateSelected];
    } else if (count == NBEmotionToolbarButtonMaxCount) { // 最后一个按钮
        [button setBackgroundImage:[UIImage resizeImageWithNamed:@"compose_emotion_table_right_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage resizeImageWithNamed:@"compose_emotion_table_right_selected"] forState:UIControlStateSelected];
    } else { // 中间按钮
        [button setBackgroundImage:[UIImage resizeImageWithNamed:@"compose_emotion_table_mid_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage resizeImageWithNamed:@"compose_emotion_table_mid_selected"] forState:UIControlStateSelected];
    }
    
    return button;
}

/**
 *  监听工具条按钮点击
 */
- (void)buttonClick:(UIButton *)button
{
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    
    // 2.通知代理
    if ([self.delegate respondsToSelector:@selector(emotionToolbar:didSelectedButton:)]) {
        [self.delegate emotionToolbar:self didSelectedButton:button.tag];
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.设置工具条按钮的frame
    CGFloat buttonW = self.width / NBEmotionToolbarButtonMaxCount;
    CGFloat buttonH = self.height;
    for (int i = 0; i < NBEmotionToolbarButtonMaxCount; i++) {
        UIButton *button = self.subviews[i];
        button.width = buttonW;
        button.height = buttonH;
        button.x = i * buttonW;
    }
}


@end
