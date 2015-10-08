//
//  NBStatusOriginalFrame.m
//  weibo
//
//  Created by yoga on 15/9/3.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import "NBStatusOriginalFrame.h"
#import "NBStatus.h"
#import "NBUser.h"
#import "nbstatusPhotosView.h"

@implementation NBStatusOriginalFrame

- (void)setStatus:(NBStatus *)status
{
    _status = status;
    
    // 1.头像
    CGFloat iconX = NBStatusCellInset;
    CGFloat iconY = NBStatusCellInset;
    CGFloat iconW = 35;
    CGFloat iconH = 35;
    self.iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 2.昵称
    CGFloat nameX = CGRectGetMaxX(self.iconFrame) + NBStatusCellInset;
    CGFloat nameY = iconY;
    CGSize nameSize = [status.user.name sizeWithFont:NBStatusOrginalNameFont];
    self.nameFrame = (CGRect){{nameX, nameY}, nameSize};
    
    if (status.user.isVip) { // 计算会员图标的位置
        CGFloat vipX = CGRectGetMaxX(self.nameFrame) + NBStatusCellInset;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = vipH;
        self.vipFrame = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    // 3.时间
//    CGFloat timeX = nameX;
//    CGFloat timeY = CGRectGetMaxY(self.nameFrame) + NBStatusCellInset * 0.5;
//    CGSize timeSize = [status.created_at sizeWithFont:NBStatusOrginalTimeFont];
//    self.timeFrame = (CGRect){{timeX, timeY}, timeSize};
//    
//    // 4.来源
//    CGFloat sourceX = CGRectGetMaxX(self.timeFrame) + NBStatusCellInset * 0.5;
//    CGFloat sourceY = timeY;
//    CGSize sourceSize = [status.source sizeWithFont:NBStatusOrginalSourceFont];
//    self.sourceFrame = (CGRect){{sourceX, sourceY}, sourceSize};
    
    // 3.正文
    CGFloat textX = iconX;
    CGFloat textY = CGRectGetMaxY(self.iconFrame) + NBStatusCellInset;
    CGFloat maxW = NBScreenW - 2 * textX;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    CGSize textSize = [status.text sizeWithFont:NBStatusOrginalTextFont constrainedToSize:maxSize];
    self.textFrame = (CGRect){{textX, textY}, textSize};
    
    // 4.配图相册
    CGFloat h = 0;
    if (status.pic_urls.count) {
        CGFloat photosX = textX;
        CGFloat photosY = CGRectGetMaxY(self.textFrame) + NBStatusCellInset;
        CGSize photosViewSize = [NBStatusPhotosView sizeWithPhotosCount:(int)status.pic_urls.count];
//        CGFloat photosW = 300;
//        CGFloat photosH = 300;
        self.photosFrame = (CGRect){{photosX, photosY}, photosViewSize};
        
        h = CGRectGetMaxY(self.photosFrame) + NBStatusCellInset;
    } else {
        h = CGRectGetMaxY(self.textFrame) + NBStatusCellInset;
    }
    
    // 自己
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = NBScreenW;
    self.frame = CGRectMake(x, y, w, h);
}

@end
