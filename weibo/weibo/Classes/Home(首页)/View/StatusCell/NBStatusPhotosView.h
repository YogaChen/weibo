//
//  NBStatusPhotosView.h
//  weibo
//
//  Created by yoga on 15/9/4.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//  微博cell里面的相册 -- 里面包含N个NBStatusPhotoView

#import <UIKit/UIKit.h>

@interface NBStatusPhotosView : UIView

/**
 *  图片数据（里面都是NBPhoto模型）
 */
@property (nonatomic, strong) NSArray *pic_urls;

/**
 *  根据图片个数计算相册的最终尺寸
 */
+ (CGSize)sizeWithPhotosCount:(int)photosCount;

@end
