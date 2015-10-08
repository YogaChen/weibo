//
//  NBStatusRetweetedView.h
//  weibo
//
//  Created by yoga on 15/9/3.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NBStatusRetweetedFrame;

@interface NBStatusRetweetedView : UIImageView

@property (nonatomic, strong) NBStatusRetweetedFrame *retweetedFrame;

// 设置转发微博的背景的方法1， 方法二是继承UIImageView，设置image
//- (void)setFrame:(CGRect)frame
//{
//    [super setFrame:frame];
//
//    [self setNeedsDisplay];
//}
//
//- (void)drawRect:(CGRect)rect
//{
//    [[UIImage resizedImage:@"timeline_retweet_background"] drawInRect:rect];
//}

@end
