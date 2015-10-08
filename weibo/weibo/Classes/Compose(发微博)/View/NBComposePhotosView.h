//
//  NBComposePhotosView.h
//  weibo
//
//  Created by yoga on 15/8/30.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NBComposePhotosView : UIView

/**
 *  添加一张图片到相册内部
 *
 *  @param image 新添加的图片
 */
- (void)addImage:(UIImage *)image;

- (NSArray *)image;

@end
