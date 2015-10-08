//
//  NBStatusDetailFrame.m
//  weibo
//
//  Created by yoga on 15/9/3.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import "NBStatusDetailFrame.h"
#import "NBStatus.h"
#import "NBStatusOriginalFrame.h"
#import "NBStatusRetweetedFrame.h"

@implementation NBStatusDetailFrame

- (void)setStatus:(NBStatus *)status
{
    _status = status;
    
    // 1.计算原创微博的frame
    NBStatusOriginalFrame *originalFrame = [[NBStatusOriginalFrame alloc] init];
    originalFrame.status = status;
    self.originalFrame = originalFrame;
    
    // 2.计算转发微博的frame
    CGFloat h = 0;
    if (status.retweeted_status) {
        NBStatusRetweetedFrame *retweetedFrame = [[NBStatusRetweetedFrame alloc] init];
        retweetedFrame.retweetedStatus = status.retweeted_status;
        
        // 计算转发微博frame的y值
        CGRect f = retweetedFrame.frame;
        f.origin.y = CGRectGetMaxY(originalFrame.frame);
        retweetedFrame.frame = f;
        
        self.retweetedFrame = retweetedFrame;
        
        h = CGRectGetMaxY(retweetedFrame.frame);
    } else {
        h = CGRectGetMaxY(originalFrame.frame);
    }
    
    // 自己的frame
    CGFloat x = 0;
    CGFloat y = NBStatusCellInset;
    CGFloat w = NBScreenW;
    self.frame = CGRectMake(x, y, w, h);
}

@end

