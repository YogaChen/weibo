//
//  NBHttpTool.m
//  weibo
//
//  Created by yoga on 15/8/31.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import "NBHttpTool.h"
#import "AFNetworking.h"
#import "NBAccountTool.h"
#import "NBAccount.h"

@implementation NBHttpTool

+ (void)get:(NSString *)urlStr params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.发送GET请求
    [mgr GET:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success){
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure){
            failure(error);
        }
    }];
    
}

+ (void)post:(NSString *)urlStr params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.发送POST请求
    [mgr POST:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success){
            success(responseObject);
            NBLog(@"POST");
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure){
            failure(error);
        }
    }];

}

@end
