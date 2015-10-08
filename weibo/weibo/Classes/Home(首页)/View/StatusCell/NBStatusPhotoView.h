//
//  NBStatusPhotoView.h
//  weibo
//
//  Created by yoga on 15/9/4.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//  一个NBStatusPhotoView代表1张配图

#import <UIKit/UIKit.h>

@class NBPhoto;

@interface NBStatusPhotoView : UIImageView

@property (nonatomic, strong) NBPhoto *photo;

@end
