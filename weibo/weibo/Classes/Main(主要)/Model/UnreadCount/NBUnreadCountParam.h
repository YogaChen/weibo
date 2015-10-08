//
//  NBUnreadCountParam.h
//  weibo
//
//  Created by yoga on 15/9/3.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import "NBBaseParam.h"

@interface NBUnreadCountParam : NBBaseParam

/** false	int64	需要查询的用户ID。*/
@property (nonatomic, copy) NSString *uid;

@end
