//
//  MCModuleConnector.m
//  MXModuleConnector
//
//  Created by maRk on 2017/9/27.
//

#import "MCModuleConnector.h"
#import "MCService.h"
#import <objc/runtime.h>


/**
 有的已经在父类的分类中实现，比如NSObject的分类中实现，故需要检查父类是否实现协议
 NSObject类中的成员方法conformsToProtocol能判断当前类与父类是否符合协议方法
 但是，class_conformsToProtocol方法只检查当前类，不会检查父类
 */
BOOL checkConfirmProtocolIncludingSuperClass(Class aClass, Protocol *protocol) {
    if (!aClass) {
        return NO;
    }
    if (!class_conformsToProtocol(aClass, protocol)) {
        return checkConfirmProtocolIncludingSuperClass(class_getSuperclass(aClass), protocol);
    }
    return YES;
}

@interface MCModuleConnector()

@property (nonatomic, strong) NSMutableDictionary <NSString *, MCService *> *servicesDic;
@property (nonatomic, strong) NSMutableArray <MCModule *>* modules;
@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation MCModuleConnector

static MCModuleConnector *__sharedInstance;
+ (instancetype)shared {
    if (__sharedInstance) return __sharedInstance;
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [super allocWithZone:zone];
    });
    return __sharedInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        _servicesDic = [NSMutableDictionary dictionary];
        _modules     = [NSMutableArray array];
        _queue       = [[NSOperationQueue alloc] init];
        _queue.maxConcurrentOperationCount = 1;
    }
    return self;
}

- (void)registerModule:(Class<ModuleConnectorProtocol>)aClass {
    [self registerModule:aClass priority:MCModulePriority_Low];
}

- (void)registerModule:(Class<ModuleConnectorProtocol>)aClass priority:(MCModulePriority)priority {
    NSAssert(checkConfirmProtocolIncludingSuperClass(aClass, @protocol(ModuleConnectorProtocol)), @"必须先实现ModuleConnectorProtocol协议");
    
    [self adddOperation:^{
        MCModule *module = [MCModule moduleWithClass:aClass :priority];
        [_modules addObject:module];
        [_modules sortUsingComparator:^NSComparisonResult(MCModule * _Nonnull obj1, MCModule * _Nonnull obj2) {
            return obj1.priority > obj2.priority ? NSOrderedAscending : NSOrderedDescending;
        }];
    }];
}

- (void)registerServiceForProtocol:(Protocol *)aProtocol clazz:(Class<ExportableProtocol>)clazz {
    NSAssert(protocol_conformsToProtocol(aProtocol, @protocol(ExportableProtocol)), @"协议必须先继承ExportableProtocol协议");
    NSAssert(checkConfirmProtocolIncludingSuperClass(clazz, aProtocol), @"必须先实现协议");
    
    [self adddOperation:^{
        MCService *service = _servicesDic[NSStringFromClass(clazz)];
        NSAssert(!service, @"服务已存在，不能再次注册");
        _servicesDic[NSStringFromProtocol(aProtocol)] = [MCService serviceWithClass:clazz];
    }];
}

- (id _Nullable)serviceWithProtocol:(Protocol *)aProtocol {
    
    __block id<ExportableProtocol> service;
    
    [self adddOperation:^{
        [_servicesDic[NSStringFromProtocol(aProtocol)] getService];
    }];
    return service;
}

- (void)removeServiceForProtocol:(Protocol *)aProtocol {
    [_servicesDic removeObjectForKey:NSStringFromProtocol(aProtocol)];
}

- (void)adddOperation:(dispatch_block_t)operationBlock {
#warning 有待商榷
    if ([_queue isEqual:[NSOperationQueue currentQueue]]) {
        if (operationBlock) operationBlock();
    }else {
        NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^(){
            if (operationBlock) operationBlock();
        }];
        [_queue addOperation:operation];
        [operation waitUntilFinished];
    }
}

- (void)triggerEvent:(MCModuleEvent)event {
    [self notifyAllModuleWithSelector:[self selectorForEvent:event]];
}

