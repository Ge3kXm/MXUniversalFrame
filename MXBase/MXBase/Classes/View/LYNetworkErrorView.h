//
//  LYNetworkErrorView.h
//  LYCampusSocial
//
//  Created by J on 2016/11/24.
//  Copyright © 2016年 HHLY. All rights reserved.
//

#import "LYBaseStateView.h"

@class LYNetworkErrorView;

typedef void(^LYNetworkCallBack)(LYNetworkErrorView *view);

@interface LYNetworkErrorView : LYBaseStateView <LYBaseStateViewProtocol>

+ (instancetype)viewWithOffsetY:(CGFloat)offsetY refreshBlock:(LYNetworkCallBack)refreshBlock;

+ (instancetype)viewWithBlock:(LYNetworkCallBack)refreshBlock;

@end
