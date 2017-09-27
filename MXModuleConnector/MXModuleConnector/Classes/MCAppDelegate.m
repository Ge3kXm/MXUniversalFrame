//
//  MCAppDelegate.m
//  MXModuleConnector
//
//  Created by maRk on 2017/9/27.
//

#import "MCAppDelegate.h"
#import "MCModuleConnector.h"

@interface MCAppDelegate ()

@end

@implementation MCAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [MCContext shared].applicationDelegate = self;
    [MCContext shared].application = application;
    [MCContext shared].launchOptions = launchOptions;
    
    [[MCModuleConnector shared] triggerEvent:MCModuleEventInit];
    [[MCModuleConnector shared] triggerEvent:MCModuleEventSetup];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[MCModuleConnector shared] triggerEvent:MCModuleEventSplash];
    });
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    [[MCModuleConnector shared] triggerEvent:MCModuleEventWillResignActive];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[MCModuleConnector shared] triggerEvent:MCModuleEventDidEnterBackground];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[MCModuleConnector shared] triggerEvent:MCModuleEventWillEnterForeground];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[MCModuleConnector shared] triggerEvent:MCModuleEventDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[MCModuleConnector shared] triggerEvent:MCModuleEventWillTerminate];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [MCContext shared].remoteNotificationItem.userInfo = userInfo;
    [[MCModuleConnector shared] triggerEvent:MCModuleEventDidReceiveRemoteNotification];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [MCContext shared].remoteNotificationItem.error = error;
    [MCContext shared].remoteNotificationItem.deviceToken = nil;
    [[MCModuleConnector shared] triggerEvent:MCModuleEventDidRegisterForRemoteNotification];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [MCContext shared].remoteNotificationItem.deviceToken = deviceToken;
    [MCContext shared].remoteNotificationItem.error = nil;
    [[MCModuleConnector shared] triggerEvent:MCModuleEventDidRegisterForRemoteNotification];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    [MCContext shared].openURL = url;
    [[MCModuleConnector shared] triggerEvent:MCModuleEventOpenURL];
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    [MCContext shared].openURL = url;
    [MCContext shared].sourceApplication = sourceApplication;
    [MCContext shared].annotation = annotation;
    [[MCModuleConnector shared] triggerEvent:MCModuleEventOpenURL_SourceApplication_Annotation];
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    [MCContext shared].openURL = url;
    [MCContext shared].openURLOptions = options;
    [[MCModuleConnector shared] triggerEvent:MCModuleEventOpenURL_Options];
    return YES;
}

@end
