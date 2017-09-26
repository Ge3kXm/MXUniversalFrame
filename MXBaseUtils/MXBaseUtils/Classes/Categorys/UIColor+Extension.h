//
//  UIColor+Extension.h
//  MXBaseUtils
//
//  Created by maRk on 2017/9/25.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)

///////////////////////////////////////十六进制色///////////////////////////////////////
+ (instancetype)mx_colorWithHexString:(NSString *)hexString;


///////////////////////////////////////取图片色///////////////////////////////////////
+ (instancetype)mx_getPixelColorAtLocation:(CGPoint)point inImage:(UIImage *)image;
@end
