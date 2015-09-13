//
//  AppDelegate.h
//  CoreDataDemo
//
//  Created by lxyzk on 15/9/13.
//  Copyright (c) 2015年 lxyzk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readonly, strong, nonatomic) NSManagedObjectContext * managedObjectContext;
@property (readonly ,strong, nonatomic) NSManagedObjectModel * managedObjectModel;
@property (readonly , strong, nonatomic) NSPersistentStoreCoordinator * persistentStoreCoordinator;

- (void) saveContext;
- (NSURL *) applicationDocumentDirectory;

@end

