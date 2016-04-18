//
//  BGGAppDelegate.m
//  Colorthesia
//
//  Created by AJ Green on 9/30/14.
//  Copyright (c) 2014 Big Gorilla Games. All rights reserved.
//

#import "BGGAppDelegate.h"

@implementation BGGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[BGGApplicationManager sharedInstance] setColor:[BGGUtilities mainMenuYellow]];
    [[BGGApplicationManager sharedInstance] setCurrentHighScore:[BGGUtilities retrieveHighScore]];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [BGGUtilities saveHighScore:[[BGGApplicationManager sharedInstance] currentHighScore]];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[BGGApplicationManager sharedInstance] setCurrentHighScore:[BGGUtilities retrieveHighScore]];
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
