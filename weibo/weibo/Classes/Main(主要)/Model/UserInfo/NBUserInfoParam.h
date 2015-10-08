//
//  NBUserInfoParam.h
//  weibo
//
//  Created by yoga on 15/8/31.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import "NBBaseParam.h"

@interface NBUserInfoParam :NBBaseParam

/** false	int64	需要查询的用户ID。*/
@property (nonatomic, copy) NSString *uid;

@end
