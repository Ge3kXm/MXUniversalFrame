//
//  MCContext.h
//  MXModuleConnector
//
//  Created by maRk on 2017/9/27.
//

#import <Foundation/Foundation.h>

////////////////////////////////////////////////////////////////////////////////////////////////

@interface MCRemoteNotificationItem : NSObject

@property (nonatomic, strong) NSError *error;
@property (nonatomic, strong) NSData *deviceToken;
@property (nonatomic, strong) NSDictionary *userInfo;

@end

////////////////////////////////////////////////////////////////////////////////////////////////

@interface MCContext : NSObject

+ (instancetype)shared;

//////////////// 启动相关相关回调 ////////////////////////////////////
@property (nonatomic, strong) UIApplication *application;
@property (nonatomic, strong) id<UIApplicationDelegate> applicationDelegate;
@property (nonatomic, strong) NSDictionary *launchOptions;
//////////////// 启动相关相关回调 ////////////////////////////////////


//////////////// 通知相关 ////////////////////////////////////
@property (nonatomic, strong) MCRemoteNotificationItem *remoteNotificationItem;
//////////////// 通知相关 ////////////////////////////////////


//////////////// openURL相关回调 ////////////////////////////////////
@property (nonatomic, strong) NSURL         *openURL;///< 通过scheme打开本应用的URL
@property (nonatomic, strong) NSString      *sourceApplication;
@property (nonatomic, strong) id            annotation;
@property (nonatomic, strong) NSDictionary  *openURLOptions;
//////////////// openURL相关回调 ////////////////////////////////////

@end
