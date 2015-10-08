//
//  UIImage+Extension.m
//  weibo
//
//  Created by yoga on 15/8/24.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+ (UIImage *)imageWithNamed:(NSString *)imageName
{
//    if (iOS7) {
//        imageName = [imageName stringByAppendingString:@"_os7"];
//    }
//    return [UIImage imageNamed:imageName];
    
    UIImage *image = nil;
    if (iOS7) { // 处理iOS7的情况
        NSString *newName = [imageName stringByAppendingString:@"_os7"];
        image = [UIImage imageNamed:newName];
    }
    
    if (image == nil) {
        image = [UIImage imageNamed:imageName];
    }
    return image;
    
}

+ (UIImage *)resizeImageWithNamed:(NSString *)imageName
{
    UIImage *image = [UIImage imageWithNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

@end
