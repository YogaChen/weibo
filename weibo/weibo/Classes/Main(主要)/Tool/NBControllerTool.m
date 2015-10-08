//
//  NBControllerTool.m
//  weibo
//
//  Created by yoga on 15/8/27.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import "NBControllerTool.h"
#import "NBTabBarController.h"
#import "NBNewfeatureViewController.h"

@implementation NBControllerTool

+ (void)chooseRootViewController
{
    // 2.设置窗口的根控制器
    NSString *versionKey = @"CFBundleVersion";
    //    NSString *versionKey = (__bridge NSString *)kCFBundleVersionKey;
    
    // 从沙盒中取出上次存储的软件版本号(取出用户上次的使用记录)
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults objectForKey:versionKey];
    
    // 获得当前打开软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    // 如何知道第一次使用这个版本？比较上次的使用情况
    if ([currentVersion isEqualToString:lastVersion]) { // 当前版本号 == 上次使用的版本：显示NBTabBarController
        window.rootViewController = [[NBTabBarController alloc] init];
        
    } else { // 当前版本号 != 上次使用的版本：显示版本新特性
        
        window.rootViewController = [[NBNewfeatureViewController alloc] init];
        
        // 存储这次使用的软件版本
        [defaults setObject:currentVersion forKey:versionKey];
        [defaults synchronize];
    }
}
@end
