//
//  NBAccountTool.h
//  weibo
//
//  Created by yoga on 15/8/27.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import "NBBaseTool.h"
#import "NBAccessTokenParam.h"

@class NBAccount;

@interface NBAccountTool : NBBaseTool
/**
 *  存储帐号
 */
+ (void)save:(NBAccount *)account;

/**
 *  读取帐号
 */
+ (NBAccount *)account;

/**
 *  获得accesToken
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)accessTokenWithParam:(NBAccessTokenParam *)param success:(void (^)(NBAccount *account))success failure:(void (^)(NSError *error))failure;

@end
