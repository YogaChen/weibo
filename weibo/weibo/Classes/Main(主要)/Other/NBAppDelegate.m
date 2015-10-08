//
//  NBAppDelegate.m
//  weibo
//
//  Created by yoga on 15/8/24.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import "NBAppDelegate.h"
#import "NBOAuthViewController.h"
#import "NBControllerTool.h"
#import "NBAccount.h"
#import "NBAccountTool.h"
#import "AFNetworkReachabilityManager.h"
#import "MBProgressHUD+MJ.h"
#import "SDImageCache.h"
#import "SDWebImageManager.h"

@implementation NBAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // 启动完后显示状态栏
    application.statusBarHidden = NO;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    NBAccount *account = [NBAccountTool account];
    if (account) {
        [NBControllerTool chooseRootViewController];
    }else{
        self.window.rootViewController = [[NBOAuthViewController alloc] init];
    }
    
    // 监控网络状态
//    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
//    // 当网络状态改变了，就会调用
//    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        switch (status) {
//            case AFNetworkReachabilityStatusUnknown: // 未知网络
//                NBLog(@"未知网络");
//                break;
//            
//            case AFNetworkReachabilityStatusNotReachable:// 没有网络(断网)
//                NBLog(@"没有网络");
//                [MBProgressHUD showError:@"网络异常，请检查网络设置！"];
//                break;
//                
//            case AFNetworkReachabilityStatusReachableViaWWAN:// 手机自带网络
//                NBLog(@"手机上网");
//                break;
//                
//            case AFNetworkReachabilityStatusReachableViaWiFi:// WIFI
//                NBLog(@"WIFI");
//                break;
//            
//        }
//    }];
//    [mgr startMonitoring]; // 开始监控
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

/** 程序进入后台的时候调用 */
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    // 提醒操作系统：当前这个应用程序需要在后台开启一个任务
    // 操作系统会允许这个应用程序在后台保持运行状态（能够持续的时间是不确定）
    
#warning    Can't endBackgroundTask: no background task exists with identifier 19f412f, or it may have already been ended. Break in UIApplicationEndBackgroundTaskError() to debug. 这里还有不妥的地方，程序进入后台后，会报错


    UIBackgroundTaskIdentifier taskID = [application beginBackgroundTaskWithExpirationHandler:^{
        // 后台运行的时间到期了，就会自动调用这个block
        [application endBackgroundTask:taskID];
    }];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    // 赶紧清除所有的内存缓存 sharedImageCache/ 参考sharedApplication
    [[SDImageCache sharedImageCache] clearMemory];
    
    // 赶紧停止所有正在下载图片的操作
    [[SDWebImageManager sharedManager] cancelAll];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NBLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"____" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"____.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NBLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
