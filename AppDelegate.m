//
//  MyTabViewAppDelegate.m
//  N42Tian
//
//  Created by Jingfu Ju on 2/2/17.
//  Copyright © 2017 N42Tian. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (nonatomic, strong)NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong)NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong)NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end


@implementation AppDelegate
//{
//    UINavigationController *navigationController;
//}

//@synthesize tabBarController;
@synthesize homeViewController, cartViewController, infoViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSLog(@" didFinishLauchingWithOptions");
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    self.window.rootViewController = navigationController;
    
    self.homeViewController = [[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:NULL];
//    self.cartViewController = [[CartViewController alloc] initWithNibName:nil bundle:NULL];
//    self.infoViewController = [[InfoViewController alloc] initWithNibName:nil bundle:NULL];
    
    NSArray *tabViewController = [[NSArray alloc] initWithObjects:
                                  self.homeViewController,
                                  self.cartViewController,
//                                  self.infoViewController,
                                  nil];
    self.tabBarController = [[TabBarController alloc] init];
    [self.tabBarController setViewControllers:tabViewController];
    [self.window addSubview:self.tabBarController.view];
     self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
//    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
//    HomeViewController *homeViewController = (HomeViewController *)tabBarController.viewControllers[0];
    self.homeViewController.managedObjectContext = self.managedObjectContext;
    
//    CartViewController *cartViewController = (CartViewController *)tabBarController.viewControllers[1];
    self.cartViewController.managedObjectContext = self.managedObjectContext;
    NSLog(@"********  Personal Debug Info Below  ***********");
    
    
    return  YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    //do nothing
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    //do nothing
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    //do nothing
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    //do nothinng
}

- (void)applicationWillTerminate:(UIApplication *)application {
    //do nothing
}

#pragma mark - Core Data

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel == nil) {
        NSString *modelPath = [[NSBundle mainBundle] pathForResource:@"DataModel" ofType:@"momd"];
        NSURL *modelURL = [NSURL fileURLWithPath:modelPath];
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    }
    return _managedObjectModel;
}

- (NSString *)documentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths lastObject];
    return documentsDirectory;
}

- (NSString *)dataStorePath
{
    return [[self documentsDirectory] stringByAppendingPathComponent:@"DataStore.sqlite"];
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator == nil) {
        NSURL *storeURL = [NSURL fileURLWithPath:[self dataStorePath]];
        //        NSLog(@"The StoreURL is %@", storeURL);
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
        
        NSError *error;
        if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
            NSLog(@"Error adding persistent store %@, %@", error, [error userInfo]);
            abort();
        }
    }
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext == nil) {
        NSPersistentStoreCoordinator *coordinator = self.persistentStoreCoordinator;
        if (coordinator != nil) {
            _managedObjectContext = [[NSManagedObjectContext alloc] init];
            [_managedObjectContext setPersistentStoreCoordinator:coordinator];
        }
    }
    return _managedObjectContext;
}


@end


