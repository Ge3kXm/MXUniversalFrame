//
//  UIImage+Extension.m
//  MXBaseUtils
//
//  Created by maRk on 2017/9/25.
//

#import "UIImage+Extension.h"

#import <QuartzCore/QuartzCore.h>
#import <Accelerate/Accelerate.h>

#define iPhone6s_1 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)) : NO)

#define iPhone6SP_1 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)

#define iPhone4S_1 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5_1 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5preferredMaxWidth_1 195
#define iPhone6spreferredMaxWidth_1 235
#define iPhone6sPluspreferredMaxWidth_1 255

@implementation UIImage (Extension)

+ (instancetype)mx_imageWithColor:(UIColor *)color withSize:(CGSize)size {
    CGRect imageRect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(imageRect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, imageRect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (instancetype)mx_imageWithColor:(UIColor *)color {
    return [self mx_imageWithColor:color withSize:CGSizeMake(1, 1)];
}

- (instancetype)mx_circleImage {
    CGFloat scale = self.scale;
    CGFloat originWidth  = self.size.width * scale;
    CGFloat originHeight = self.size.height * scale;
    
    // 裁剪图片正中区域
    CGFloat cropW = MIN(originWidth, originHeight);
    CGFloat cropX = ((originWidth - originHeight) > 0) ? (originWidth - originHeight) * 0.5f : 0;
    CGFloat cropY = ((originHeight - originWidth) > 0) ? (originHeight - originWidth) * 0.5f : 0;
    CGRect cropRect = CGRectMake(cropX, cropY, cropW, cropW);
    CGImageRef cropRef = CGImageCreateWithImageInRect(self.CGImage, cropRect);
    
    UIImage *image = [UIImage imageWithCGImage:cropRef scale:scale orientation:self.imageOrientation];
    CGImageRelease(cropRef);
    
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAllowsAntialiasing(context, YES);
    CGContextSetShouldAntialias(context, YES);
    
    CGRect rect = (CGRect){CGPointZero, image.size};
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    [image drawInRect:rect];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (instancetype)mx_squareImage {
    CGFloat scale = self.scale;
    CGFloat originWidth  = self.size.width * scale;
    CGFloat originHeight = self.size.height * scale;
    CGFloat cropW = MIN(originWidth, originHeight);
    CGFloat cropX = ((originWidth - originHeight) > 0) ? (originWidth - originHeight) * 0.5f : 0;
    CGFloat cropY = ((originHeight - originWidth) > 0) ? (originHeight - originWidth) * 0.5f : 0;
    CGRect cropRect = CGRectMake(cropX, cropY, cropW, cropW);
    CGImageRef cropRef = CGImageCreateWithImageInRect(self.CGImage, cropRect);
    
    UIImage *squareImage = [UIImage imageWithCGImage:cropRef scale:scale orientation:self.imageOrientation];
    CGImageRelease(cropRef);
    return squareImage;
}

- (instancetype)mx_fixOrientation {
    if(self.imageOrientation == UIImageOrientationUp) return self;
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch(self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width,0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform,0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
        default:
            break;
    }
    switch(self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width,0);
            transform = CGAffineTransformScale(transform, -1,1);
            break;
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height,0);
            transform = CGAffineTransformScale(transform, -1,1);
            break;
        default:
            break;
    }
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage),0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch(self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

//- (CGSize)mx_fixSizeWithImageSize:(CGSize)size rate:(NSInteger)rate {
//    CGFloat photoWidth = size.width;
//
//    CGFloat aspectRatio = size.width / size.height;
//    CGFloat multiple = [UIScreen mainScreen].scale;
//    CGFloat pixelWidth = photoWidth * multiple / rate;
//
//    if (iPhone5_1 || iPhone4S_1) {
//        if (pixelWidth > iPhone5preferredMaxWidth_1) {
//            pixelWidth = iPhone5preferredMaxWidth_1;
//        }
//    } else if (iPhone6s_1) {
//        if (pixelWidth > iPhone6spreferredMaxWidth_1) {
//            pixelWidth = iPhone6spreferredMaxWidth_1;
//        }
//    } else if (iPhone6SP_1) {
//        if (pixelWidth > iPhone6sPluspreferredMaxWidth_1) {
//            pixelWidth = iPhone6sPluspreferredMaxWidth_1;
//        }
//    }
//    CGFloat pixelHeight = pixelWidth / aspectRatio;
//
//    return CGSizeMake(pixelWidth, pixelHeight);
//}

- (instancetype)imageWithTintColor:(UIColor*)tintColor {
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    
    UIImage* tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}


/**
 获取渐变颜色图片
 
 @param colors colors description
 @param type type description
 @param size size description
 @return return value description
 */
+ (instancetype)mx_gradientImageWithColors:(NSArray *)colors colorType:(ColorSpreadType)type size:(CGSize)size {
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(size, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start;
    CGPoint end;
    switch (type) {
        case ColorSpreadTypeTopToBottom:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, size.height);
            break;
        case ColorSpreadTypeLeftToRight:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(size.width, 0.0);
            break;
        case ColorSpreadTypeTopleftToRightBottom:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(size.width, size.height);
            break;
        case ColorSpreadTypeTopRightToLeftBottom:
            start = CGPointMake(size.width, 0.0);
            end = CGPointMake(0.0, size.height);
            break;
        default:
            break;
    }
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
    
}



- (instancetype)drn_boxblurImageWithBlur:(CGFloat)blur
{
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = self.CGImage;
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    
    //create vImage_Buffer with data from CGImageRef
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    //create vImage_Buffer for output
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    // Create a third buffer for intermediate processing
    /*void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
     vImage_Buffer outBuffer2;
     outBuffer2.data = pixelBuffer2;
     outBuffer2.width = CGImageGetWidth(img);
     outBuffer2.height = CGImageGetHeight(img);
     outBuffer2.rowBytes = CGImageGetBytesPerRow(img);*/
    
    //perform convolution
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend)
    ?: vImageBoxConvolve_ARGB8888(&outBuffer, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend)
    ?: vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             (CGBitmapInfo)kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    //free(pixelBuffer2);
    
    CFRelease(inBitmapData);
    
    CGImageRelease(imageRef);
    
    
    
    return returnImage;
}

- (instancetype)drn_boxblurImageWithBlur:(CGFloat)blur withTintColor:(UIColor *)tintColor
{
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = self.CGImage;
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    
    
    //create vImage_Buffer with data from CGImageRef
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    //create vImage_Buffer for output
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    // Create a third buffer for intermediate processing
    /*void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
     vImage_Buffer outBuffer2;
     outBuffer2.data = pixelBuffer2;
     outBuffer2.width = CGImageGetWidth(img);
     outBuffer2.height = CGImageGetHeight(img);
     outBuffer2.rowBytes = CGImageGetBytesPerRow(img);*/
    
    //perform convolution
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    //    ?: vImageBoxConvolve_ARGB8888(&outBuffer, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend)
    //    ?: vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             (CGBitmapInfo)kCGImageAlphaNoneSkipLast);
    
    CGRect imageRect = {CGPointZero, self.size};
    
    // Add in color tint.
    if (tintColor) {
        CGContextSaveGState(ctx);
        CGContextSetFillColorWithColor(ctx, tintColor.CGColor);
        CGContextFillRect(ctx, imageRect);
        CGContextRestoreGState(ctx);
    }
    
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    //free(pixelBuffer2);
    
    CFRelease(inBitmapData);
    
    CGImageRelease(imageRef);
    
    return returnImage;
}

@end
