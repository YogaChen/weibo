//
//  NBLoadMoreFooter.h
//  weibo
//
//  Created by yoga on 15/8/28.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NBLoadMoreFooter : UIView

+ (instancetype)footer;

- (void)beginRefreshing;
- (void)endRefreshing;

@property (nonatomic, assign, getter = isRefreshing) BOOL refreshing;

@end
