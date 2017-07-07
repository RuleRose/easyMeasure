//
//  AppDelegate.m
//  easyMeasure
//
//  Created by yongche on 17/5/19.
//  Copyright © 2017年 goldsmith. All rights reserved.
//

#import "AppDelegate.h"
#import "EMMainViewController.h"
#import "XJFDBManager.h"
#import "EMMeasureModel.h"
#import "EMGuideViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = kColor_1;
    NSNumber *showGuide = [[NSUserDefaults standardUserDefaults] objectForKey:USER_DEFAULT_SHOW_GUIDE];
    if ([showGuide boolValue]) {
        EMMainViewController *mainVC = [[EMMainViewController alloc] init];
        _navigationC = [[EMNavigationController alloc] initWithRootViewController:mainVC];
        [self.window setRootViewController:_navigationC];
        // Override point for customization after application launch.
        [self.window makeKeyAndVisible];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:USER_DEFAULT_SHOW_GUIDE];
        EMGuideViewController *guideView = [[EMGuideViewController alloc] init];
        _navigationC = [[EMNavigationController alloc] initWithRootViewController:guideView];
        [self.window setRootViewController:_navigationC];
        // Override point for customization after application launch.
        [self.window makeKeyAndVisible];
    }
    [XJFDBManager createTableWithModel:[EMMeasureModel class]];
    [NSThread sleepForTimeInterval:2];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an
    // incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your
    // application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background,
    // optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
