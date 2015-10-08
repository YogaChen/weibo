//
//  NBTitleButton.m
//  weibo
//
//  Created by yoga on 15/8/25.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import "NBTitleButton.h"

@implementation NBTitleButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 内部图标居中
        self.imageView.contentMode = UIViewContentModeCenter;
        // 文字对齐
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        // 文字颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // 字体
        self.titleLabel.font = NBNavigationTitleFont;
        // 高亮的时候不需要调整内部的图片为灰色
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    CGFloat titleH = self.height;
    CGFloat titleW = self.width - titleH;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageH = self.height;
    CGFloat imageW = imageH;
    CGFloat imageX = self.width - imageW;
    CGFloat imageY = 0;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    // 1.计算文字的尺寸
    CGSize titleSize = [title sizeWithFont:self.titleLabel.font];
    
    // 2.计算按钮的宽度
    self.width = titleSize.width + self.height + 10;
}

@end
