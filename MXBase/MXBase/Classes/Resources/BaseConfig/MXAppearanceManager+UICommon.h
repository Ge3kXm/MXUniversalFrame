//
//  MXAppearanceManager+UICommon.h
//  MXBase
//
//  Created by maRk on 2017/9/21.
//  Copyright © 2017年 maRk. All rights reserved.
//

#import "MXBaseResource.h"

typedef NS_ENUM(NSInteger, MXThemeType) {
    MXThemeTypeDefault,
};

@interface MXAppearanceManager (UICommon)

@property (nonatomic, assign) MXThemeType theme;
@end

//////////////////////////////////////////////////////////////////////

@interface MXNavigationBarConfig (MXAppearanceManager)

- (instancetype)initWithType:(MXThemeType)type;

@end

//////////////////////////////////////////////////////////////////////

@interface MXTabBarConfig (MXAppearanceManager)

- (instancetype)initWithType:(MXThemeType)type;

@end

//////////////////////////////////////////////////////////////////////

@interface MXTabBarItemConfig (MXAppearanceManager)

- (instancetype)initWithType:(MXThemeType)type;

@end


