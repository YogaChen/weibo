//
//  NBStatus.m
//  weibo
//
//  Created by yoga on 15/8/27.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import "NBStatus.h"
#import "MJExtension.h"
#import "NBPhoto.h"
#import "NSDate+MJ.h"

@implementation NBStatus

- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls": [NBPhoto class]};
}

/**
 一、今年
 1、今天
 1分钟内：刚刚
 1个小时内：xx分钟前
 
 2、昨天
 昨天 xx:xx
 
 3、至少是前天发的
 04-23 xx:xx
 
 二、非今年
 2012-07-24
 */
// _created_at == Mon Jul 14 15:48:07 +0800 2014
// Mon Jul 14 15:48:07 +0800 2014 -> NSDate -> 2014-07-14 15:48:07
- (NSString *)created_at
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
//    [fmt setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
//    [fmt setDateFormat:@"EEE MMM dd HH:mm:ss Z yyyy"];
    // 获得微博发布的具体时间
    NSDate *createDate = [fmt dateFromString:_created_at];
    
    // 判断是否为今年
    if (createDate.isThisYear) {
        if (createDate.isToday) { // 今天
            NSDateComponents *cmps = [createDate deltaWithNow];
            if (cmps.hour >= 1) { // 至少是1小时前发的
                return [NSString stringWithFormat:@"%d小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1~59分钟之前发的
                return [NSString stringWithFormat:@"%d分钟前", cmps.minute];
            } else { // 1分钟内发的
                return @"刚刚";
            }
        } else if (createDate.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        } else { // 至少是前天
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd";
        return [fmt stringFromDate:createDate];
    }
}

// _source == <a href="http://weibo.com/" rel="nofollow">微博 weibo.com</a>
// destSource = 来自微博 weibo.com
//- (NSString *)source   // tableview 每次滚动都会调用  这样会很消耗性能,改用setter
- (void)setSource:(NSString *)source
{
//    NBLog(@"source");
    // 截取范围
    NSRange range;
    range.location = [source rangeOfString:@">"].location + 1;
    range.length = [source rangeOfString:@"</"].location - range.location;
    // 开始截取
    NSString *subsource = [source substringWithRange:range];
    // 头部拼接一个“来自”
    _source = [NSString stringWithFormat:@"来自%@", subsource];
}

/**
 NSCalendar *calendar = [NSCalendar currentCalendar];
 // 获得日期的所有元素
 NSDateComponents *cmps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:createDate];
 
 HMLog(@"%d %d %d", cmps.year, cmps.month, cmps.day);
 
 // 转换成其他格式
 fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
 NSString *timeStr = [fmt stringFromDate:createDate];
 */


@end
