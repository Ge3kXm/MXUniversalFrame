//
//  MXDisposeBag.m
//  MXBaseUtils
//
//  Created by maRk on 2017/9/26.
//

#import "MXDisposeBag.h"
#import <objc/runtime.h>

@interface DefaultDispose : NSObject<MXDisposalble>

@end

@implementation DefaultDispose {
    dispatch_block_t _disposeBlock;
}

+ (instancetype)disposerWithAction:(dispatch_block_t)action {
    DefaultDispose *disposer = [[DefaultDispose alloc] init];
    disposer -> _disposeBlock = action;
    return disposer;
}

- (void)mx_dispose {
    if (_disposeBlock) _disposeBlock();
}
@end

////////////////////////////////////////////////////////////////////////////

@interface MXDisposeBag ()
{
    NSMutableArray<id<MXDisposalble>> * _disoposeArray;
}
@end

@implementation MXDisposeBag

- (instancetype)init {
    if (self = [super init]) {
        _disoposeArray = [NSMutableArray array];
    }
    return self;
}

- (void)addDisposeAction:(dispatch_block_t)action {
    [_disoposeArray addObject:[DefaultDispose disposerWithAction:action]];
}

- (void)addDispose:(id<MXDisposalble>)dispose {
    [_disoposeArray addObject:dispose];
}
     
- (void)dealloc {
    [_disoposeArray enumerateObjectsUsingBlock:^(id<MXDisposalble>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj mx_dispose];
    }];
}
         
@end

////////////////////////////////////////////////////////////////////////////

@implementation NSObject (MXDisposeBag)

- (MXDisposeBag *)mx_bag {
    MXDisposeBag *bag = objc_getAssociatedObject(self, _cmd);
    if (!bag) {
        bag = [[MXDisposeBag alloc] init];
        objc_setAssociatedObject(self, @selector(mx_bag), bag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return bag;
}

- (void)actionWhenDealloc:(dispatch_block_t)action {
    [self.mx_bag addDisposeAction:action];
}

- (void)mx_addToBag:(MXDisposeBag *)bag {
    [bag addDispose:self];
}

- (void)mx_hangOnObj:(id)obj {
    [self mx_addToBag:[obj mx_bag]];
}


@end
