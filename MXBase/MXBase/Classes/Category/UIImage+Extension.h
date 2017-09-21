//
//  UIImage+Extension.h
//  MXBase
//
//  Created by maRk on 2017/9/21.
//  Copyright © 2017年 maRk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OpenGLES/ES1/glext.h>

typedef NS_ENUM(NSInteger, ColorSpreadType) {
    ColorSpreadTypeTopToBottom,
    ColorSpreadTypeLeftToRight,
    ColorSpreadTypeTopleftToRightBottom,
    ColorSpreadTypeTopRightToLeftBottom,
};

@interface UIImage (Extension)
/**
 *  @brief  根据颜色生产图片
 *
 *  @param color 颜色
 *  @param size  图片大小
 *
 *  @return 图片
 */
+ (instancetype)mx_imageWithColor:(UIColor *)color withSize:(CGSize)size;

/**
 *  @brief  根据颜色生成图片默认图片大小为(1,1)
 *
 *  @param color  颜色
 *
 *  @return 图片
 */
+ (instancetype)mx_imageWithColor:(UIColor *)color;

///切圆形
- (instancetype)mx_circleImage;
///切正方形
- (instancetype)mx_squareImage;

/**
 *  修正上传服务器后,图片的显示方向
 *
 */
- (UIImage *)mx_fixOrientation;
/**
 *  按比例缩小图片
 */
- (CGSize)mx_fixSizeWithImageSize:(CGSize)size rate:(NSInteger)rate;

- (UIImage *)imageWithTintColor:(UIColor *)tintColor;


/**
 获取渐变颜色图片
 
 @param colors colors description
 @param type type description
 @param size size description
 @return return value description
 */
+ (UIImage *)mx_gradientImageWithColors:(NSArray *)colors colorType:(ColorSpreadType)type size:(CGSize)size;


/* blur the current image with a box blur algoritm */
- (UIImage*)drn_boxblurImageWithBlur:(CGFloat)blur;

/* blur the current image with a box blur algoritm and tint with a color */
- (UIImage*)drn_boxblurImageWithBlur:(CGFloat)blur withTintColor:(UIColor*)tintColor;

@end
