//
//  HMNewfeatureViewController.m
//  黑马微博
//
//  Created by apple on 14-7-7.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#define NBNewfeatureImageCount 4

#import "NBNewfeatureViewController.h"
#import "NBTabBarController.h"

@interface NBNewfeatureViewController () <UIScrollViewDelegate>

@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation NBNewfeatureViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.添加UISrollView
    [self setupScrollView];
    
    // 2.添加pageControl
    [self setupPageControl];
}

/**
 *  添加UISrollView
 */
- (void)setupScrollView
{
    // 1.添加UISrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    // 2.添加图片
    CGFloat imageW = scrollView.width;
    CGFloat imageH = scrollView.height;
    for (int i = 0; i < NBNewfeatureImageCount; i++) {
        // 创建UIImageView
        UIImageView *imageView = [[UIImageView alloc] init];
        NSString *name = [NSString stringWithFormat:@"new_feature_%d", i + 1];
        if (FourInch) { // 4inch  需要手动去加载4inch对应的-568h图片
            name = [name stringByAppendingString:@"-568h"];
        }
        imageView.image = [UIImage imageWithNamed:name];
        
        [scrollView addSubview:imageView];
        
        // 设置frame
        imageView.y = 0;
        imageView.width = imageW;
        imageView.height = imageH;
        imageView.x = i * imageW;
        
        // 给最后一个imageView添加按钮
        if (i == NBNewfeatureImageCount - 1) {
            [self setupLastImageView:imageView];
        }
    }
    
    // 3.设置其他属性
    scrollView.contentSize = CGSizeMake(NBNewfeatureImageCount * imageW, 0);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.backgroundColor = NBColor(246, 246, 246);
}

/**
 设置最后一个UIImageView中的内容
 */
- (void)setupLastImageView:(UIImageView *)imageView
{
    imageView.userInteractionEnabled = YES;
    
    // 1.添加开始按钮
    [self setupStartButton:imageView];
    
    // 2.添加分享按钮
    [self setupShareButton:imageView];
}

/**
 *  分享按钮
 */
- (void)setupShareButton:(UIImageView *)imageView
{
    UIButton *shareButton = [[UIButton alloc] init];
    [shareButton setImage:[UIImage imageWithNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageWithNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareButton setTitle:@"分享到微博" forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareButton.size = CGSizeMake(150, 35);
    shareButton.center = CGPointMake(self.view.width * 0.5, self.view.height * 0.75);
//    shareButton.backgroundColor = [UIColor brownColor];
    [imageView addSubview:shareButton];
//    UIButton
    // 监听点击
    [shareButton addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    shareButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    imageView.userInteractionEnabled = YES;

}

/**
 分享
 */
- (void)share:(UIButton *)shareButton
{
    shareButton.selected = !shareButton.isSelected;
    //    UIImage *falseImage = [UIImage imageWithName:@"new_feature_share_false"];
    //    if (shareButton.currentImage == falseImage) {
    //        [shareButton setImage:[UIImage imageWithName:@"new_feature_share_true"] forState:UIControlStateNormal];
    //    } else {
    //        [shareButton setImage:falseImage forState:UIControlStateNormal];
    //    }
}

/**
 *  添加开始按钮
 */
- (void)setupStartButton:(UIImageView *)imageView
{
    // 1.添加开始按钮
    UIButton *startButton = [[UIButton alloc] init];
    [imageView addSubview:startButton];
    
    // 2.设置背景图片
    [startButton setBackgroundImage:[UIImage imageWithNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageWithNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    
    // 3.设置frame
    startButton.size = startButton.currentBackgroundImage.size;
    startButton.centerX = self.view.width * 0.5;
    startButton.centerY = self.view.height * 0.85;
    
    // 4.设置文字
    [startButton setTitle:@"开始微博" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
}

/**
 *  开始微博
 */
- (void)start
{
    // 显示主控制器（HMTabBarController）
    NBTabBarController *vc = [[NBTabBarController alloc] init];
    
    // 切换控制器
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = vc;
    // push : [self.navigationController pushViewController:vc animated:NO];
    // modal : [self presentViewController:vc animated:NO completion:nil];
    // window.rootViewController : window.rootViewController = vc;
}


/**
 *  添加pageControl
 */
- (void)setupPageControl
{
    // 1.添加
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = NBNewfeatureImageCount;
    pageControl.centerX = self.view.width * 0.5;
    pageControl.centerY = self.view.height * 0.95;
    [self.view addSubview:pageControl];

    // 2.设置圆点的颜色
    pageControl.currentPageIndicatorTintColor = NBColor(253, 98, 42); // 当前页的小圆点颜色
    pageControl.pageIndicatorTintColor = NBColor(189, 189, 189); // 非当前页的小圆点颜色
    self.pageControl = pageControl;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获得页码
    CGFloat doublePage = scrollView.contentOffset.x / scrollView.width;
    int intPage = (int)(doublePage + 0.5);
    
    // 设置页码
    self.pageControl.currentPage = intPage;
}

@end
