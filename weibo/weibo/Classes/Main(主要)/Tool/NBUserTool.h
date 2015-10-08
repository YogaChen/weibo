//
//  NBUserTool.h
//  weibo
//
//  Created by yoga on 15/8/31.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import "NBBaseTool.h"
#import "NBUserInfoParam.h"
#import "NBUserInfoResult.h"
#import "NBUnreadCountParam.h"
#import "NBUnreadCountResult.h"

@interface NBUserTool : NBBaseTool

/**
 *  加载用户的个人信息
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)userInfoWithParam:(NBUserInfoParam *)param success:(void (^)(NBUserInfoResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  获取消息未读数
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)unreadCountWithParm:(NBUnreadCountParam *)param success:(void (^)(NBUnreadCountResult *result))success failure:(void (^)(NSError *error))failure;

@end
