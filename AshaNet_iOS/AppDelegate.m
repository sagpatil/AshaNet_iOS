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
#import "AshaHomeViewController.h"
#import "XOSplashVideoController.h"
#import <Parse/Parse.h>
#import "ContainerViewController.h"
#import "ChildViewController.h"
#import "Animator.h"
#import "AWPercentDrivenInteractiveTransition.h"

static NSString *KApp_id = @"0Kz1Jdnz3PZHlWjY1IBdzuv4tJZcpc8hrnT2mnbR";
static NSString *KClient_Key = @"k6lG4PhbwxJp2zpwo7pgEGUA73zxtYplMBLvtGnS";

@interface AppDelegate () <ContainerViewControllerDelegate>
    @property (nonatomic, strong) UIWindow *privateWindow;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    
    NSString *portraitVideoName = @"splash";
    NSString *portraitImageName = @"Default.png";
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && self.window.frame.size.height > 480) {
        portraitImageName = @"Default-568h@2x.png";
        portraitVideoName = @"splash-568h~iphone";
    }
    
    NSString *landscapeVideoName = nil; // n/a
    NSString *landscapeImageName = nil; // n/a
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        portraitVideoName = @"splash";
        portraitImageName = @"Default-Portrait.png";
        landscapeVideoName = @"splash-landscape";
        landscapeImageName = @"Default-Landscape.png";
    }
    
    // our video
    NSURL *portraitUrl = [[NSBundle mainBundle] URLForResource:portraitVideoName withExtension:@"mp4"];
    NSURL *landscapeUrl = [[NSBundle mainBundle] URLForResource:landscapeVideoName withExtension:@"mp4"];
    
    // our splash controller
    XOSplashVideoController *splashVideoController =
    [[XOSplashVideoController alloc] initWithVideoPortraitUrl:portraitUrl
                                            portraitImageName:portraitImageName
                                                 landscapeUrl:landscapeUrl
                                           landscapeImageName:landscapeImageName
                                                     delegate:self];
    // we'll start out with the spash view controller in the window
    self.window.rootViewController = splashVideoController;
    
    
    [Parse setApplicationId:KApp_id clientKey:KClient_Key];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    
    //  self.window.rootViewController = [[HomeViewController alloc]init];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}
- (void)splashVideoLoaded:(XOSplashVideoController *)splashVideo
{
    // load up our real view controller, but don't put it in to the window until the video is done
    // if there's anything expensive to do it should happen in the background now
    //self.viewController = [[XOViewController alloc] initWithNibName:@"XOViewController" bundle:nil];

}

- (void)splashVideoComplete:(XOSplashVideoController *)splashVideo
{
    // swap out the splash controller for our app's
    self.window.rootViewController = [self _configuredRootViewController];
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

#pragma mark - ContainerViewControllerDelegate Protocol

- (id<UIViewControllerAnimatedTransitioning>)containerViewController:(ContainerViewController *)containerViewController animationControllerForTransitionFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController {
	return [[Animator alloc] init];
}

- (id<UIViewControllerInteractiveTransitioning>)containerViewController:(ContainerViewController *)containerViewController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    
    // Fake an interactive transition to demonstrate interaction can be delegated
    AWPercentDrivenInteractiveTransition *fakeInteraction = [[AWPercentDrivenInteractiveTransition alloc] initWithAnimator:animationController];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [fakeInteraction updateInteractiveTransition:0.25];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [fakeInteraction updateInteractiveTransition:0.5];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [fakeInteraction finishInteractiveTransition];
    });
    
    return fakeInteraction;
}

#pragma mark - Private Methods

- (UIViewController *)_configuredRootViewController {
	
	NSArray *childViewControllers = [self _configuredChildViewControllers];
	ContainerViewController *rootViewController = [[ContainerViewController alloc] initWithViewControllers:childViewControllers];
    //	rootViewController.delegate = self;
    //    rootViewController.interactiveTransitionGestureRecognizer.enabled = NO;
	
	return rootViewController;
}

- (NSArray *)_configuredChildViewControllers {
	
	// Set colors, titles and tab bar button icons which are used by the ContainerViewController class for display in its button pane.
	
	NSMutableArray *childViewControllers = [[NSMutableArray alloc] initWithCapacity:3];
	NSArray *configurations = @[
                                @{@"title": @"First", @"color": [UIColor colorWithRed:0.4f green:0.8f blue:1 alpha:1]},
                                @{@"title": @"Second", @"color": [UIColor colorWithRed:1 green:0.4f blue:0.8f alpha:1]},
                                @{@"title": @"Third", @"color": [UIColor colorWithRed:1 green:0.8f blue:0.4f alpha:1]},
                                ];
	
	for (NSDictionary *configuration in configurations) {
        AshaHomeViewController *ahvc = [[AshaHomeViewController alloc]init];

		ahvc.themeColor = configuration[@"color"];
		[childViewControllers addObject:ahvc];
	}
	
	return childViewControllers;
}


@end
