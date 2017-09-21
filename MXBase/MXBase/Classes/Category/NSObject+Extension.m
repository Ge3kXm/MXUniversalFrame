//
//  NSObject+Extension.m
//  MXBase
//
//  Created by maRk on 2017/9/21.
//  Copyright © 2017年 maRk. All rights reserved.
//

#import "NSObject+Extension.h"

@implementation NSObject (Extension)

- (instancetype)mx_construct:(void(^)(id x))constructer {
    if (constructer) constructer(self);
    return self;
}

@end
