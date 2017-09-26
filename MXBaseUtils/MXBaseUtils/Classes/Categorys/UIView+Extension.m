//
//  UIView+Extension.m
//  MXBaseUtils
//
//  Created by maRk on 2017/9/25.
//

#import "UIView+Extension.h"
#import <objc/runtime.h>

@implementation UIView (Extension)

- (BOOL) containsSubView:(UIView *)subView
{
    for (UIView *view in [self subviews]) {
        if ([view isEqual:subView]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL) containsSubViewOfClassType:(Class)aClass
{
    for (UIView *view in [self subviews]) {
        if ([view isMemberOfClass:aClass]) {
            return YES;
        }
    }
    return NO;
}

+ (instancetype)viewFromXib
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}


- (CGFloat)cornerRadius
{
    return [objc_getAssociatedObject(self, @selector(cornerRadius)) floatValue];
}
- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}
- (CGFloat)borderWidth
{
    return [objc_getAssociatedObject(self, @selector(borderWidth)) floatValue];
}
- (void)setBorderWidth:(CGFloat)borderWidth
{
    self.layer.borderWidth = borderWidth;
    self.layer.masksToBounds = YES;
}
- (UIColor *)borderColor
{
    return objc_getAssociatedObject(self, @selector(borderColor));
}
- (void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}




- (CGPoint) origin
{
    return self.frame.origin;
}

- (void) setOrigin:(CGPoint)newOrigin
{
    self.frame = CGRectMake(newOrigin.x, newOrigin.y, self.frame.size.width, self.frame.size.height);
}

- (CGSize) size
{
    return self.frame.size;
}

- (void) setSize:(CGSize)newSize
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, newSize.width, newSize.height);
}

- (CGFloat) originX
{
    return self.frame.origin.x;
}

- (void) setOriginX:(CGFloat)originX
{
    self.frame = CGRectMake(originX, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)originY
{
    return self.frame.origin.y;
}

- (void)setOriginY:(CGFloat)originY
{
    self.frame = CGRectMake(self.frame.origin.x, originY, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)frameRight
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setFrameRight:(CGFloat)newRight
{
    self.frame = CGRectMake(newRight - self.frame.size.width, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)frameBottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setFrameBottom:(CGFloat)newBottom
{
    self.frame = CGRectMake(self.frame.origin.x, newBottom - self.frame.size.height, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)frameWidth
{
    return self.frame.size.width;
}

- (void)setFrameWidth:(CGFloat)newWidth
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, newWidth, self.frame.size.height);
}

- (CGFloat)frameHeight
{
    return self.frame.size.height;
}

- (void)setFrameHeight:(CGFloat)newHeight
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, newHeight);
}
//- (UIImage*)imageRepresentation
//{
//    int width = CGRectGetWidth([self bounds]);
//    int height = CGRectGetHeight([self bounds]);
//
//    NSInteger myDataLength = width * height * 4;
//
//    // allocate array and read pixels into it.
//    GLubyte* buffer = (GLubyte*)malloc(myDataLength);
//    glReadPixels(0, 0, width, height, GL_RGBA, GL_UNSIGNED_BYTE, buffer);
//
//    // gl renders "upside down" so swap top to bottom into new array.
//    // there's gotta be a better way, but this works.
//    GLubyte* buffer2 = (GLubyte*)malloc(myDataLength);
//    for (int y = 0; y < height; y++) {
//        for (int x = 0; x < width * 4; x++) {
//            buffer2[(height - 1 - y) * width * 4 + x] = buffer[y * 4 * width + x];
//        }
//    }
//
//    // make data provider with data.
//    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL, buffer2, myDataLength, NULL);
//
//    // prep the ingredients
//    int bitsPerComponent = 8;
//    int bitsPerPixel = 32;
//    int bytesPerRow = 4 * width;
//    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
//    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
//    CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
//
//    // make the cgimage
//    CGImageRef imageRef = CGImageCreate(width, height, bitsPerComponent, bitsPerPixel, bytesPerRow, colorSpaceRef, bitmapInfo, provider, NULL, NO, renderingIntent);
//
//    // then make the uiimage from that
//    UIImage* myImage = [UIImage imageWithCGImage:imageRef];
//    CGImageRelease(imageRef);
//    CGColorSpaceRelease(colorSpaceRef);
//    CGDataProviderRelease(provider);
//    return myImage;
//}

- (void)changeSearhBarCancelBtn:(UIView *)view color:(UIColor *)color {
    if(view){
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *getBtn =(UIButton *)view;
            
            int64_t delayInSeconds = .001;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [getBtn setEnabled:YES];
                [getBtn setUserInteractionEnabled:YES];
                [getBtn setTitleColor:color forState:UIControlStateReserved];
                [getBtn setTitleColor:color forState:UIControlStateDisabled];
            });
            return;
        }else{
            for (UIView *subview in view.subviews) {
                [subview changeSearhBarCancelBtn:subview color:color];
            }
        }
    }else{
        return;
    }
}


- (instancetype)ly_addToSuperview:(UIView *)superview {
    [superview addSubview:self];
    return self;
}

@end
