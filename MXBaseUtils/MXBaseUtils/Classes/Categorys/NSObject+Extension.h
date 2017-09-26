//
//  NSObject+Extension.h
//  MXBaseUtils
//
//  Created by maRk on 2017/9/25.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extension)

- (instancetype)mx_construct:(void (^)(id x))constructor;

@end
