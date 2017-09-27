//
//  MXDisposeBag.h
//  MXBaseUtils
//
//  Created by maRk on 2017/9/26.
//

#import <Foundation/Foundation.h>
@class MXDisposeBag;

@protocol MXDisposalble
- (void)mx_dispose;

@optional
/**
 添加到处理包
 
 @param bag bag description
 */
- (void)mx_addToBag:(MXDisposeBag *)bag;


/**
 相当于， [self ly_addToBag:obj.ly_bag];
 
 @param obj obj description
 */
- (void)mx_hangOnObj:(id)obj;

@end

@interface MXDisposeBag : NSObject

- (void)addDisposeAction:(dispatch_block_t)action;

- (void)addDispose:(id<MXDisposalble>)dispose;

@end

////////////////////////////////////////////////////////////////////////////

@interface NSObject (MXDisposeBag)


/**
 每个对象都有一个MXDisposeBag对象

 @return MXDisposeBag
 */
- (MXDisposeBag *)mx_bag;

- (void)actionWhenDealloc:(dispatch_block_t)action;
@end
