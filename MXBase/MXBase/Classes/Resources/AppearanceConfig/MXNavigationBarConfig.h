//
//  MXNavigationBarConfig.h
//  MXBase
//
//  Created by maRk on 2017/9/21.
//  Copyright © 2017年 maRk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MXNavigationBarConfig : NSObject

@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic, strong) UIImage *backgroundImage;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIImage *shadowImage;

@property (nonatomic, assign) BOOL hideShadowImage;

@property (nonatomic, assign) BOOL translucent;

@property (nonatomic, assign) NSTimeInterval animationDuration;

@property (nonatomic, strong) NSMutableDictionary *titleTextAttributes;


/**
 透明，黑字
 */
+ (instancetype)lucencyConfig;


/**
 白底黑字
 */
+ (instancetype)whiteBaseConfig;

@end
//////////////////////////////////////////////////////////////////////////////


@interface UINavigationBar (MXNavigationBarConfig)

@property (nonatomic, strong) MXNavigationBarConfig *mx_preConfig;
@property (nonatomic, strong) MXNavigationBarConfig *mx_config;

@property (nonatomic, strong) id mx_configurer;

- (void)setMx_config:(MXNavigationBarConfig *)mx_config animated:(BOOL)animated;

- (void)setMx_config:(MXNavigationBarConfig *)mx_config configurer:(id)configurer;

@end
