//
//  NBStatusPhotoView.m
//  weibo
//
//  Created by yoga on 15/9/4.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import "NBStatusPhotoView.h"
#import "NBPhoto.h"
#import "UIImageView+WebCache.h"

@interface NBStatusPhotoView ()

@property (nonatomic , weak) UIImageView *gifView;

@end

@implementation NBStatusPhotoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
        
        // 添加gif图片
        UIImage *gifImage = [UIImage imageWithNamed:@"timeline_image_gif"];
        // 这种情况下创建的UIImageView的尺寸跟图片尺寸一样
        UIImageView *gifView = [[UIImageView alloc] initWithImage:gifImage];
        [self addSubview:gifView];
        self.gifView = gifView;
    }
    return self;
}

- (void)setPhoto:(NBPhoto *)photo
{
    _photo = photo;
    
    // 1.下载图片
    [self setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageWithNamed:@"timeline_image_placeholder"]];
    
    // 2.判断图片缩略图是否gif格式来决定是否显示
    NSString *extension = photo.thumbnail_pic.pathExtension.lowercaseString;
    self.gifView.hidden = ![extension isEqualToString:@"gif"];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
}

@end
