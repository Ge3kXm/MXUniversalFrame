//
//  MXBaseViewController.m
//  MXBase
//
//  Created by maRk on 2017/9/21.
//  Copyright © 2017年 maRk. All rights reserved.
//

#import "MXBaseViewController.h"
#import "MXAppearanceManager+UICommon.h"

@interface MXBaseViewController ()

@end

@implementation MXBaseViewController

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationItem];
    [self setDefaultBackImage];
}

- (MXNavigationBarConfig *)navigationBarConfig {
    return [[MXNavigationBarConfig alloc] initWithType:MXThemeTypeDefault];
}

- (void)setDefaultBackImage {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setImage:[self backButtonImage] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(defaultBackAction:) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)setupNavigationItem {}

#pragma mark - Private
- (UIImage *)backButtonImage {
    return nil;
}

- (void)defaultBackAction:(id)sender {
    if (_baseBackAction) {
        _baseBackAction(self);
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

///////////////////////////////////////交互///////////////////////////////////////
- (void)willPop {}

- (BOOL)shouldPop {
    return YES;
}

- (void)setDefaultNetErrorPageShowing:(BOOL)showing {
    
}

- (BOOL)shouldShowDefaultNetErrorPage {
    return YES;
}

- (NSArray<UIView *> *)viewsForShowingDefaultNetErrorPage {
    return @[self.view];
}


- (CGFloat)netErrorPageOffsetForView:(UIView *)view {
    return 100;
}

- (void)defaultNetErrorPageReloadActionForView:(UIView *)view {
    
}

///////////////////////////////////////是否需要页面统计///////////////////////////////////////

- (BOOL)needPageTracking {
    return YES;
}

@end