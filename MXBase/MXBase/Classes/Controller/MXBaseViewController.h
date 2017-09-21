//
//  MXBaseViewController.h
//  MXBase
//
//  Created by maRk on 2017/9/21.
//  Copyright © 2017年 maRk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXBaseResource.h"

@interface MXBaseViewController : UIViewController

/// 拖动返回手势
@property (nonatomic, assign) BOOL panGestureBackable;

/// 点击返回按钮交互
@property (nonatomic, copy  ) void (^baseBackAction)(UIViewController *vc);

///////////////////////////////////////设置样式///////////////////////////////////////

/**
 返回一个样式，此样式在ViewWillAppear中显示
 返回nil则不会配置
 */
- (MXNavigationBarConfig *)navigationBarConfig;


/**
 设置导航栏
 */
- (void)setupNavigationItem;


/**
 设置返回按钮的图片
 */
- (void)setDefaultBackImage;

///////////////////////////////////////交互///////////////////////////////////////
/**
 *  控制器将要pop
 */
- (void)willPop;

/**
 点击左上返回按钮时，是否允许返回
 */
- (BOOL)shouldPop;

///////////////////////////////////////配置无网络///////////////////////////////////////

/**
 设置VC的无网络界面是否显示
 
 @param showing showing description
 */
- (void)setDefaultNetErrorPageShowing:(BOOL)showing;


/**
 是否需要显示无网络界面
 
 @return return value description
 */
- (BOOL)shouldShowDefaultNetErrorPage;

/**
 需要无网络页面的view
 
 @return return value description
 */
- (NSArray<UIView *> *)viewsForShowingDefaultNetErrorPage;


/**
 设置无网络页面的offset
 
 @param view view description
 @return return value description
 */
- (CGFloat)netErrorPageOffsetForView:(UIView *)view;


/**
 无网络页面的reload操作
 
 @param view view description
 */
- (void)defaultNetErrorPageReloadActionForView:(UIView *)view;

///////////////////////////////////////是否需要页面统计///////////////////////////////////////

- (BOOL)needPageTracking;
@end
