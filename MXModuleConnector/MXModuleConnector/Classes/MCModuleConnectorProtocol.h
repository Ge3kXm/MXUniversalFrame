//
//  MCModuleConnectorProtocol.h
//  MXModuleConnector
//
//  Created by maRk on 2017/9/27.
//


#import <Foundation/Foundation.h>

//////////////////////////////////////////////////////////////////////////////

@protocol SingletonProtocol <NSObject>

+ (BOOL)isSingleton;
@end

//////////////////////////////////////////////////////////////////////////////


/**
 所有服务类都需要继承此协议
 */
@protocol ExportableProtocol <SingletonProtocol>

@optional


/**
 返回自定义对象，比如Manager中返回的shared对象
 */
+ (instancetype)ep_defaultInstance;

@end

////////////////////////////////////////////////////////////////////////////
@class MCContext;

@protocol ModuleConnectorProtocol <SingletonProtocol>

@optional

- (void)mc_moduleActionCustomEvent:(MCContext *)context eventCode:(NSUInteger)eventCode;

- (void)mc_moduleInit:(MCContext *)context; ///< 初始化模块

- (void)mc_moduleSetup:(MCContext *)context; ///< 设置模块

- (void)mc_moduleSplash:(MCContext *)context; ///< 执行写，非顺序，异步任务


- (void)mc_moduleWillResignActive:(MCContext *)context;
- (void)mc_moduleDidEnterBackground:(MCContext *)context;
- (void)mc_moduleWillEnterForeground:(MCContext *)context;
- (void)mc_moduleDidBecomeActive:(MCContext *)context;
- (void)mc_moduleWillTerminate:(MCContext *)context;
- (void)mc_moduleDidReceiveRemoteNotification:(MCContext *)context;
- (void)mc_moduleDidRegisterRemoteNotificationDeviceToken:(MCContext *)context;

- (void)mc_moduleHandleOpenURL:(MCContext *)context;
- (void)mc_moduleHandleOpenURL_SourceApplication_Annotation:(MCContext *)context;
- (void)mc_moduleHandleOpenURL_Options:(MCContext *)context;

@end
