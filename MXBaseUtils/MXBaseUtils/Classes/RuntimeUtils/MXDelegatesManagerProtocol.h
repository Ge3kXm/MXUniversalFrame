//
//  MXDelegatesManagerProtocol.h
//  MXBaseUtils
//
//  Created by maRk on 2017/9/26.
//

#import <Foundation/Foundation.h>
#import <MXTuple.h>

@protocol MXDelegatesManagerProtocol <NSObject>

/**
 返回默认的协议，实现此方法后，才可使用

 @return 默认协议
 */
- (Protocol *)defaultManagedProtocol;


#pragma mark - 下列方法不用自己实现，已在NSObject+DelegatesManagerProtocol.m中实现，直接调用即可
/**
 添加和移除一个代理

 @param delegate 代理对象
 */
- (void)addDelegate:(id)delegate;
- (void)removeDelegate:(id)delegate;


/**
 通知代理，并且使用 @see -[manageredDefaultProtocol] 返回的协议

 @param selector 协议中的方法
 @param tuple 参数
 */
- (void)notifyDelegatesForSelector:(SEL)selector tuple:(MXTuple *)tuple;


/**
 为某个协议添加和移除代理对象

 @param delegate 代理
 @param protocol 协议
 */
- (void)addDelegate:(id)delegate forProtocol:(Protocol *)protocol;
- (void)removeDelegate:(id)delegate forProtocol:(Protocol *)protocol;


/**
 通知代理，并且使用 @see -[manageredDefaultProtocol] 返回的协议

 @param selector 协议中的方法
 @param protocol 协议
 @param tuple 参数
 */
- (void)notifyDelegatesForSelector:(SEL)selector forProtocol:(Protocol *)protocol tuple:(MXTuple *)tuple;
@end
