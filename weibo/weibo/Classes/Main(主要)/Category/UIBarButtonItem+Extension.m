//
//  UIBarButtonItem+Extension.m
//  weibo
//
//  Created by yoga on 15/8/24.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highlightedImageName:(NSString *)highlightedImageName target:(id)target action:(SEL)action
{
    
    // 设置导航栏按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
    // 设置按钮的尺寸为背景图片的尺寸
    button.size = button.currentBackgroundImage.size;
    // 监听按钮点击
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}


@end
