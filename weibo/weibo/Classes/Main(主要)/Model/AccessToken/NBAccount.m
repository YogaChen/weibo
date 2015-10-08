//
//  NBAccount.m
//  weibo
//
//  Created by yoga on 15/8/27.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import "NBAccount.h"

@implementation NBAccount

//+ (instancetype)accountWithDict:(NSDictionary *)dict
//{
//    NBAccount *account = [[self alloc] init];
//    account.access_token = dict[@"access_token"];
//    account.expires_in = dict[@"expires_in"];
//    account.uid = dict[@"uid"];
//    // 确定帐号的过期时间 ： 帐号创建时间 + 有效期
//    NSDate *now = [NSDate date];
//    account.expires_time = [now dateByAddingTimeInterval:account.expires_in.doubleValue];
//    
//    return account;
//}

- (void)setExpires_in:(NSString *)expires_in
{
    _expires_in = [expires_in copy];
    
    // accountWithDict方法没有调用所以expires_time没有值，读取账号的时候会读到空（accout = nil）,所以重写setExpires_in方法
//    NSDate *now = [NSDate date];
//    if ([now compare:account.expires_time] != NSOrderedAscending){ // 过期
//        account = nil;
//    }
    // 确定帐号的过期时间 ： 帐号创建时间 + 有效期
    NSDate *now = [NSDate date];
    self.expires_time = [now dateByAddingTimeInterval:self.expires_in.doubleValue];
}

/**
 *  当从文件中解析出一个对象的时候调用
 *  在这个方法中写清楚：怎么解析文件中的数据
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.expires_in = [decoder decodeObjectForKey:@"expires_in"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.expires_time = [decoder decodeObjectForKey:@"expires_time"];
        self.name = [decoder decodeObjectForKey:@"name"];
    }
    return self;
}

/**
 *  将对象写入文件的时候调用
 *  在这个方法中写清楚：要存储哪些对象的哪些属性，以及怎样存储属性
 */

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeObject:self.expires_in forKey:@"expires_in"];
    [encoder encodeObject:self.uid forKey:@"uid"];
    [encoder encodeObject:self.expires_time forKey:@"expires_time"];
    [encoder encodeObject:self.name forKey:@"name"];
}

@end
