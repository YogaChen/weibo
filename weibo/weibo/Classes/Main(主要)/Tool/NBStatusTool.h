//
//  NBStatusTool.h
//  weibo
//
//  Created by yoga on 15/8/31.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//  微博业务类：处理跟微博相关的一切业务，比如加载微博数据、发微博、删微博

#import "NBBaseTool.h"
#import "NBHomeStatusesParam.h"
#import "NBHomeStatusesResult.h"
#import "NBSendStatusParam.h"
#import "NBSendStatusResult.h"

@interface NBStatusTool : NBBaseTool

/**
 *  加载首页的微博数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)homeStatusesWithParam:(NBHomeStatusesParam *)param success:(void (^)(NBHomeStatusesResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  发没有图片的微博
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)sendStatusWithParam:(NBSendStatusParam *)param success:(void (^)(NBSendStatusResult *result))success failure:(void (^)(NSError *error))failure;

@end
