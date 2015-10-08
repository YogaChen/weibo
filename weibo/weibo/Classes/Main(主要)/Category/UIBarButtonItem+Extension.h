//
//  UIBarButtonItem+Extension.h
//  weibo
//
//  Created by yoga on 15/8/24.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highlightedImageName:(NSString *)highlightedImageName target:(id)target action:(SEL)action;

@end
