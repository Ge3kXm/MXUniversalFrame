//
//  MXRuntimeUtil.h
//  MXBaseUtils
//
//  Created by maRk on 2017/9/26.
//

#import <Foundation/Foundation.h>
#import "MXTuple.h"

@interface MXRuntimeUtil : NSObject

/**
 根据签名获取参数类型

 @param anInvocation NSInvocation
 @return tuple 参数
 */
+ (MXTuple *)getInvocationArguments:(NSInvocation *)anInvocation;


/**
 给对象发送消息

 @param selector 消息
 @param target 对象
 @param signature 签名
 @param tuple 参数
 @return value description
 */
+ (id)sendMessage:(SEL)selector toTarget:(id)target signature:(NSMethodSignature *)signature tuple:(MXTuple *)tuple;


/**
 从协议中获取方法签名

 @param selector 消息
 @param aProtocol 协议
 @return value description
 */
+ (char *)getTypesForSelector:(SEL)selector fromProtocol:(Protocol *)aProtocol;


/**
 将对于类型打包成id类型

 @param type aencode(int) ....
 @param ... 一般只写一个参数，值
 @return value
 */
id _MXBoxValue(const char *type, ...);
@end
