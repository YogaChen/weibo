//
//  NBBaseTool.h
//  weibo
//
//  Created by yoga on 15/8/31.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NBBaseTool : NSObject

+ (void)getWithUrlStr:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *error))failure;

+ (void)postWithUrlStr:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *error))failure;

@end
