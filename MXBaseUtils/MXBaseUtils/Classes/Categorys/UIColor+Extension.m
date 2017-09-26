//
//  UIColor+Extension.m
//  MXBaseUtils
//
//  Created by maRk on 2017/9/25.
//

#import "UIColor+Extension.h"

static inline NSUInteger __hexStrToInt(NSString *str) {
    uint32_t result = 0;
    sscanf([str UTF8String], "%X", &result);
    return result;
}


static BOOL __hexStrToRGBA(NSString *str,
                           CGFloat *r, CGFloat *g, CGFloat *b, CGFloat *a) {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    str = [str stringByTrimmingCharactersInSet:set];
    str = [str uppercaseString];
    if ([str hasPrefix:@"#"]) {
        str = [str substringFromIndex:1];
    } else if ([str hasPrefix:@"0X"]) {
        str = [str substringFromIndex:2];
    }
    
    NSUInteger length = [str length];
    //         RGB            RGBA          RRGGBB        RRGGBBAA
    if (length != 3 && length != 4 && length != 6 && length != 8) {
        return NO;
    }
    
    //RGB,RGBA,RRGGBB,RRGGBBAA
    if (length < 5) {
        *r = __hexStrToInt([str substringWithRange:NSMakeRange(0, 1)]) / 255.0f;
        *g = __hexStrToInt([str substringWithRange:NSMakeRange(1, 1)]) / 255.0f;
        *b = __hexStrToInt([str substringWithRange:NSMakeRange(2, 1)]) / 255.0f;
        if (length == 4)  *a = __hexStrToInt([str substringWithRange:NSMakeRange(3, 1)]) / 255.0f;
        else *a = 1;
    } else {
        *r = __hexStrToInt([str substringWithRange:NSMakeRange(0, 2)]) / 255.0f;
        *g = __hexStrToInt([str substringWithRange:NSMakeRange(2, 2)]) / 255.0f;
        *b = __hexStrToInt([str substringWithRange:NSMakeRange(4, 2)]) / 255.0f;
        if (length == 8) *a = __hexStrToInt([str substringWithRange:NSMakeRange(6, 2)]) / 255.0f;
        else *a = 1;
    }
    return YES;
}

CGContextRef createARGBBitmapContextFromImage(CGImageRef inImage) {
    CGContextRef context = NULL;
    
    CGColorSpaceRef colorSpace;
    
    void* bitmapData;
    
    unsigned long bitmapByteCount;
    
    unsigned long bitmapBytesPerRow;
    
    size_t pixelsWide = CGImageGetWidth(inImage);
    
    size_t pixelsHigh = CGImageGetHeight(inImage);
    
    bitmapBytesPerRow = (pixelsWide * 4);
    
    bitmapByteCount = (bitmapBytesPerRow * pixelsHigh);
    
    colorSpace = CGColorSpaceCreateDeviceRGB();
    
    if (colorSpace == NULL)
        
    {
        
        fprintf(stderr, "Error allocating color space\n");
        
        return NULL;
    }
    
    bitmapData = malloc(bitmapByteCount);
    
    if (bitmapData == NULL)
        
    {
        
        fprintf(stderr, "Memory not allocated!");
        
        CGColorSpaceRelease(colorSpace);
        
        return NULL;
    }
    
    context = CGBitmapContextCreate(bitmapData,
                                    
                                    pixelsWide,
                                    
                                    pixelsHigh,
                                    
                                    8,
                                    
                                    bitmapBytesPerRow,
                                    
                                    colorSpace,
                                    
                                    (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    
    if (context == NULL)
        
    {
        
        free(bitmapData);
        
        fprintf(stderr, "Context not created!");
    }
    
    CGColorSpaceRelease(colorSpace);
    
    return context;
}

@implementation UIColor (Extension)

+ (instancetype)mx_colorWithHexString:(NSString *)hexString {
    CGFloat r, g, b, a;
    if (__hexStrToRGBA(hexString, &r, &g, &b, &a)) {
        return [UIColor colorWithRed:r green:g blue:b alpha:a];
    }
    return nil;
}

+ (instancetype)mx_getPixelColorAtLocation:(CGPoint)point inImage:(UIImage *)image {
    UIColor* color = nil;
    CGImageRef inImage = image.CGImage;
    CGContextRef cgctx = createARGBBitmapContextFromImage(inImage);
    
    if (cgctx == NULL) {
        return nil; /* error */
    }
    size_t w = CGImageGetWidth(inImage);
    size_t h = CGImageGetHeight(inImage);
    CGRect rect = { { 0, 0 }, { w, h } };
    
    CGContextDrawImage(cgctx, rect, inImage);
    
    unsigned char* data = CGBitmapContextGetData(cgctx);
    
    if (data != NULL) {
        int offset = 4 * ((w * round(point.y)) + round(point.x));
        int alpha = data[offset];
        int red = data[offset + 1];
        int green = data[offset + 2];
        int blue = data[offset + 3];
        color = [UIColor colorWithRed:(red / 255.0f) green:(green / 255.0f) blue:
                 (blue / 255.0f)
                                alpha:(alpha / 255.0f)];
    }
    
    CGContextRelease(cgctx);
    
    if (data) {
        free(data);
    }
    
    return color;
}

@end
