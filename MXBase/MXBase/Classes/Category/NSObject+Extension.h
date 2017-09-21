//
//  NSObject+Extension.h
//  MXBase
//
//  Created by maRk on 2017/9/21.
//  Copyright © 2017年 maRk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extension)

- (instancetype)mx_construct:(void(^)(id))constructer;

@end
