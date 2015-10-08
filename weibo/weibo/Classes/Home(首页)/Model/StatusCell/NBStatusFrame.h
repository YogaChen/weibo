//
//  NBStatusFrame.h
//  weibo
//
//  Created by yoga on 15/9/3.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//  一个frame包括一个cell内部所有子控件的fame数据和显示数据

#import <Foundation/Foundation.h>

@class NBStatus, NBStatusDetailFrame;

@interface NBStatusFrame : NSObject

/** 子控件的frame数据 */
@property (nonatomic, assign) CGRect toolbarFrame;
@property (nonatomic, strong) NBStatusDetailFrame *detailFrame;

/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;

/** 微博数据 */
@property (nonatomic, strong) NBStatus *status;

@end
