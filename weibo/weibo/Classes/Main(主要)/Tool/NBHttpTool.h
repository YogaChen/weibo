//
//  NBHttpTool.h
//  weibo
//
//  Created by yoga on 15/8/31.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//  网络请求工具类：负责整个项目的所有HTTP请求

#import <Foundation/Foundation.h>

@interface NBHttpTool : NSObject

/**
 *  发送一个GET请求
 *
 *  @param urlStr     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)get:(NSString *)urlStr params:(NSDictionary *)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

/**
 *  发送一个POST请求
 *
 *  @param urlStr     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
+ (void)post:(NSString *)urlStr params:(NSDictionary *)params success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


//void test()
//{
//    
//    void (^success)(id) = ^(id responseObj) {
//        
//    };
//    
//    int (^sum)(int, int) = ^(int a, int b){
//        return a + b;
//    };
//}
@end
