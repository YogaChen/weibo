//
//  NBHomeStatusesResult.m
//  weibo
//
//  Created by yoga on 15/8/31.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import "NBHomeStatusesResult.h"
#import "MJExtension.h"
#import "NBStatus.h"

@implementation NBHomeStatusesResult

- (NSDictionary *)objectClassInArray
{
    return @{@"statuses" : [NBStatus class]};
}

@end
