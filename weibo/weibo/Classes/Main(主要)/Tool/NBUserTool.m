//
//  NBUserTool.m
//  weibo
//
//  Created by yoga on 15/8/31.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import "NBUserTool.h"

@implementation NBUserTool

+ (void)userInfoWithParam:(NBUserInfoParam *)param success:(void (^)(NBUserInfoResult *))success failure:(void (^)(NSError *))failure
{
    [self getWithUrlStr:@"https://api.weibo.com/2/users/show.json" param:param resultClass:[NBUserInfoResult class] success:success failure:failure];
    
//    NSDictionary *params = param.keyValues;
//    [NBHttpTool get:@"https://api.weibo.com/2/users/show.json" params:params success:^(id responseObject) {
//        if (success) {
//            NBUserInfoResult *userInfo = [NBUserInfoResult objectWithKeyValues:responseObject];
//            success(userInfo);
//        }
//    } failure:^(NSError *error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
}

+ (void)unreadCountWithParm:(NBUnreadCountParam *)param success:(void (^)(NBUnreadCountResult *))success failure:(void (^)(NSError *))failure
{
    [self getWithUrlStr:@"https://rm.api.weibo.com/2/remind/unread_count.json" param:param resultClass:[NBUnreadCountResult class] success:success failure:failure];
}

@end
