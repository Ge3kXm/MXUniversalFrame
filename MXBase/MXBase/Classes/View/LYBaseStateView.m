//
//  LYBaseStateView.m
//  GameGuess_CN
//
//  Created by 高旗 on 16/8/4.
//  Copyright © 2016年 gaoqi. All rights reserved.
//

#import "LYBaseStateView.h"

@interface LYBaseStateView()

@property (nonatomic, strong) UIImageView *imageView;
//@property (nonatomic, strong) UILabel *labelTitle;
@property (nonatomic, strong) UIView *viewTitle;
@property (nonatomic, weak) id<LYBaseStateViewProtocol> child;
@end

@implementation LYBaseStateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if ([self conformsToProtocol:@protocol(LYBaseStateViewProtocol)]) {
            _child = (id<LYBaseStateViewProtocol>)self;
        } else {
            NSAssert(0, @"please incompletion LYBaseStateViewProtocol");
        }
        [self setupView];
        [self hide];
    }
    
    return self;
}

- (void)setHidden:(BOOL)hidden {
    [super setHidden:hidden];
    if (!hidden) {
        [self setNeedsLayout];
        [self layoutIfNeeded];
    }
}

- (void)hide
{
    [self setHidden:YES];
}
- (void)show
{
    [self setHidden:NO];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.imageSize.width == 0 || self.frame.size.width == 0) {
        return;
    }
    
    self.imageView.bounds = CGRectMake(0, 0, self.imageSize.width /* LYAdapteVMultiple*/, self.imageSize.height /* LYAdapteVMultiple*/);
    //    CGFloat screenHeight = LYScreen_Height - 64;
    //    CGFloat screenWidth = LYScreen_Width;
    CGRect curViewRect = [self convertRect:self.bounds toView:nil];
    
    
    CGFloat centerPtX = self.frame.size.width / 2.0;
    //    CGFloat centerPtY = curViewRect.size.height / 2.0;
    
    CGFloat realCenterX = centerPtX;
    CGFloat realCenterY = (curViewRect.size.height) / 2.0  /* LYAdapteVMultiple*/ ;
    
    
//    if (self.offsetY == 0) {
        self.imageView.center = CGPointMake(realCenterX, realCenterY + self.offsetY);
        self.viewTitle.center = CGPointMake(realCenterX, self.viewTitle.frame.size.height / 2.0 + 20 + CGRectGetMaxY(self.imageView.frame));
//    } else {
//        realCenterY = self.offsetY /* LYAdapteVMultiple*/ + self.imageView.frame.size.height / 2.0;
//        self.imageView.center = CGPointMake(realCenterX, realCenterY);
//        self.viewTitle.center = CGPointMake(realCenterX, self.viewTitle.frame.size.height / 2.0 + realCenterY /* LYAdapteVMultiple*/ + self.imageView.frame.size.height / 2.0);
//    }
    
}
#pragma mark - event response


#pragma mark - private method
- (void)setupView
{
    [self addSubview:self.imageView];
    [self addSubview:self.viewTitle];
    
}


#pragma mark - setter and getter

//- (void)setImageName:(NSString *)imageName
//{
//    _imageName = imageName;
//    self.imageView.image = LYImage(imageName);
//}

- (void)setImage:(UIImage *)image {
    _image = image;
    self.imageView.image = image;
}

- (void)setImageSize:(CGSize)imageSize
{
    _imageSize = imageSize;
}

- (void)setOffsetY:(CGFloat)offsetY
{
    _offsetY = offsetY;
}

- (UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [UIImageView new];
    }
    
    return _imageView;
}

- (UIView *)viewTitle
{
    if (_viewTitle == nil) {
        if ([self.child respondsToSelector:@selector(requestView)]) {
            _viewTitle = [self.child requestView];
        }
        
        if (_viewTitle == nil) {
            _viewTitle = [[UIView alloc] init];
        }
    }
    
    return _viewTitle;
}

@synthesize showing = _showing;
- (void)setShowing:(BOOL)showing {
    _showing = showing;
    if (showing) {
        [self show];
    } else {
        [self hide];
    }
}

@end
