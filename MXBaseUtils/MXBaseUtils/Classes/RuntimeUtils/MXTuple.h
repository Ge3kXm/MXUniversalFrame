//
//  MXTuple.h
//  MXBaseUtils
//
//  Created by maRk on 2017/9/25.
//

#import <Foundation/Foundation.h>

extern const id MXTuple_End_Flag;

#define MXTupleCreate(...) [MXTuple mx_tupleWithObjects:__VA_ARGS__, MXTuple_End_Flag];

typedef NS_ENUM(NSInteger, MXTupleVariableType) {
    
    MXTupleVariableType_unknown = -1,
    MXTupleVariableType_id,
    MXTupleVariableType_CGPoint,
    MXTupleVariableType_CGRect,
    MXTupleVariableType_CGSize,
    MXTupleVariableType_UIEdgeInsets,
    MXTupleVariableType_double,
    MXTupleVariableType_float,
    MXTupleVariableType_int,
    MXTupleVariableType_long,
    MXTupleVariableType_long_long,
    MXTupleVariableType_short,
    MXTupleVariableType_char,
    MXTupleVariableType_bool,
    MXTupleVariableType_unsigned_char,
    MXTupleVariableType_unsigned_int,
    MXTupleVariableType_unsigned_long,
    MXTupleVariableType_unsigned_long_long,
    MXTupleVariableType_unsigned_short,
};

@interface MXTuple : NSObject

/**
 构造方法，插入连续的参数，可以为空，结尾以  MXTupleEndFlag  结束
 
 @param obj 首个参数
 @return instance of MXTuple
 */
+ (instancetype)mx_tupleWithObjects:(id)obj,... ;

- (id)objectAtIndex:(NSInteger)index;

- (void)addObject:(id)obj;

- (NSInteger)count;

- (id)first;
- (id)second;
- (id)third;
- (id)fourth;
- (id)fifth;

@end
