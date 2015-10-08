//
//  NBHomeStatusesResult.h
//  weibo
//
//  Created by yoga on 15/8/31.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NBHomeStatusesResult : NSObject

/** 微博数组（装着NBStatus模型） */
@property (nonatomic, strong) NSArray *statuses;

/** 近期的微博总数 */
@property (nonatomic, assign) int total_number;

@end
