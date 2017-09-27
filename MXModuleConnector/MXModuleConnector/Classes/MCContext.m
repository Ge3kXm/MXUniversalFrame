//
//  MCContext.m
//  MXModuleConnector
//
//  Created by maRk on 2017/9/27.
//

#import "MCContext.h"

@implementation MCRemoteNotificationItem

@end

////////////////////////////////////////////////////////////////////////////////////////////////

@implementation MCContext

+ (instancetype)shared {
    static MCContext *instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        instance.application = [UIApplication sharedApplication];
        instance.applicationDelegate = [UIApplication sharedApplication].delegate;
    });
    
    return instance;
}

- (MCRemoteNotificationItem *)remoteNotificationItem {
    if (!_remoteNotificationItem) {
        _remoteNotificationItem = [[MCRemoteNotificationItem alloc] init];
    }
    return _remoteNotificationItem;
}

@end
