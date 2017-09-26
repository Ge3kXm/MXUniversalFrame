//
//  UIView+Extension.h
//  MXBaseUtils
//
//  Created by maRk on 2017/9/25.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic, strong) IBInspectable UIColor *borderColor;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) CGFloat originX;
@property (nonatomic, assign) CGFloat originY;

@property (nonatomic, assign) CGFloat frameRight;
@property (nonatomic, assign) CGFloat frameBottom;

@property (nonatomic, assign) CGFloat frameWidth;
@property (nonatomic, assign) CGFloat frameHeight;

- (BOOL)mx_containsSubView:(UIView *)subView;
- (BOOL)mx_containsSubViewOfClassType:(Class)aClass;

+ (instancetype)viewFromXib;
/**将view变成高斯模糊**/
//-(UIImage *)imageRepresentation;

- (instancetype)mx_addToSuperview:(UIView *)superview;

/**
 - 解决取消按钮一直可点击问题
 */
- (void)changeSearhBarCancelBtn:(UIView *)view color:(UIColor *)color;

@end
