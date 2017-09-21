//
//  MXTabBarConfig.m
//  MXBase
//
//  Created by maRk on 2017/9/21.
//  Copyright © 2017年 maRk. All rights reserved.
//

#import "MXTabBarConfig.h"
#import <objc/runtime.h>
#import "Categories.h"

@implementation MXTabBarItemConfig


@end


@implementation MXTabBarConfig


@end

////////////////////////////////////////////////////////////////////////////
@implementation UITabBar (MXTabbarConfig)

- (void)setMx_config:(MXTabBarConfig *)mx_config {
    objc_setAssociatedObject(self, @selector(mx_config), mx_config, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (!mx_config.backgroundImage) {
        mx_config.backgroundImage = [UIImage mx_imageWithColor:mx_config.backgroundColor];
    }
    [self setBackgroundImage:mx_config.backgroundImage];
    [self setShadowImage:mx_config.shadowImage];
}

- (MXTabBarConfig *)mx_config {
    return objc_getAssociatedObject(self, _cmd);
}

@end



@implementation UITabBarItem (MXTabbarItemConfig)

- (void)setMx_config:(MXTabBarItemConfig *)mx_config {
    objc_setAssociatedObject(self, @selector(mx_config), mx_config, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    [self setTitleTextAttributes:mx_config.titleTextAttributes[@(UIControlStateNormal)] forState:UIControlStateNormal];
    [self setTitleTextAttributes:mx_config.titleTextAttributes[@(UIControlStateSelected)] forState:UIControlStateSelected];
}

- (MXTabBarItemConfig *)mx_config {
    return objc_getAssociatedObject(self, _cmd);
}

@end
