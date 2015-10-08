//
//  NBTabBarController.m
//  weibo
//
//  Created by yoga on 15/8/24.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import "NBTabBarController.h"
#import "NBHomeController.h"
#import "NBMessageController.h"
#import "NBDiscoverController.h"
#import "NBProfileController.h"
#import "NBNavigationController.h"
#import "NBTabBar.h"
#import "NBComposeViewController.h"
#import "NBUnreadCountResult.h"
#import "NBUnreadCountParam.h"
#import "NBAccountTool.h"
#import "NBAccount.h"
#import "NBUserTool.h"

@interface NBTabBarController () < NBTabBarDelegate, UITabBarControllerDelegate>

@property (nonatomic , weak) NBHomeController *home;
@property (nonatomic , weak) NBMessageController *message;
@property (nonatomic , weak) NBProfileController *profile;

/** 记录上一次选中的首页状态，避免切换控制器时，首页又重新回到最顶部 */
@property (nonatomic , weak) UIViewController *lastSelectedVc;

@end

@implementation NBTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 添加所有的子控制器
    [self addAllChildVcs];
   
    // 创建自定义tabbar
    [self addCustomTabBar];
    
    self.delegate = self;
    
    // 添加一个定时器来获取微博和消息未读数
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(getUnreadCount) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

/**
 *  获取消息未读数
 */
- (void)getUnreadCount
{
    // 1. 封装请求参数
    NBUnreadCountParam *param = [NBUnreadCountParam param];
    param.uid = [NBAccountTool account].uid;
    
    // 2. 发送请求获得消息未读数
    [NBUserTool unreadCountWithParm:param success:^(NBUnreadCountResult *result) {
        // 显示微博未读数, 数值为0就不用显示
        if (result.status == 0) {
            self.home.tabBarItem.badgeValue = nil;
        }else{
            self.home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.status];
        }
            
        // 显示消息未读数
        if (result.messageCount == 0) {
            self.message.tabBarItem.badgeValue = nil;
        }else{
            self.message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.messageCount];
        }
        
        // 显示新粉丝数
        if (result.follower == 0) {
            self.profile.tabBarItem.badgeValue = nil;
        }else{
            self.profile.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.follower];
        }
        
        // 程序图标显示未读消息的总数
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.totalCount;
//        NBLog(@"获得未读的总数---%d", result.totalCount);

    } failure:^(NSError *error) {
        NBLog(@"获得未读数失败---%@", error);
    }];
}

/**
 *  创建自定义tabbar
 */
- (void)addCustomTabBar
{
    // 创建自定义tabbar
    NBTabBar *customTabBar = [[NBTabBar alloc] init];
    //    customTabBar.backgroundImage = [UIImage imageWithNamed:@"tabbar_background"]; 在这里会导致ios7的tabbar透明
    //    customTabBar.selectionIndicatorImage = [UIImage imageWithNamed:@"navigationbar_button_background"];
    customTabBar.tabBardelegate = self;
    // 更换系统自带的tabbar
    [self setValue:customTabBar forKeyPath:@"tabBar"];
}

/**
 *  添加所有的子控制器
 */
- (void)addAllChildVcs
{
    NBHomeController *home = [[NBHomeController alloc] init];
    //    home.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@"tabbar_home"] selectedImage:[UIImage imageNamed:@"tabbar_home_selected"]];
    //    [self addChildViewController:home];
    [self addOneChildVc:home title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    self.home = home;
    self.lastSelectedVc = home;
    
    NBMessageController *message = [[NBMessageController alloc] init];
    [self addOneChildVc:message title:@"消息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    self.message = message;
    
    //    UIViewController *vc = [[UIViewController alloc] init];
    //    [self addOneChildVc:vc title:@"ddd" imageName:@"tabbar_compose_button_highlighted" selectedImageName:@"tabbar_compose_button_highlighted"]; 无法满足在中间添加一个居中的TabBar按钮，所以需要自定义一个NBTabBar类；
    
    NBDiscoverController *discover = [[NBDiscoverController alloc] init];
    [self addOneChildVc:discover title:@"发现" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    
    NBProfileController *profile = [[NBProfileController alloc] init];
    [self addOneChildVc:profile title:@"我" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
    self.profile = profile;
}

/**
 *  添加一个子控制器
 *
 *  @param childVc           子控制器对象
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)addOneChildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
//    childVc.view.backgroundColor = NBRandomColor;
    
    //    childVc.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:[UIImage imageNamed:image] selectedImage:[UIImage imageNamed:selectedImage]];
    
    // 设置标题
    // 相当于同时设置了tabBarItem.title和navigationItem.title
    childVc.title = title;
    //    childVc.tabBarItem.title = title; // tabbar标签上
    //    childVc.navigationItem.title  = title; // 导航栏
    
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageWithNamed:imageName];
    
    // 设置tabBarItem的普通文字颜色
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[UITextAttributeTextColor] = [UIColor blackColor];
    textAttrs[UITextAttributeFont] = [UIFont systemFontOfSize:10];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置tabBarItem的选中文字颜色
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[UITextAttributeTextColor] = [UIColor orangeColor];
    [childVc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageWithNamed:selectedImageName];
    if (iOS7) {
        // 声明这张图片用原图(别渲染)
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    childVc.tabBarItem.selectedImage = selectedImage;
    
    // 添加为tabbar控制器的子控制器
    NBNavigationController *nav = [[NBNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}

// 在iOS7中, 会对selectedImage的图片进行再次渲染为蓝色
// 要想显示原图, 就必须得告诉它: 不要渲染

// Xcode的插件安装路径: /Users/用户名/Library/Application Support/Developer/Shared/Xcode/Plug-ins

#pragma mark - UITabBarControllerDelegate
/** 点击tabBar切换 就会调用这个方法 */
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UINavigationController *)viewController
{         // UIViewController --->  UINavigationController
    // 强制重新布局子控件（内部会调用layouSubviews）
//    [self.tabBar setNeedsLayout];
//    NBLog(@"didSelectViewController---%@", [viewController.childViewControllers firstObject]);
    
    // 当显示有新的未读微博时，点首页能自动回到最顶
    UIViewController *vc = [viewController.childViewControllers firstObject];
    if ([vc isKindOfClass:[NBHomeController class]]) {
        if (self.lastSelectedVc == vc) {
            [self.home refresh:YES];
        }else {
            [self.home refresh:NO];
        }
    }
    
    // 记录上一次选中的状态
    self.lastSelectedVc = vc;
}

#pragma mark - NBTabBarDelegate
- (void)tabBarDidClickedPlusButton:(NBTabBar *)tabBar
{
    NBComposeViewController *composeVc = [[NBComposeViewController alloc] init];
    NBNavigationController *nav = [[NBNavigationController alloc] initWithRootViewController:composeVc];
    [self presentViewController:nav animated:YES completion:^{
        
    }];
}

@end
