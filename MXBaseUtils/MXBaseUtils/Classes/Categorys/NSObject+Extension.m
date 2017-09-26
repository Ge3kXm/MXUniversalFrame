//
//  NSObject+Extension.m
//  MXBaseUtils
//
//  Created by maRk on 2017/9/25.
//

#import "NSObject+Extension.h"

@implementation NSObject (Extension)

- (instancetype)mx_construct:(void (^)(id x))constructor {
    if (constructor) constructor(self);
    return self;
}

@end
