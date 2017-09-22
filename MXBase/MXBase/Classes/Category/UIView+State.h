//
//  UIView+State.h
//  MXBase
//
//  Created by maRk on 2017/9/21.
//  Copyright © 2017年 maRk. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LYCommonImageTitleStateView.h"
#import "LYNetworkErrorView.h"

@interface UIView (State)

@property (nonatomic, strong) LYCommonImageTitleStateView *mx_stateView;
@property (nonatomic, strong) LYNetworkErrorView *mx_netErrorView;

/**
 配置本view的状态属性
 
 @param offsetY offsetY description
 @param text text description
 @param imageSize imageSize description
 @param imageName imageName description
 */
- (void)mx_configureStateViewWithOffsetY:(CGFloat)offsetY
                               imageSize:(CGSize)imageSize
                                   image:(UIImage *)imageName
                                    text:(NSString *)text;

- (void)mx_setStateViewShowing:(BOOL)showing;


/**
 配置无网络页面
 
 @param offsetY offsetY description
 @param callback callback description
 */
- (void)mx_configureNetErrorViewWithOffsetY:(CGFloat)offsetY
                                   callback:(LYNetworkCallBack)callback;

- (void)mx_setNetErrorViewShowing:(BOOL)showing;

@end
