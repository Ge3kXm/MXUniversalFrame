//
//  MXBaseNavigationController.m
//  MXBase
//
//  Created by maRk on 2017/9/21.
//  Copyright © 2017年 maRk. All rights reserved.
//

#import "MXBaseNavigationController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

#import "MXNavigationBarConfig.h"
#import "MXAppearanceManager+UICommon.h"

#import "MXPanGuestureBackable.h"

@interface MXBaseNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation MXBaseNavigationController

#pragma mark - Init
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super initWithNavigationBarClass:[MXNavigationBarConfig class] toolbarClass:[UIToolbar class]]) {
        [self pushViewController:rootViewController animated:YES];
    }
    return self;
}

- (void)viewDidLoad {
    _enablePanGuesture = YES;
    self.navigationBar.mx_config = [[MXNavigationBarConfig alloc] initWithType:MXThemeTypeDefault];
    self.fd_fullscreenPopGestureRecognizer.delegate = self;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)fd_gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    // Ignore when no view controller is pushed into the navigation stack.
    if (self.navigationController.viewControllers.count <= 1) {
        return NO;
    }
    
    // Ignore when the active view controller doesn't allow interactive pop.
    UIViewController *topViewController = self.navigationController.viewControllers.lastObject;
    if (topViewController.fd_interactivePopDisabled) {
        return NO;
    }
    
    // Ignore when the beginning location is beyond max allowed initial distance to left edge.
    CGPoint beginningLocation = [gestureRecognizer locationInView:gestureRecognizer.view];
    CGFloat maxAllowedInitialDistance = topViewController.fd_interactivePopMaxAllowedInitialDistanceToLeftEdge;
    if (maxAllowedInitialDistance > 0 && beginningLocation.x > maxAllowedInitialDistance) {
        return NO;
    }
    
    // Ignore pan gesture when the navigation controller is currently in transition.
    if ([[self.navigationController valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }
    
    // Prevent calling the handler when the gesture begins in an opposite direction.
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    if (translation.x <= 0) {
        return NO;
    }
    
    return YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    
    BOOL flag = [self fd_gestureRecognizerShouldBegin:gestureRecognizer];
    
    if ([gestureRecognizer isEqual:self.fd_fullscreenPopGestureRecognizer]) {
        UIViewController *topVC = [self.viewControllers lastObject];
        
        BOOL backable = YES;
        if ([topVC conformsToProtocol:@protocol(MXPanGuestureBackable)]) {
            backable = [(id<MXPanGuestureBackable>)topVC panGuestureBackable];
        }
        
        // 判断是否激活防止与scrollView的滑动手势冲突
        return flag && backable && [self shouldActivatePopGesture];
    }
    
    return flag && _enablePanGuesture;
}

- (BOOL)shouldActivatePopGesture {
    // 遍历自身栈顶controller的scrollView;
    UIViewController *vc = self.viewControllers.lastObject;
    NSMutableArray<UIScrollView *> *array = [NSMutableArray array];
    [self enumerateAllScrollViewForView:vc.view array:array];
    __block BOOL result = YES;
    [array enumerateObjectsUsingBlock:^(UIScrollView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.userInteractionEnabled && obj.scrollEnabled
            && obj.contentOffset.x != -obj.contentInset.left) {
            result = NO;
        }
        [obj.panGestureRecognizer requireGestureRecognizerToFail:self.fd_fullscreenPopGestureRecognizer];
    }];
    return result && _enablePanGuesture;
}

- (void)enumerateAllScrollViewForView:(UIView *)view array:(NSMutableArray *)array {
    [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGPoint p = [self.fd_fullscreenPopGestureRecognizer locationInView:obj];
        if (CGRectContainsPoint(obj.bounds, p)) {
            if ([obj isKindOfClass:[UIScrollView class]]) {
                [array addObject:obj];
            }
            [self enumerateAllScrollViewForView:obj array:array];
        } else if (!obj.clipsToBounds) {
            [self enumerateAllScrollViewForView:obj array:array];
        }
    }];
}
@end
