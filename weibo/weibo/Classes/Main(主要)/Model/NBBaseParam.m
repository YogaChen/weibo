//
//  NBBaseParam.m
//  weibo
//
//  Created by yoga on 15/8/31.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import "NBBaseParam.h"
#import "NBAccountTool.h"
#import "NBAccount.h"

@implementation NBBaseParam

- (id)init
{
    if (self = [super init]) {
        self.access_token = [NBAccountTool account].access_token;
    }
    return self;
}

+ (instancetype)param
{
    return [[self alloc] init];
}

@end
