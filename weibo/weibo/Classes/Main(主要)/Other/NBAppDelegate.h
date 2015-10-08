//
//  NBAppDelegate.h
//  weibo
//
//  Created by yoga on 15/8/24.
//  Copyright (c) 2015年 ioslearning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NBAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
