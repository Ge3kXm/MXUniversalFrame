//
//  MXAppearanceManager+UICommon.m
//  MXBase
//
//  Created by maRk on 2017/9/21.
//  Copyright © 2017年 maRk. All rights reserved.
//

#import "MXAppearanceManager+UICommon.h"
#import <objc/runtime.h>
#import "Categories.h"

@implementation MXAppearanceManager (UICommon)

- (void)setTheme:(MXThemeType)theme {
    objc_setAssociatedObject(self, @selector(theme), @(theme), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (MXThemeType)theme
{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}
@end

//////////////////////////////////////////////////////////////////////

@implementation MXNavigationBarConfig (MXAppearanceManager)

- (instancetype)initWithType:(MXThemeType)type {
    if (self = [self init]) {
        switch (type) {
            case MXThemeTypeDefault: {
                
                self.backgroundColor = MXColor(10);
                self.backgroundImage = [UIImage mx_imageWithColor:MXColor(11)];
//                self.shadowImage = [UIImage mx_imageWithColor:MXColorRGB(180, 180, 180, 0.4)];
                self.titleColor = [UIColor blackColor];
                self.titleTextAttributes = @{
                                             //                                             NSFontAttributeName:[UIFont boldSystemFontOfSize:20],
                                             NSForegroundColorAttributeName:MXColor(14),
                                             }.mutableCopy;
                self.tintColor = [UIColor blackColor];
                self.translucent = NO;
                
                break;
            }
                
            default:break;
                
        }
    }
    return self;
}


@end

//////////////////////////////////////////////////////////////////////

@implementation MXTabBarConfig (MXAppearanceManager)

- (instancetype)initWithType:(MXThemeType)type {
    if (self = [super init]) {
        self.shadowImage = [UIImage mx_imageWithColor:MXColor(9)];
        switch (type) {
            case MXThemeTypeDefault: {
                self.backgroundColor = MXColor(10);
                break;
            }
            default:
                break;
        }
    }
    return self;
}


@end

//////////////////////////////////////////////////////////////////////

@implementation MXTabBarItemConfig (MXAppearanceManager)

- (instancetype)initWithType:(MXThemeType)type {
    if (self = [super init]) {
        // 普通状态下的文字属性
        NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
        // 选中状态下的文字属性
        NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
        switch (type) {
            case MXThemeTypeDefault: {
                normalAttrs[NSForegroundColorAttributeName] = MXColor(2);
                selectedAttrs[NSForegroundColorAttributeName] = MXColor(1);
                break;
            }
            default:
                break;
        }
        self.titleTextAttributes = @{
                                     @(UIControlStateNormal) : normalAttrs,
                                     @(UIControlStateSelected) : selectedAttrs,
                                     }.mutableCopy;
    }
    return self;
}

@end

