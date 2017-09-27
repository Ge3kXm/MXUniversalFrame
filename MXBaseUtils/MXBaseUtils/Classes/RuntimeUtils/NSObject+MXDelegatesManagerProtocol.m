//
//  NSObject+MXDelegatesManagerProtocol.m
//  MXBaseUtils
//
//  Created by maRk on 2017/9/26.
//

#import "NSObject+MXDelegatesManagerProtocol.h"
#import "MXDelegateWrapper.h"
#import "MXMethodUtil.h"
#import <objc/runtime.h>
#import "MXDisposeBag.h"

@implementation NSObject (MXDelegatesManagerProtocol)

- (NSDictionary <NSString *, NSArray *> *)delegatesDic {
    return [[self _delegatesDic] copy];
}

- (void)addDelegate:(id)delegate {
    NSAssert([self respondsToSelector:@selector(defaultManagedProtocol)], @"必须先实现defaultManagedProtocol方法");
    [self addDelegate:delegate forProtocol:[self defaultManagedProtocol]];
}

- (void)removeDelegate:(id)delegate {
    NSAssert([self respondsToSelector:@selector(defaultManagedProtocol)], @"必须先实现defaultManagedProtocol方法");
    [self addDelegate:delegate forProtocol:[self defaultManagedProtocol]];
}

- (void)notifyDelegatesForSelector:(SEL)selector tuple:(MXTuple *)tuple {
    NSAssert([self respondsToSelector:@selector(defaultManagedProtocol)], @"必须先实现defaultManagedProtocol方法");
    [self notifyDelegatesForSelector:selector forProtocol:[self defaultManagedProtocol] tuple:tuple];
}

- (void)addDelegate:(id)delegate forProtocol:(Protocol *)protocol {
    NSMutableArray *delegatesForProtocol = [self getAllDelegatesForProtocol:protocol];
    MXDelegateWrapper *wrapper = [MXDelegateWrapper wrapperWithTarget:delegate andProtocol:protocol];
    @synchronized(self) {
        if (![delegatesForProtocol containsObject:wrapper]) {
            [delegatesForProtocol addObject:wrapper];
            [delegate actionWhenDealloc:^{
                [delegatesForProtocol removeObject:wrapper];
            }];
        }
    }
}

- (void)removeDelegate:(id)delegate forProtocol:(Protocol *)protocol {
    [[self getAllDelegatesForProtocol:protocol] removeObject:[MXDelegateWrapper wrapperWithTarget:delegate andProtocol:protocol]];
}

- (void)notifyDelegatesForSelector:(SEL)selector forProtocol:(Protocol *)protocol tuple:(MXTuple *)tuple {
    [[self getAllDelegatesForProtocol:protocol] enumerateObjectsUsingBlock:^(MXDelegateWrapper * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [MXMethodUtil safelySendMsg:selector toTarget:obj.wrapperDelegate tuple:tuple];
    }];
}

#pragma mark -
- (NSMutableDictionary <NSString *, NSMutableArray <MXDelegateWrapper *> *>*)_delegatesDic {
    NSMutableDictionary <NSString *, NSMutableArray <MXDelegateWrapper *> *> *delegatesDic = objc_getAssociatedObject(self, _cmd);
    if (!delegatesDic) {
        delegatesDic = @{}.mutableCopy;
        objc_setAssociatedObject(self, @selector(_delegatesDic), delegatesDic,  OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return delegatesDic;
}

- (NSMutableArray <MXDelegateWrapper *>*)getAllDelegatesForProtocol:(Protocol *)protocol{
    NSMutableDictionary <NSString *, NSMutableArray <MXDelegateWrapper *> *> *delegatesDic = [self _delegatesDic];
    NSMutableArray *delegates = delegatesDic[NSStringFromProtocol(protocol)];
    if (!delegates) {
        delegates = @[].mutableCopy;
        delegatesDic[NSStringFromProtocol(protocol)] = delegates;
    }
    return delegates;
}
@end
