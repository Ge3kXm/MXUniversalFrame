//
//  NSString+Extension.h
//  MXBaseUtils
//
//  Created by maRk on 2017/9/25.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

+ (void)swizzleClassMethod:(Class)class originSelector:(SEL)originSelector otherSelector:(SEL)otherSelector;

+ (void)swizzleInstanceMethod:(Class)class originSelector:(SEL)originSelector otherSelector:(SEL)otherSelector;

@end
