//
//  MXDelegateWrapper.m
//  MXBaseUtils
//
//  Created by maRk on 2017/9/26.
//

#import "MXDelegateWrapper.h"

@implementation MXDelegateWrapper
{
    Protocol *_protocol;
    NSString *_targetDescription;
}

+ (instancetype)wrapperWithTarget:(id)target andProtocol:(Protocol *)protocol {
    MXDelegateWrapper *wrapper  = [[MXDelegateWrapper alloc] init];
    wrapper -> _protocol = protocol;
    wrapper -> _targetDescription = [target description];
    wrapper -> _wrapperDelegate = target;
    return wrapper;
}


/**
 由于数组中是MXDelegateWrapper对象而且需要调用数组containsObject、removeObject方法都会调用isEqual:
 故需要重写isEqual方法
 @param object 包含对象
 @return BOOL
 */
- (BOOL)isEqual:(id)object {
    
    if ([super isEqual:object]) {
        return YES;
    }
    if (![object isKindOfClass:[MXDelegateWrapper class]]) {
        return NO;
    }
    
    return [self.wrapperDelegate isEqual:[(MXDelegateWrapper *)object wrapperDelegate]];
}

@end
