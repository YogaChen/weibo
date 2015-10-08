
//
//  NBStatusTool.m
//  weibo
//
//  Created by yoga on 15/8/31.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import "NBStatusTool.h"


@implementation NBStatusTool

+ (void)homeStatusesWithParam:(NBHomeStatusesParam *)param success:(void (^)(NBHomeStatusesResult *))success failure:(void (^)(NSError *))failure
{
    [self getWithUrlStr:@"https://api.weibo.com/2/statuses/home_timeline.json" param:param resultClass:[NBHomeStatusesResult class] success:success failure:failure];
}

+ (void)sendStatusWithParam:(NBSendStatusParam *)param success:(void (^)(NBSendStatusResult *))success failure:(void (^)(NSError *))failure
{
    [self postWithUrlStr:@"https://api.weibo.com/2/statuses/update.json" param:param resultClass:[NBSendStatusResult class] success:success failure:failure];
}

@end
