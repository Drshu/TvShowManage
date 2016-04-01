//
//  AppDelegate.h
//  TvShowManage
//
//  Created by shucheng on 16/3/29.
//  Copyright © 2016年 shucheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly,strong,nonatomic)NSManagedObjectContext *managedObjectContext;//上下文对象
@property (readonly,strong,nonatomic)NSManagedObjectModel *managedObjectModel;//数据模型对象
@property (readonly,strong,nonatomic)NSPersistentStoreCoordinator *persistentStoreCoordinator;//持久性存储区
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@property (strong, nonatomic) UIWindow *window;



- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
@end

