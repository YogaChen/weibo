//
//  NBStatusDetailView.m
//  weibo
//
//  Created by yoga on 15/9/3.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import "NBStatusDetailView.h"
#import "NBStatusRetweetedView.h"
#import "NBStatusOriginalView.h"
#import "NBStatusDetailFrame.h"

@interface NBStatusDetailView()

@property (nonatomic, weak) NBStatusOriginalView *originalView;
@property (nonatomic, weak) NBStatusRetweetedView *retweetedView;

@end

@implementation NBStatusDetailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) { // 初始化子控件
        // 1.添加原创微博
        NBStatusOriginalView *originalView = [[NBStatusOriginalView alloc] init];
        [self addSubview:originalView];
        self.originalView = originalView;
        
        // 2.添加转发微博
        NBStatusRetweetedView *retweetedView = [[NBStatusRetweetedView alloc] init];
        [self addSubview:retweetedView];
        self.retweetedView = retweetedView;
    }
    return self;
}

- (void)setDetailFrame:(NBStatusDetailFrame *)detailFrame
{
    _detailFrame = detailFrame;
    
    self.frame = detailFrame.frame;
    
    // 1.原创微博的frame数据
    self.originalView.originalFrame = detailFrame.originalFrame;
    
    // 2.原创转发的frame数据
    self.retweetedView.retweetedFrame = detailFrame.retweetedFrame;
}

@end
