//
//  MXMethodUtil.m
//  MXBaseUtils
//
//  Created by maRk on 2017/9/26.
//

#import "MXMethodUtil.h"
#import "MXRuntimeUtil.h"

@implementation MXMethodUtil

+ (id)safelySendMsg:(SEL)selector toTarget:(id)target tuple:(MXTuple *)tuple {
    if (!target || ![target respondsToSelector:selector]) {
        return NULL;
    }
    NSMethodSignature *signature = [target methodSignatureForSelector:selector];
    return [MXRuntimeUtil sendMessage:selector toTarget:target signature:signature tuple:tuple];
}

+ (void)safelySendMsg:(SEL)selector toTargets:(NSArray *)targets tuple:(MXTuple *)tuple {
    [targets enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self safelySendMsg:selector toTarget:obj tuple:tuple];
    }];
}


@end

/////////////////////////////////////////////////////////////////////////////////////

@implementation NSObject (MXMethodTool)

- (id)safelySendMsg:(SEL)selector tuple:(MXTuple *)tuple {
    return [MXMethodUtil safelySendMsg:selector toTarget:self tuple:tuple];
}

@end

/////////////////////////////////////////////////////////////////////////////////////

@implementation NSArray (MXMethodToolArray)

- (void)safelySendMsg:(SEL)selector tuple:(MXTuple *)tuple {
    [MXMethodUtil safelySendMsg:selector toTargets:self tuple:tuple];
}

@end
