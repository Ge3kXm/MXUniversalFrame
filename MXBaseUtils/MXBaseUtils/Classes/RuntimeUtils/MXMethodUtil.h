//
//  MXMethodUtil.h
//  MXBaseUtils
//
//  Created by maRk on 2017/9/26.
//

#import <Foundation/Foundation.h>
#import "MXTuple.h"

@interface MXMethodUtil : NSObject

/**
 向target 发送任意消息，返回值若能响应则响应，不能响应则返回
 返回值为id
 
 @param selector selector
 @param target target
 @param tuple 参数列表 LYTupleCreate
 @return id 类型
 */
+ (id)safelySendMsg:(SEL)selector toTarget:(id)target tuple:(MXTuple *)tuple;

+ (void)safelySendMsg:(SEL)selector toTargets:(NSArray *)targets tuple:(MXTuple *)tuple;

@end


/////////////////////////////////////////////////////////////////////////////////////

@interface NSObject (LYMethodTool)

- (id)safelySendMsg:(SEL)selector tuple:(MXTuple *)tuple;

@end

/////////////////////////////////////////////////////////////////////////////////////

@interface NSArray (LYMethodToolArray)

- (void)safelySendMsg:(SEL)selector tuple:(MXTuple *)tuple;

@end
