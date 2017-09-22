//
//  UIView+State.m
//  MXBase
//
//  Created by maRk on 2017/9/21.
//  Copyright © 2017年 maRk. All rights reserved.
//

#import "UIView+State.h"

#import "MXBaseMacros.h"
@import Masonry;

#import <objc/runtime.h>


static NSString *mx_baseState_offsetY   = @"mx_baseState_offsetY";
static NSString *mx_baseState_image     = @"mx_baseState_image";
static NSString *mx_baseState_imageSize = @"mx_baseState_imageSize";
static NSString *mx_baseState_text      = @"mx_baseState_text";
static NSString *mx_baseState_callback  = @"mx_baseState_callback";

static const NSInteger mx_baseState_defaultValue = -1;

@implementation UIView (State)

///////////////////////////////////////配置默认页面///////////////////////////////////////
- (void)mx_configureStateViewWithOffsetY:(CGFloat)offsetY imageSize:(CGSize)imageSize image:(UIImage *)image text:(NSString *)text {
    objc_setAssociatedObject(self, @selector(mx_getStateConfig), @{
                                                                   mx_baseState_offsetY : @(offsetY),
                                                                 mx_baseState_imageSize : @(imageSize),
                                                                     mx_baseState_image : image,
                                                                      mx_baseState_text : text,
                                                                   
                                                                   }, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)mx_getStateConfig {
    NSDictionary *stateConfig =  objc_getAssociatedObject(self, _cmd);
    if (!stateConfig) {
        stateConfig = @{
                        mx_baseState_offsetY : @(mx_baseState_defaultValue),
                      mx_baseState_imageSize : [NSValue valueWithCGSize:CGSizeMake(105, 105)]
                        };
    }
    return stateConfig;
}

- (void)mx_setStateViewShowing:(BOOL)showing {
    if (showing) {
        [self mx_showStateView];
    }else {
        [self mx_hideStateView];
    }
}

- (void)mx_showStateView {
    [self.mx_stateView removeFromSuperview];
    
    NSDictionary *stateConfig = [self mx_getStateConfig];
    
    CGFloat offsetY  = [stateConfig[mx_baseState_offsetY] floatValue];
    CGSize imageSize = [stateConfig[mx_baseState_imageSize] CGSizeValue];
    UIImage *image   = stateConfig[mx_baseState_image];
    NSString *text   = stateConfig[mx_baseState_text];
    
    LYCommonImageTitleStateView *stateView = [LYCommonImageTitleStateView
                                              viewWithOffsetY:offsetY
                                                         text:text
                                                        image:image
                                                    imageSize:imageSize];
    [self addSubview:stateView];
    [stateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    self.mx_stateView = stateView;

    [self.mx_stateView show];
}

- (void)mx_hideStateView {
    [self.mx_stateView hide];
    [self.mx_stateView removeFromSuperview];
    self.mx_stateView = nil;
}


///////////////////////////////////////配置无网络页面///////////////////////////////////////
- (void)mx_configureNetErrorViewWithOffsetY:(CGFloat)offsetY
                                   callback:(LYNetworkCallBack)callback {
    objc_setAssociatedObject(self, @selector(mx_getErrorConfig), @{
                                                                   mx_baseState_offsetY : @(offsetY),
                                                                  mx_baseState_callback : callback,
                                                                   
                                                                   }, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)mx_getErrorConfig {
    NSDictionary *errorConfig =  objc_getAssociatedObject(self, _cmd);
    if (!errorConfig) {
        errorConfig = @{
                        mx_baseState_offsetY : @(mx_baseState_defaultValue),
                        };
    }
    return errorConfig;
    
}

- (void)mx_setNetErrorViewShowing:(BOOL)showing {
    if (showing) {
        [self mx_showErrorView];
    }else {
        [self mx_hideErrorView];
    }
}

- (void)mx_showErrorView {
    [self.mx_netErrorView removeFromSuperview];
    
    NSDictionary *errorConfig = [self mx_getErrorConfig];
    
    CGFloat offsetY = [errorConfig[mx_baseState_offsetY] floatValue];
    LYNetworkCallBack callback = errorConfig[mx_baseState_callback];
    
    LYNetworkErrorView *errorView = [LYNetworkErrorView viewWithOffsetY:offsetY refreshBlock:callback];
    [self addSubview:errorView];
    [errorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
    self.mx_netErrorView = errorView;
    
    [self.mx_netErrorView show];
}

- (void)mx_hideErrorView {
    [self.mx_netErrorView hide];
    [self.mx_netErrorView removeFromSuperview];
    self.mx_netErrorView = nil;
}

///////////////////////////////////////生成属性///////////////////////////////////////
MX_DYNAMIC_PROPERTY_OBJECT(mx_stateView, setMx_stateView, OBJC_ASSOCIATION_RETAIN_NONATOMIC, LYCommonImageTitleStateView *)
MX_DYNAMIC_PROPERTY_OBJECT(mx_netErrorView, setMx_netErrorView, OBJC_ASSOCIATION_RETAIN_NONATOMIC, LYNetworkErrorView *)

@end
