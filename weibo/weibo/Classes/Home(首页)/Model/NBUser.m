//
//  NBUser.m
//  weibo
//
//  Created by yoga on 15/8/27.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import "NBUser.h"

@implementation NBUser

- (BOOL)isVip
{
    // 是会员
    return self.mbtype > 2;
}

@end
