//
//  LYCommonImageTitleStateView.h
//  LYCampusSocial
//
//  Created by J on 2016/11/24.
//  Copyright © 2016年 HHLY. All rights reserved.
//

#import "LYBaseStateView.h"

@interface LYCommonImageTitleStateView : LYBaseStateView <LYBaseStateViewProtocol>

+ (instancetype)viewWithOffsetY:(CGFloat)offsetY text:(NSString *)text image:(UIImage *)image imageSize:(CGSize)imageSize;

@property (nonatomic, copy) NSString *text;


@end
