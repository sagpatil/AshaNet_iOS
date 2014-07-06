//
//  AppDelegate.m
//  AshaNet_iOS
//
//  Created by Patil, Sagar on 7/1/14.
//  Copyright (c) 2014 Patil, Sagar. All rights reserved.
//

#import "AppDelegate.h"
#import "ProjectsViewController.h"
#import "EventsViewController.h"
#import "GeneralDonateViewController.h"
#import <Parse/Parse.h>

static NSString *KApp_id = @"0Kz1Jdnz3PZHlWjY1IBdzuv4tJZcpc8hrnT2mnbR";
static NSString *KClient_Key = @"k6lG4PhbwxJp2zpwo7pgEGUA73zxtYplMBLvtGnS";

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [Parse setApplicationId:KApp_id clientKey:KClient_Key];
    
    ProjectsViewController *pvc = [[ProjectsViewController alloc] init];
    EventsViewController *evc = [[EventsViewController alloc] init];
    GeneralDonateViewController *gdvc = [[GeneralDonateViewController alloc] init];

    UINavigationController *projectsNavController = [[UINavigationController alloc] initWithRootViewController:pvc];
    projectsNavController.tabBarItem.title = @"Projects";
//    projectsNavController.tabBarItem.image = [UIImage imageNamed:@"MovieIcon"];
    
    UINavigationController *eventsNavController = [[UINavigationController alloc] initWithRootViewController:evc];
    eventsNavController.tabBarItem.title = @"Events";
    
    UINavigationController *donateNavController = [[UINavigationController alloc] initWithRootViewController:gdvc];
    donateNavController.tabBarItem.title = @"Donate";
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[projectsNavController, donateNavController, eventsNavController];
    
    tabBarController.tabBar.tintColor = [UIColor yellowColor];
    tabBarController.tabBar.barTintColor = [UIColor blackColor];
    
    [[UINavigationBar appearance] setBarTintColor: [UIColor orangeColor]];
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8];
    shadow.shadowOffset = CGSizeMake(0, 1);
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0], NSForegroundColorAttributeName, shadow, NSShadowAttributeName,[UIFont fontWithName:@"HelveticaNeue-CondensedBlack" size:21.0], NSFontAttributeName, nil]];

    
    self.window.rootViewController = tabBarController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
