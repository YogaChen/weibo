//
//  NBBaseTool.m
//  weibo
//
//  Created by yoga on 15/8/31.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import "NBBaseTool.h"
#import "NBHttpTool.h"
#import "MJExtension.h"

@implementation NBBaseTool

+ (void)getWithUrlStr:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSDictionary *params = [param keyValues];
    [NBHttpTool get:url params:params success:^(id responseObject) {
        if (success) {
            id result = [resultClass objectWithKeyValues:responseObject];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postWithUrlStr:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSDictionary *params = [param keyValues];
    [NBHttpTool post:url params:params success:^(id responseObject) {
        if (success) {
            id result = [resultClass objectWithKeyValues:responseObject];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
