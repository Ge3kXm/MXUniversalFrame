//
//  MXDelegateWrapper.h
//  MXBaseUtils
//
//  Created by maRk on 2017/9/26.
//

#import <Foundation/Foundation.h>

@interface MXDelegateWrapper : NSObject

@property (nonatomic, weak, readonly) NSObject *wrapperDelegate;

+ (instancetype)wrapperWithTarget:(id)target andProtocol:(Protocol *)protocol;

@end
