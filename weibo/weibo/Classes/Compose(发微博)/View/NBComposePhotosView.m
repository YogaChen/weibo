//
//  NBComposePhotosView.m
//  weibo
//
//  Created by yoga on 15/8/30.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import "NBComposePhotosView.h"

@implementation NBComposePhotosView

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    // 一行的最大列数
    int maxColsPerRow = 4;
    
    // 每个图片之间的间距
    CGFloat margin = 10;
    
    // 每个图片的宽高
    CGFloat imageViewW = (self.width - (maxColsPerRow + 1) * margin) / maxColsPerRow;
    CGFloat imageViewH = imageViewW;
    
    for (int i = 0; i < count; i++) {
        // 行号
        int row = i / maxColsPerRow;
        // 列号
        int col = i % maxColsPerRow;
        
        UIImageView *imageView = self.subviews[i];
        imageView.width = imageViewW;
        imageView.height = imageViewH;
        imageView.y = row * (imageViewH + margin);
        imageView.x = col * (imageViewW + margin) + margin;
    }
}


- (void)addImage:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.image = image;
    [self addSubview:imageView];
}

- (NSArray *)image
{
    NSMutableArray *arrayM = [NSMutableArray array];
    for (UIImageView *iconView in self.subviews) {
        [arrayM addObject:iconView.image];
    }
    return arrayM;
}

@end
