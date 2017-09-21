//
//  LYCommonImageTitleStateView.m
//  LYCampusSocial
//
//  Created by J on 2016/11/24.
//  Copyright © 2016年 HHLY. All rights reserved.
//

#import "LYCommonImageTitleStateView.h"
#import "Categories.h"
#import "MXBaseResource.h"

@interface LYCommonImageTitleStateView ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation LYCommonImageTitleStateView

+ (instancetype)viewWithOffsetY:(CGFloat)offsetY text:(NSString *)text image:(UIImage *)image imageSize:(CGSize)imageSize {
    LYCommonImageTitleStateView *view = [[[self class] alloc] initWithFrame:CGRectZero];
    view.backgroundColor = MXColor(10);
    if (offsetY == LYBaseStateViewDefaultValue) {
        view.offsetY = 42;
    } else {
        view.offsetY = offsetY;
    }
    view.image = image;
    view.imageSize =  imageSize;
    view.titleLabel.text = text;
    [view.titleLabel sizeToFit];
    return view;
}

- (UIView *)requestView {
    return self.titleLabel;
}

- (void)setText:(NSString *)text{
    if (_text) {
        _text = nil;
    }
    _text = text;
    _titleLabel.text = _text;
    [_titleLabel sizeToFit];
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel new] mx_construct:^(UILabel *label) {
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = MXColor(4);
            label.font = MXFont(4);
        }];
    }
    
    return _titleLabel;
}

@end
