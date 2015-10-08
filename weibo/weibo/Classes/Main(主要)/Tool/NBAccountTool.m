//
//  NBAccountTool.m
//  weibo
//
//  Created by yoga on 15/8/27.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import "NBAccountTool.h"
#import "NBAccount.h"

#define NBAccountFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

@implementation NBAccountTool


+ (void)save:(NBAccount *)account
{
    // 归档
    [NSKeyedArchiver archiveRootObject:account toFile:NBAccountFilepath];

}

+ (NBAccount *)account
{
    // 读取帐号
    NBAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:NBAccountFilepath];
    
    // 判断帐号是否已经过期
    /**
     NSOrderedAscending = -1L,  升序，越往右边越大
     NSOrderedSame, 相等，一样
     NSOrderedDescending 降序，越往右边越小
     */
    NSDate *now = [NSDate date];
    if ([now compare:account.expires_time] != NSOrderedAscending){ // 过期
        account = nil;
    }
    
    return account;
}

+ (void)accessTokenWithParam:(NBAccessTokenParam *)param success:(void (^)(NBAccount *))success failure:(void (^)(NSError *))failure
{
    [self postWithUrlStr:@"https://api.weibo.com/oauth2/access_token" param:param resultClass:[NBAccount class] success:success failure:failure];
}

@end
