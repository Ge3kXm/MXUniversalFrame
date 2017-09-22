//
//  LYNetworkErrorView.m
//  LYCampusSocial
//
//  Created by J on 2016/11/24.
//  Copyright © 2016年 HHLY. All rights reserved.
//

#import "LYNetworkErrorView.h"
@import Masonry;
#import "Categories.h"
#import "MXBaseResource.h"

//#import "LYIPBaseResourceManager.h"

@interface LYNetworkErrorView ()

@property (nonatomic, strong) UIButton *buttonTitle;
@property (nonatomic, strong) UILabel *label;

@property (nonatomic, copy) LYNetworkCallBack refreshBlock;

@end

@implementation LYNetworkErrorView


+ (instancetype)viewWithOffsetY:(CGFloat)offsetY refreshBlock:(LYNetworkCallBack)refreshBlock {
    LYNetworkErrorView *view = [[[self class] alloc] initWithFrame:CGRectZero];
    view.backgroundColor = MXColor(10);
    if (offsetY == LYBaseStateViewDefaultValue) {
        view.offsetY = 85;
    } else {
        view.offsetY = offsetY;
    }
//#warning fix network error image
//    view.imageName = @"image_nonetwor";//@"image_nonetwor";
    view.image = MXImage(@"fanhui");
    view.imageSize =  CGSizeMake(105, 105);
    view.refreshBlock = refreshBlock;
    return view;
}

+ (instancetype)viewWithBlock:(LYNetworkCallBack)refreshBlock {
    return [LYNetworkErrorView viewWithOffsetY:85 refreshBlock:refreshBlock];
}
#pragma mark - LYBaseStateViewProtocol
- (UIView *)requestView
{
    UIView *viewContent = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)];
    [viewContent addSubview:self.label];
    [viewContent addSubview:self.buttonTitle];
    
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(viewContent).offset(15);
        make.left.right.equalTo(viewContent);
    }];
    
    [self.buttonTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.label.mas_bottom).offset(20);
        make.centerX.equalTo(viewContent);
        make.width.equalTo(@109);
    }];
    return viewContent;
}

#pragma mark - event response
- (void)buttonDidClicked:(id)sender
{
    if (self.refreshBlock) {
        self.refreshBlock(self);
    }
}
#pragma mark - setter and getter
- (UILabel *)label
{
    if (_label == nil) {
        _label = [UILabel new];
        _label.text = @"网络出错啦，请检查网络设置";
        _label.font = MXFont(4);
        _label.textColor = MXColor(4);
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}
- (UIButton *)buttonTitle
{
    if (_buttonTitle == nil) {
        _buttonTitle = [[UIButton buttonWithType:UIButtonTypeCustom] mx_construct:^(UIButton *btn) {
            [btn setTitle:@"重新加载" forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(buttonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitleColor:MXColor(1) forState:UIControlStateNormal];
            btn.titleLabel.font = MXFont(3);
            btn.layer.borderWidth = 0.5;
            btn.layer.borderColor = MXColor(1).CGColor;
            btn.layer.cornerRadius = 3.0f;
            btn.layer.masksToBounds = YES;
        }];
    }
    
    return _buttonTitle;
}
@end
