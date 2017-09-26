//
//  MXTuple.m
//  MXBaseUtils
//
//  Created by maRk on 2017/9/25.
//

#import "MXTuple.h"


const id MXTuple_End_Flag = @__FILE__;
////////////////////////////////////////////////////////////////////////////
@interface MXTuple()

@property (nonatomic, strong) NSMutableArray *params;

@end

@implementation MXTuple

+ (instancetype)mx_tupleWithObjects:(id)obj, ... {
    MXTuple *tuple = [MXTuple new];
    NSMutableArray *args = [NSMutableArray array];
    if (obj != MXTuple_End_Flag) {
        [args addObject:obj ? obj : MXTuple_End_Flag];
        va_list valist;
        va_start(valist, obj);
        id arg;
        while ((arg = va_arg(valist, id)) != MXTuple_End_Flag) {
            [args addObject:arg ? arg : MXTuple_End_Flag];
        }
        va_end(valist);
    }
    [tuple.params addObjectsFromArray:args];
    return tuple;
}

- (NSMutableArray *)params {
    if (!_params) {
        _params = @[].mutableCopy;
    }
    return _params;
}

- (id)objectAtIndex:(NSInteger)index {
    return [self.params[index] isEqual:MXTuple_End_Flag] ? nil : self.params[index];
}

- (void)addObject:(id)obj {
    [self.params addObject:obj?:MXTuple_End_Flag];
}

- (NSInteger)count {
    return self.params.count;
}

- (NSString *)description {
    NSMutableString *string = [NSMutableString string];
    for (int i = 0; i < self.count; i++) {
        [string appendFormat:@"[%@],\n", [[self objectAtIndex:i] description]];
    }
    return string;
}

- (id)first {
    return [self objectAtIndex:0];
}

- (id)second {
    return [self objectAtIndex:1];
}

- (id)third {
    return [self objectAtIndex:2];
}

- (id)fourth {
    return [self objectAtIndex:3];
}

- (id)fifth {
    return [self objectAtIndex:4];
}

@end