- (SEL)selectorForEvent:(MCModuleEvent)event {
    switch (event) {
        case MCModuleEventSetup:return @selector(mc_moduleSetup:);
        case MCModuleEventInit:return @selector(mc_moduleInit:);
        case MCModuleEventSplash:return @selector(mc_moduleSplash:);
        case MCModuleEventWillTerminate:return @selector(mc_moduleWillTerminate:);
        case MCModuleEventDidBecomeActive:return @selector(mc_moduleDidBecomeActive:);
        case MCModuleEventWillResignActive:return @selector(mc_moduleWillResignActive:);
        case MCModuleEventDidEnterBackground:return @selector(mc_moduleDidEnterBackground:);
        case MCModuleEventWillEnterForeground:return @selector(mc_moduleWillEnterForeground:);
        case MCModuleEventDidReceiveRemoteNotification:return @selector(mc_moduleDidReceiveRemoteNotification:);
        case MCModuleEventDidRegisterForRemoteNotification:return @selector(mc_moduleDidRegisterRemoteNotificationDeviceToken:);
        case MCModuleEventOpenURL:return @selector(mc_moduleHandleOpenURL:);
        case MCModuleEventOpenURL_SourceApplication_Annotation:return @selector(mc_moduleHandleOpenURL_SourceApplication_Annotation:);
        case MCModuleEventOpenURL_Options:return @selector(mc_moduleHandleOpenURL_Options:);
            
        default:{
            return nil;
        }
    }
}

- (void)triggerCustomEvent:(NSUInteger)eventCode {
    [_modules enumerateObjectsUsingBlock:^(MCModule * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.moduleObject respondsToSelector:@selector(mc_moduleActionCustomEvent:eventCode:)]) {
            [obj.moduleObject mc_moduleActionCustomEvent:[MCContext shared] eventCode:eventCode];
        }
    }];
}

#pragma mark private method

- (void)notifyAllModuleWithSelector:(SEL)selector {
    [_modules enumerateObjectsUsingBlock:^(MCModule *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.moduleObject respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [obj.moduleObject performSelector:selector withObject:[MCContext shared]];
#pragma clang diagnostic pop
        }
    }];
}

@end

////////////////////////////////////////////////////////////////////////////
@implementation NSObject (ExportableProtocolDefaultInstance)

+ (instancetype)ep_defaultInstance {
    return nil;
}

@end


//////////////////////////////////////////////////////////////////////////////
@implementation NSObject (ModuleAutowired)

static NSRegularExpression *_reg;
- (void)autowired {
    NSError *error;
    _reg = [[NSRegularExpression alloc] initWithPattern:@"\\b\\w+\\b" options:NSRegularExpressionCaseInsensitive error:&error];
    [self autowiredForClass:self.class];
}

- (void)autowiredForClass:(Class)aClass {
    unsigned int outCount = 0;
    Ivar *list = class_copyIvarList(aClass, &outCount);
    for (int i = 0; i < outCount; i++) {
        Ivar ivar = list[i];
        NSString *typeEncoding = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        if ([typeEncoding hasPrefix:@"@\"<"]) {
            NSArray<NSTextCheckingResult *> *result = [_reg matchesInString:typeEncoding options:NSMatchingReportProgress range:NSMakeRange(0, typeEncoding.length)];
            if (result.count) {
                
                NSString *protocolName = [typeEncoding substringWithRange:result.firstObject.range];
                Protocol *targetProtocol = NSProtocolFromString(protocolName);
                
                if (!protocol_conformsToProtocol(targetProtocol, @protocol(ExportableProtocol))) {
                    continue;
                }
                
                NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
                
                @try {
                    [self setValue:[[MCModuleConnector shared] serviceWithProtocol:objc_getProtocol(protocolName.UTF8String)]  forKey:ivarName];
                } @catch (NSException *exception) {
                    NSLog(@"%@", exception);
                } @finally {
                    
                }
            }
        }
    }
    free(list);
    Class superClass = class_getSuperclass(aClass);
    if (!superClass) return;
    
    [self autowiredForClass:superClass];
}

@end
