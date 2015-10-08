//
//  NBStatusToolbar.h
//  weibo
//
//  Created by yoga on 15/9/3.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//  封装每条微博cell底部的工具条

#import <UIKit/UIKit.h>

@class NBStatus;

@interface NBStatusToolbar : UIImageView

@property (nonatomic, strong) NBStatus *status;

@end
