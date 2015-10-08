//
//  NBTabBar.h
//  weibo
//
//  Created by yoga on 15/8/26.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NBTabBar;

@protocol NBTabBarDelegate <NSObject>

@optional
- (void)tabBarDidClickedPlusButton:(NBTabBar *)tabBar;

@end


@interface NBTabBar : UITabBar

@property (nonatomic , weak) id<NBTabBarDelegate> tabBardelegate;

@end
