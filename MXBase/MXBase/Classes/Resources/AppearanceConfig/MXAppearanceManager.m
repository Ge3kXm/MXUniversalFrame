//
//  MXAppearanceManager.m
//  MXBase
//
//  Created by maRk on 2017/9/21.
//  Copyright © 2017年 maRk. All rights reserved.
//

#import "MXAppearanceManager.h"

@implementation MXAppearanceManager

static id __defaultInstance;
+ (instancetype)defaultManager {
    if (!__defaultInstance) {
        __defaultInstance = [[self alloc] init];
    }
    return __defaultInstance;
}

- (instancetype)init {
    if (self = [super init]) {
        _resManager = [YSResourceManager loadFromMainBundle];
        _imgManager = [[YSImageManager alloc] initWithBundle:[NSBundle mainBundle]];
    }
    return self;
}

- (void)setResBundle:(NSBundle *)resBundle {
    _resBundle = resBundle;
    _resManager.bundle = resBundle;
}

- (void)setImgBundle:(NSBundle *)imgBundle {
    _imgBundle = imgBundle;
    _imgManager = [[YSImageManager alloc] initWithBundle:imgBundle];
}


#pragma mark - 字体 以及 颜色

- (UIFont *)fontWithNumber:(int)number {
    return [self.resManager.fontManager fontWith:[NSString stringWithFormat:@"Size%d", number]];
//    return [UIFont systemFontOfSize:number];
}

- (UIFont *)boldFontWithNumber:(int)number {
    UIFont *font = [self fontWithNumber:number];
    return [UIFont boldSystemFontOfSize:font.pointSize];
}

- (UIColor *)colorWithNumber:(int)number {
    return [self.resManager.colorManager colorWith:[NSString stringWithFormat:@"Color%d", number]];
//    return [UIColor redColor];
}

- (UIColor *)colorWithNumber:(int)number alpha:(double)alpha {
    return [[self colorWithNumber:number] colorWithAlphaComponent:alpha];
}

- (UIImage *)imageWithName:(NSString *)name {
    return [_imgManager imageNamed:name];
}

- (NSString *)stringWithName:(NSString *)name {
    return [_resManager.stringManager stringWith:name];
}


@end
