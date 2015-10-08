//
//  NBStatusRetweetedFrame.m
//  weibo
//
//  Created by yoga on 15/9/3.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import "NBStatusRetweetedFrame.h"
#import "NBStatus.h"
#import "NBUser.h"
#import "NBStatusPhotosView.h"

@implementation NBStatusRetweetedFrame

- (void)setRetweetedStatus:(NBStatus *)retweetedStatus
{
    _retweetedStatus = retweetedStatus;
    
    // 1.昵称
    CGFloat nameX = NBStatusCellInset;
    CGFloat nameY = NBStatusCellInset * 0.5;
    NSString *name = [NSString stringWithFormat:@"@%@", retweetedStatus.user.name];
    CGSize nameSize = [name sizeWithFont:NBStatusRetweetedNameFont];
    self.nameFrame = (CGRect){{nameX, nameY}, nameSize};
    
    // 2.正文
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(self.nameFrame) + NBStatusCellInset * 0.5;
    CGFloat maxW = NBScreenW - 2 * textX;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    CGSize textSize = [retweetedStatus.text sizeWithFont:NBStatusRetweetedTextFont constrainedToSize:maxSize];
    self.textFrame = (CGRect){{textX, textY}, textSize};
    
    // 3.配图相册
    CGFloat h = 0;
    if (retweetedStatus.pic_urls.count) {
        CGFloat photosX = textX;
        CGFloat photosY = CGRectGetMaxY(self.textFrame) + NBStatusCellInset;
        CGSize photosViewSize = [NBStatusPhotosView sizeWithPhotosCount:(int)retweetedStatus.pic_urls.count];
        self.photosFrame = (CGRect){{photosX, photosY}, photosViewSize};
        
        h = CGRectGetMaxY(self.photosFrame) + NBStatusCellInset;
    } else {
        h = CGRectGetMaxY(self.textFrame) + NBStatusCellInset;
    }
    
    // 自己
    CGFloat x = 0;
    CGFloat y = 0; // 高度 = 原创微博最大的Y值
    CGFloat w = NBScreenW;
    self.frame = CGRectMake(x, y, w, h);
}

@end
