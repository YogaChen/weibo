//
//  NBPhoto.m
//  weibo
//
//  Created by yoga on 15/8/27.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import "NBPhoto.h"

@implementation NBPhoto

- (void)setThumbnail_pic:(NSString *)thumbnail_pic
{
    _thumbnail_pic = [thumbnail_pic copy];
    
//    NBLog(@"%@", thumbnail_pic);
    self.bmiddle_pic = [thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
}

@end
