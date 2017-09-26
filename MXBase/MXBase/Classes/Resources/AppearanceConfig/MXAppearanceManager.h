//
//  MXAppearanceManager.h
//  MXBase
//
//  Created by maRk on 2017/9/21.
//  Copyright © 2017年 maRk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YSResourceManager.h"
@import MXBaseUtils;

#define LOCALIZATION(_key_) [[MXAppearanceManager defaultManager] stringWithName:_key_]

#define MXFont(_number_) ([[MXAppearanceManager defaultManager] fontWithNumber:_number_])
#define MXBoldFont(_number_) ([[MXAppearanceManager defaultManager] boldFontWithNumber:_number_])

#define MXColor(_number_) ([[MXAppearanceManager defaultManager] colorWithNumber:_number_])
#define MXColorWithAlpha(_number_, _alpha_) ([[MXAppearanceManager defaultManager] colorWithNumber:_number_ alpha:_alpha_])

#define MXImage(_name_) [[MXAppearanceManager defaultManager] imageWithName:_name_]


@interface MXAppearanceManager : NSObject

@property (nonatomic, strong) NSBundle *resBundle;
@property (nonatomic, strong) NSBundle *imgBundle;

@property (nonatomic, strong) YSResourceManager *resManager;
@property (nonatomic, strong) YSImageManager    *imgManager;

+ (instancetype)defaultManager;

////////////////////////////////////Method////////////////////////////////////////
- (UIFont *)fontWithNumber:(int)number;

- (UIFont *)boldFontWithNumber:(int)number;

- (UIColor *)colorWithNumber:(int)number;

- (UIColor *)colorWithNumber:(int)number alpha:(double)alpha;

- (UIImage *)imageWithName:(NSString *)name;

- (NSString *)stringWithName:(NSString *)name;
@end
