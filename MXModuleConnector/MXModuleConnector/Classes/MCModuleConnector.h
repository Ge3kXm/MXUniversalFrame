//
//  MCModuleConnector.h
//  MXModuleConnector
//
//  Created by maRk on 2017/9/27.
//

#import <Foundation/Foundation.h>
#import "MCContext.h"
#import "MCModuleConnectorProtocol.h"
#import "MCModule.h"

// 注册模块，在启动时会自动遍历所有模块调用生命周期方法
#define MC_EXPORT_MODULE_PRIORIT(MCModulePriority)\
        + (void)load {\
        [[MCModuleConnector shared] registerModule:self priority:MCModulePriority];\
        }\
        + (BOOL)isSingleton {\
        return YES;\
        }

// 注册服务
#define MC_EXPORT_SERVICE_FOR_PROTOCOL(_protocol_, _isSingleton_) \
        + (void)load {\
        [[LYModuleConnector shared] registerServiceForProtocol:@protocol(_protocol_) clazz:self];\
        }\
        + (BOOL)isSingleton {\
        return _isSingleton_;\
        }
// 获取服务
#define GET_SERVICE(_protocol_) \
        ((id<_protocol_>)[[LYModuleConnector shared] serviceWithProtocol:@protocol(_protocol_)])


NS_ASSUME_NONNULL_BEGIN
///////////////////////////////////////自动实现属性中协议///////////////////////////////////////

@protocol ModuleAutowired <NSObject>

@optional

/**
 调用本方法，对应类中的 id<Service> _obj 属性，将自动赋值
 */
- (void)autowired NS_SWIFT_UNAVAILABLE("swift unusable");

@end

///////////////////////////////////////生命周期事件///////////////////////////////////////

typedef NS_ENUM(NSInteger, MCModuleEvent) {
    // 生命周期类型
    MCModuleEventSetup,
    MCModuleEventInit,
    MCModuleEventSplash,
    MCModuleEventWillResignActive,
    MCModuleEventDidEnterBackground,
    MCModuleEventWillEnterForeground,
    MCModuleEventDidBecomeActive,
    MCModuleEventWillTerminate,
    // 远程通知类型
    MCModuleEventDidReceiveRemoteNotification,
    MCModuleEventDidRegisterForRemoteNotification,
    
    // openURL类型
    MCModuleEventOpenURL,
    MCModuleEventOpenURL_SourceApplication_Annotation,
    MCModuleEventOpenURL_Options,
    
    // 预留自定义
    MCModuleEventCustomBegin = 10000,
};

////////////////////////////////////////////////////////////////////////////
@interface MCModuleConnector : NSObject

+ (instancetype)shared;

/**
 注册一个模块
 
 @param aClass aClass description
 */
- (void)registerModule:(Class<ModuleConnectorProtocol>)aClass;
- (void)registerModule:(Class<ModuleConnectorProtocol>)aClass priority:(MCModulePriority)priority;


/**
 给 aProtocol 注册一个 服务
 
 @param aProtocol aProtocol description
 @param clazz clazz description
 */
- (void)registerServiceForProtocol:(Protocol *)aProtocol clazz:(Class<ExportableProtocol>)clazz;


/**
 根据协议获取实现类
 
 @param aProtocol aProtocol description
 */
- (id _Nullable)serviceWithProtocol:(Protocol *)aProtocol;


/**
 移除一个服务
 
 @param aProtocol aProtocol description
 */
- (void)removeServiceForProtocol:(Protocol *)aProtocol;

/**
 触发app事件
 
 @param event event description
 */
- (void)triggerEvent:(MCModuleEvent)event;


/**
 触发自定义事件
 
 @param eventCode eventCode description
 */
- (void)triggerCustomEvent:(NSUInteger)eventCode;

@end
////////////////////////////////////////////////////////////////////////////
@interface NSObject (ExportableProtocolDefaultInstance)

@end

////////////////////////////////////////////////////////////////////////////
@interface NSObject (ModuleAutowired)<ModuleAutowired>

@end

////////////////////////////////////////////////////////////////////////////
NS_ASSUME_NONNULL_END
