//
//  LYBaseStateView.h
//  GameGuess_CN
//
//  Created by 高旗 on 16/8/4.
//  Copyright © 2016年 gaoqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LYBaseStateViewProtocol <NSObject>

@optional
- (UIView *)requestView;

@end


static const NSInteger LYBaseStateViewDefaultValue = -1;

@interface LYBaseStateView : UIView <LYBaseStateViewProtocol>

@property (nonatomic, assign) CGFloat offsetY;
@property (nonatomic, assign) CGSize imageSize;
//@property (nonatomic, copy  ) NSString *imageName;
@property (nonatomic, strong) UIImage *image;

- (void)hide;
- (void)show;

@property (nonatomic, assign) BOOL showing;

@end
