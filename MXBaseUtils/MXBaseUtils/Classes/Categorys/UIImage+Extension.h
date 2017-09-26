//
//  UIImage+Extension.h
//  MXBaseUtils
//
//  Created by maRk on 2017/9/25.
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

/**
 切圆形
 */
- (instancetype)mx_circleImage;


/**
 切正方形
 */
- (instancetype)mx_squareImage;

/**
 *  修正上传服务器后,图片的显示方向
 *
 */
- (instancetype)mx_fixOrientation;

/**
 *  按比例缩小图片
 */
- (instancetype)mx_fixSizeWithImageSize:(CGSize)size rate:(NSInteger)rate;

/**
 获取渐变颜色图片
 */
+ (instancetype)mx_gradientImageWithColors:(NSArray *)colors colorType:(ColorSpreadType)type size:(CGSize)size;

///////////////////////////////////////模糊处理///////////////////////////////////////
/* blur the current image with a box blur algoritm */
- (instancetype)drn_boxblurImageWithBlur:(CGFloat)blur;

/* blur the current image with a box blur algoritm and tint with a color */
- (instancetype)drn_boxblurImageWithBlur:(CGFloat)blur withTintColor:(UIColor*)tintColor;

@end
