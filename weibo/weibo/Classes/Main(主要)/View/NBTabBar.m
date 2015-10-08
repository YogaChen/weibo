//
//  NBTabBar.m
//  weibo
//
//  Created by yoga on 15/8/26.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import "NBTabBar.h"

@interface NBTabBar ()

@property (nonatomic , weak) UIButton *plusButton;

@end

@implementation NBTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (!iOS7) {
            self.backgroundImage = [UIImage imageWithNamed:@"tabbar_background"];
        }
        self.selectionIndicatorImage = [UIImage imageWithNamed:@"navigationbar_button_background"];
        
        // 添加加号按钮
        [self setupPlusButton];
    }
    return self;
}

/**
 *  添加加号按钮
 */
- (void)setupPlusButton
{
    UIButton *plusButton = [[UIButton alloc] init];
    // 设置背景
    [plusButton setBackgroundImage:[UIImage imageWithNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
    [plusButton setBackgroundImage:[UIImage imageWithNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
    // 设置图标
    [plusButton setImage:[UIImage imageWithNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
    [plusButton setImage:[UIImage imageWithNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
    [plusButton addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
    // 添加
    [self addSubview:plusButton];
    self.plusButton = plusButton;

}

- (void)plusClick
{
    NBLog(@"plusClick----");
    
    if ([self.tabBardelegate respondsToSelector:@selector(tabBarDidClickedPlusButton:)]) {
        [self.tabBardelegate tabBarDidClickedPlusButton:self];
    }
}

/**
 *  布局子控件
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置plusButton的frame
    [self setupPlusButtonFrame];
    
    // 设置所有tabbarButton的frame
    [self setupAllTabBarButtonsFrame];
}

/**
 *  设置plusButton的frame
 */
- (void)setupPlusButtonFrame
{
    self.plusButton.size = self.plusButton.currentBackgroundImage.size;
//    self.plusButton.centerX = self.centerX;
//    self.plusButton.centerY = self.centerY;  获取的数值是不对的
    self.plusButton.center = CGPointMake(self.width * 0.5, self.height * 0.5);

}

/**
 *  设置所有tabbarButton的frame
 */
- (void)setupAllTabBarButtonsFrame
{
    int index = 0;
    
    // 遍历所有的button
    for (UIView *tabBarButton in self.subviews) {
        // 如果不是UITabBarButton， 直接跳过
        if (![tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        
        // 根据索引调整位置
        [self setupTabBarButtonFrame:tabBarButton atIndex:index];
        
        // 遍历UITabBarButton中的所有子控件 已在NBTabBarController类中的addOneChildVc。。。方法统一设置
//        [self setupTabBarButtonTextColor:tabBarButton atIndex:index];
        
        // 索引增加
        index++;
    }

}

/**
 *  设置某个按钮的文字颜色
 *
 *  @param tabBarButton 需要设置的按钮
 *  @param index        按钮所在的索引
 */
//- (void)setupTabBarButtonTextColor:(UIView *)tabBarButton atIndex:(int)index
//{
//    // 选中按钮的索引
//    int selectedIndex = [self.items indexOfObject:self.selectedItem];
//    
//    for (UILabel *label in tabBarButton.subviews) {
//        // 说明不是个Label
//        if (![label isKindOfClass:[UILabel class]]) continue;
//        
//        // 设置字体
//        label.font = [UIFont systemFontOfSize:10];
//        if (selectedIndex == index) { // 说明这个Button选中, 设置label颜色为橙色
//            label.textColor = [UIColor orangeColor];
//        } else { // 说明这个Button没有选中, 设置label颜色为黑色
//            label.textColor = [UIColor blackColor];
//        }
//    }
//}

/**
 *  设置某个按钮的frame
 *
 *  @param tabBarButton 需要设置的按钮
 *  @param index        按钮所在的索引
 */
- (void)setupTabBarButtonFrame:(UIView *)tabBarButton atIndex:(int)index
{
    // 计算button的尺寸
    CGFloat buttonW = self.width / (self.items.count + 1);
    CGFloat buttonH = self.height;
    
    //NBLog(@"%d", self.items.count);  // = 4  所以加一
    
    tabBarButton.width = buttonW;
    tabBarButton.height = buttonH;
    if (index >= 2) {
        tabBarButton.x = buttonW * (index + 1);
    } else {
        tabBarButton.x = buttonW * index;
    }
    tabBarButton.y = 0;
}


@end
