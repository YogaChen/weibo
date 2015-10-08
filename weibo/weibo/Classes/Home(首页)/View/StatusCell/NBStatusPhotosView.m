
//
//  NBStatusPhotosView.m
//  weibo
//
//  Created by yoga on 15/9/4.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import "NBStatusPhotosView.h"
#import "NBStatusPhotoView.h"
#import "UIImageView+WebCache.h"
#import "NBPhoto.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

#define NBStatusPhotosMaxCount 9
#define NBStatusPhotosMaxCols(photosCount) ((photosCount==4)?2:3)
#define NBStatusPhotoW 70
#define NBStatusPhotoH NBStatusPhotoW
#define NBStatusPhotoMargin 10

@interface NBStatusPhotosView ()

//@property (nonatomic , weak) UIImageView *imageView;
//@property (nonatomic, assign) CGRect lastFrame;

@end

@implementation NBStatusPhotosView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 预先创建9个图片控件
        for (int i = 0; i < NBStatusPhotosMaxCount; i++) {
            NBStatusPhotoView *photoView = [[NBStatusPhotoView alloc] init];
            photoView.tag = i;
            [self addSubview:photoView];
            
            // 添加手势识别器（一个手势监听器 只能 监听对应的一个view）
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] init];
            [recognizer addTarget:self action:@selector(tapPhoto:)];
            [photoView addGestureRecognizer:recognizer];
            
        }
    }
    return self;
}

/** 监听图片的点击 */
- (void)tapPhoto:(UITapGestureRecognizer *)recognizer
{
    // 1.创建图片浏览器
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    
    // 2.设置图片浏览器显示的所有图片
    NSMutableArray *photos = [NSMutableArray array];
    NSUInteger count = self.pic_urls.count;
    for (int i = 0; i < count; i++) {
        NBPhoto *pic = self.pic_urls[i];
        
        MJPhoto *photo = [[MJPhoto alloc] init];
        // 设置图片的路径
        photo.url = [NSURL URLWithString:pic.bmiddle_pic];
        // 设置来源于哪一个UIImageView
        photo.srcImageView = self.subviews[i];
        [photos addObject:photo];
    }
    browser.photos = photos;
    
    // 3.设置默认显示的图片索引
    browser.currentPhotoIndex = recognizer.view.tag;
    
    // 4.显示浏览器
    [browser show];
    
    // 1.添加一个遮罩
//    UIView *cover = [[UIView alloc] init];
//    cover.frame = [UIScreen mainScreen].bounds;
//    cover.backgroundColor = [UIColor blackColor];
//    [cover addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCover:)]];
//    [[UIApplication sharedApplication].keyWindow addSubview:cover];
//    
//    // 2.添加图片到遮盖上
//    NBStatusPhotoView *photoView = (NBStatusPhotoView *)recognizer.view;
//    UIImageView *imageView = [[UIImageView alloc] init];
////    imageView.image = photoView.image;
//    [imageView setImageWithURL:[NSURL URLWithString:photoView.photo.bmiddle_pic] placeholderImage:photoView.image];
//    // 将photoView.frame从self坐标系转为cover坐标系
////    imageView.frame = [cover convertRect:photoView.frame fromView:self];
//    imageView.frame = [self convertRect:photoView.frame toView:cover];
//    self.lastFrame = imageView.frame;
//    [cover addSubview:imageView];
//    self.imageView = imageView;
//    
//    // 3.放大图片
//    [UIView animateWithDuration:0.25 animations:^{
//        CGRect frame = imageView.frame;
//        frame.size.width = cover.width; // 占据整个屏幕;
//        frame.size.height = frame.size.width * (imageView.image.size.height / imageView.image.size.width);
//        frame.origin.x = 0;
//        frame.origin.y = (cover.height - frame.size.height) * 0.5;
//        imageView.frame = frame;
//    }];
}

/** 监听遮罩的点击 */
//- (void)tapCover:(UITapGestureRecognizer *)recognizer
//{
//    [UIView animateWithDuration:2.0 animations:^{
//        recognizer.view.backgroundColor = [UIColor clearColor];
//        self.imageView.frame = self.lastFrame;
//    } completion:^(BOOL finished) {
//        [recognizer.view removeFromSuperview];
//        self.imageView = nil;
//    }];
//}

- (void)setPic_urls:(NSArray *)pic_urls
{
    _pic_urls = pic_urls;
    
    for (int i = 0; i < NBStatusPhotosMaxCount; i++) {
        NBStatusPhotoView *photoView = self.subviews[i];
        
        if (i < pic_urls.count) { // 显示图片
            photoView.photo = pic_urls[i];
            photoView.hidden = NO;
        } else { // 隐藏
            photoView.hidden = YES;
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger count = self.pic_urls.count;
    int maxCols = NBStatusPhotosMaxCols(count);
    for (int i = 0; i < count; i++) {
        NBStatusPhotoView *photoView = self.subviews[i];
        photoView.width = NBStatusPhotoW;
        photoView.height = NBStatusPhotoH;
        photoView.x = (i % maxCols) * (NBStatusPhotoW + NBStatusPhotoMargin);
        photoView.y = (i / maxCols) * (NBStatusPhotoH + NBStatusPhotoMargin);
    }
}


+ (CGSize)sizeWithPhotosCount:(int)photosCount
{
    // 一行最多几列
    int maxCols = NBStatusPhotosMaxCols(photosCount);
    
    // 总列数
    int totalCols = photosCount >= maxCols ?  maxCols : photosCount;
    
    // 总行数
    // 知道总个数
    // 知道每一页最多显示多少个
    // 能算出一共能显示多少页
    int totalRows = (photosCount + maxCols - 1) / maxCols;
    
    // 计算尺寸
    CGFloat photosW = totalCols * NBStatusPhotoW + (totalCols - 1) * NBStatusPhotoMargin;
    CGFloat photosH = totalRows * NBStatusPhotoH + (totalRows - 1) * NBStatusPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
}
//        int totalRows = 0;
//        if (status.pic_urls.count % maxCols == 0) {
//            totalRows = status.pic_urls.count / maxCols;
//        } else {
//            totalRows = status.pic_urls.count / maxCols + 1;
//        }
@end
