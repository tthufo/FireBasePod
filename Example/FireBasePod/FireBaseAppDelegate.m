//
//  FireBaseAppDelegate.m
//  FireBasePod
//
//  Created by tthufo@gmail.com on 07/10/2018.
//  Copyright (c) 2018 tthufo@gmail.com. All rights reserved.
//

#import "FireBaseAppDelegate.h"

#import "FirePush.h"

@implementation FireBaseAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[FirePush shareInstance] didRegister];
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [[FirePush shareInstance] didReiciveToken:deviceToken withType:0];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[FirePush shareInstance] connectToFcm];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[FirePush shareInstance] disconnectToFcm];
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
