//
//  NBStatusDetailFrame.h
//  weibo
//
//  Created by yoga on 15/9/3.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NBStatus, NBStatusOriginalFrame, NBStatusRetweetedFrame;

@interface NBStatusDetailFrame : NSObject

@property (nonatomic, strong) NBStatusOriginalFrame *originalFrame;
@property (nonatomic, strong) NBStatusRetweetedFrame *retweetedFrame;

/** 微博数据 */
@property (nonatomic, strong) NBStatus *status;

/** 自己的frame */
@property (nonatomic, assign) CGRect frame;

@end

