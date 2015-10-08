//
//  NBStatusRetweetedView.m
//  weibo
//
//  Created by yoga on 15/9/3.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import "NBStatusRetweetedView.h"
#import "NBStatusRetweetedFrame.h"
#import "NBStatus.h"
#import "NBUser.h"
#import "NBStatusPhotosView.h"

@interface NBStatusRetweetedView()

/**  昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 正文 */
@property (nonatomic, weak) UILabel *textLabel;
/** 配图相册 */
@property (nonatomic, weak) NBStatusPhotosView *photosView;

@end

@implementation NBStatusRetweetedView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizeImageWithNamed:@"timeline_retweet_background"];
//        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithNamed:@"timeline_retweet_background"]];  // 直接平铺会有一条横线，因为图片小的缘故
        
        // 1.昵称
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.textColor = NBColor(74, 102, 105);
        nameLabel.font = NBStatusRetweetedNameFont;
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        // 2.正文（内容）
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.font = NBStatusRetweetedTextFont;
        textLabel.numberOfLines = 0;
        [self addSubview:textLabel];
        self.textLabel = textLabel;
        
        // 3.配图相册
        NBStatusPhotosView *photosView = [[NBStatusPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;
    }
    return self;
}

- (void)setRetweetedFrame:(NBStatusRetweetedFrame *)retweetedFrame
{
    _retweetedFrame = retweetedFrame;
    
    self.frame = retweetedFrame.frame;
    
    // 取出微博数据
    NBStatus *retweetedStatus = retweetedFrame.retweetedStatus;
    // 取出用户数据
    NBUser *user = retweetedStatus.user;
    
    // 1.昵称
    self.nameLabel.text = [NSString stringWithFormat:@"@%@", user.name];
    self.nameLabel.frame = retweetedFrame.nameFrame;
    
    // 2.正文（内容）
    self.textLabel.text = retweetedStatus.text;
    self.textLabel.frame = retweetedFrame.textFrame;
    
    // 3.配图相册
    if (retweetedStatus.pic_urls.count) { // 有配图
        self.photosView.frame = retweetedFrame.photosFrame;
        self.photosView.pic_urls = retweetedStatus.pic_urls;
        self.photosView.hidden = NO;
    } else {
        self.photosView.hidden = YES;
    }
}

@end
