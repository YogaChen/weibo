//
//  NBStatusRetweetedFrame.h
//  weibo
//
//  Created by yoga on 15/9/3.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NBStatus;

@interface NBStatusRetweetedFrame : NSObject

/** 昵称 */
@property (nonatomic, assign) CGRect nameFrame;
/** 正文 */
@property (nonatomic, assign) CGRect textFrame;
/** 配图相册  */
@property (nonatomic, assign) CGRect photosFrame;

/** 自己的frame */
@property (nonatomic, assign) CGRect frame;

/** 转发微博的数据 */
@property (nonatomic, strong) NBStatus *retweetedStatus;

@end
