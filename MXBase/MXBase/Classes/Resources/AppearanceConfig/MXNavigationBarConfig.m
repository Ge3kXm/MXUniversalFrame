//
//  MXNavigationBarConfig.m
//  MXBase
//
//  Created by maRk on 2017/9/21.
//  Copyright © 2017年 maRk. All rights reserved.
//

#import "MXNavigationBarConfig.h"
#import "MXAppearanceManager.h"
#import <objc/runtime.h>


@implementation MXNavigationBarConfig

- (instancetype)init {
    if (self = [super init]) {
        _shadowImage       = [UIImage new];
        _titleColor        = [UIColor whiteColor];
        _animationDuration = 0.3;
        _translucent       = YES;
        _hideShadowImage   = YES;
    }
    return self;
}

+ (instancetype)lucencyConfig {
    MXNavigationBarConfig *config = [[self alloc] init];
    config.backgroundImage        = [UIImage new];
    config.backgroundColor        = [UIColor clearColor];
    config.tintColor              = [UIColor blackColor];
    return config;
}

+ (instancetype)whiteBaseConfig {
    MXNavigationBarConfig *config = [[self alloc] init];
    config.backgroundColor        = [UIColor whiteColor];
//    config.backgroundImage        = [UIImage mx_imageWithColor:MXColor(11)];
//    config.shadowImage            = [UIImage mx_imageWithColor:MXColorRGB(180, 180, 180, 0.4)];
    config.titleColor             = [UIColor blackColor];
    config.titleTextAttributes    = @{
                                   NSForegroundColorAttributeName:[UIColor blackColor],
                                   }.mutableCopy;
    config.tintColor = [UIColor blackColor];
    return config;
}

@end
//////////////////////////////////////////////////////////////////////////////

@implementation UINavigationBar (MXNavigationBarConfig)

- (void)setMx_config:(MXNavigationBarConfig *)mx_config {
    [self setMx_config:mx_config animated:NO];
}

- (void)setMx_config:(MXNavigationBarConfig *)mx_config configurer:(id)configurer {
    BOOL flag = ![configurer isEqual:[self mx_configurer]];
    NSLog(@"%d", flag);
    [self setMx_config:mx_config animated:flag];
}

- (void)setMx_config:(MXNavigationBarConfig *)mx_config animated:(BOOL)animated {
    MXNavigationBarConfig *preConfig = self.mx_config;
    if (preConfig == mx_config) return;
    
    self.mx_preConfig = self.mx_config;
    objc_setAssociatedObject(self, @selector(mx_config), mx_config, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (mx_config.titleColor) {
        mx_config.titleTextAttributes[NSForegroundColorAttributeName] = mx_config.titleColor;
    } else {
        [mx_config.titleTextAttributes removeObjectForKey:NSForegroundColorAttributeName];
    }
    
    //    if (animated) {
    //        // 添加动画，让转变不那么突兀
    //        NSString *key = [NSString ly_uuid];
    //        CATransition *animation = [CATransition animation];
    //        animation.duration = ly_config.animationDuration;
    //        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //        animation.type = kCATransitionFade;
    //        [self.layer addAnimation:animation forKey:key];
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(animation.duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //            // 移除动画
    //            [self.layer removeAnimationForKey:key];
    //        });
    //    }
    [self setTranslucent:mx_config.translucent];
    [self setBarTintColor:mx_config.backgroundColor];
    [self setBackgroundImage:mx_config.backgroundImage forBarMetrics:UIBarMetricsDefault];
    [self setTintColor:mx_config.tintColor];
    [self setTitleTextAttributes:mx_config.titleTextAttributes];
    [self setShadowImage:mx_config.shadowImage];
    
    NSArray *classNameArray = @[@"_UINavigationBarBackground", @"_UIBarBackground"];
    if (mx_config.hideShadowImage) {
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([classNameArray containsObject:NSStringFromClass(obj.class)]) {
                [obj.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([obj isKindOfClass:[UIImageView class]]) {
                        obj.hidden = YES;
                    }
                }];
            }
        }];
    } else {
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([classNameArray containsObject:NSStringFromClass(obj.class)]) {
                [obj.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([obj isKindOfClass:[UIImageView class]]) {
                        obj.hidden = NO;
                    }
                }];
            }
        }];
    }
}

- (MXNavigationBarConfig *)mx_config {
    return objc_getAssociatedObject(self, _cmd);
}

- (id)mx_configurer {
    return objc_getAssociatedObject(self, @selector(setMx_configurer:));
}

- (void)setMx_configurer:(id)mx_configurer {
    objc_setAssociatedObject(self, _cmd, mx_configurer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (MXNavigationBarConfig *)mx_preConfig {
    return objc_getAssociatedObject(self, @selector(setMx_preConfig:));
}

- (void)setMx_preConfig:(MXNavigationBarConfig *)mx_preConfig {
    objc_setAssociatedObject(self, _cmd, mx_preConfig, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
