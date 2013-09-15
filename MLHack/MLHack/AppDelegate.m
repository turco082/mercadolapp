//
//  AppDelegate.m
//  MLHack
//
//  Created by Ramiro Ponce on 14/09/13.
//  Copyright (c) 2013 Ramiro Ponce. All rights reserved.
//

#import "AppDelegate.h"
#import "TestViewController.h"
#import "SplashViewController.h"

#import "MMDrawerVisualStateManager.h"
#import "MMDrawerController.h"

// controllers
#import "LeftSideMenuViewController.h"
#import "HomeCenterViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) MMDrawerController* drawerController;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    //TestViewController* home = [[TestViewController alloc] init];
    //SplashViewController* splashVC = [[SplashViewController alloc] initWithNibName:@"SplashViewController" bundle:nil];
    
    // create controllers
    [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"LeftSideIndexSelected"];
    [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"firstLoad"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    UIViewController* leftSideViewController = [[LeftSideMenuViewController alloc] init];
    UIViewController* centerViewController = [[HomeCenterViewController alloc] init];
    
    UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:centerViewController];
    [navController setRestorationIdentifier:@"CenterNavigationControllerRestorationKey"];
    
    self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:navController leftDrawerViewController:leftSideViewController];
    [self.drawerController setRestorationIdentifier:@"MMDrawer"];
    [self.drawerController setMaximumLeftDrawerWidth:160.0];
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    [self.drawerController setDrawerVisualStateBlock:^(MMDrawerController* drawerController, MMDrawerSide drawerSide, CGFloat percentVisible){
        MMDrawerControllerDrawerVisualStateBlock block;
        block = [[MMDrawerVisualStateManager sharedManager] drawerVisualStateBlockForDrawerSide:drawerSide];
        if (block) {
            block(drawerController, drawerSide, percentVisible);
        }
    }];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window setRootViewController:self.drawerController];
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

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    // Display text
    NSLog(@"URL: %@", url.absoluteString);
    [_drawerController dismissViewControllerAnimated:YES completion:nil];
    return YES;
}

@end
