//
//  MXTabBarConfig.h
//  MXBase
//
//  Created by maRk on 2017/9/21.
//  Copyright © 2017年 maRk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MXTabBarItemConfig : NSObject

@property (nonatomic, strong) NSMutableDictionary<NSNumber *, NSDictionary *> *titleTextAttributes;

@end

////////////////////////////////////////////////////////////////////////////

@interface MXTabBarConfig : NSObject

@property (nonatomic, strong) UIImage *shadowImage;
@property (nonatomic, strong) UIImage *backgroundImage;
@property (nonatomic, strong) UIColor *backgroundColor;

@end

////////////////////////////////////////////////////////////////////////////
@interface UITabBar (MXTabbarConfig)

@property (nonatomic, strong) MXTabBarConfig *mx_config;

@end

////////////////////////////////////////////////////////////////////////////

@interface UITabBarItem (MXTabbarItemConfig)

@property (nonatomic, strong) MXTabBarItemConfig *mx_config;

@end
