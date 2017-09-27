//
//  MXRuntimeUtil.m
//  MXBaseUtils
//
//  Created by maRk on 2017/9/26.
//

#import "MXRuntimeUtil.h"
#import <objc/runtime.h>

#define GetInvocationArgCase(_MXTupleVariableType_, _type_) \
case _MXTupleVariableType_:  \
{   \
_type_ notIdValue; \
[anInvocation getArgument:&notIdValue atIndex:i + 2];   \
[tuple addObject:_MXBoxValue(@encode(_type_), notIdValue)];   \
break;  \
}

@implementation MXRuntimeUtil

+ (MXTuple *)getInvocationArguments:(NSInvocation *)anInvocation {
    NSMethodSignature *signature = [anInvocation methodSignature];
    NSInteger count = [signature numberOfArguments];
    MXTuple *tuple = [[MXTuple alloc] init];
    // 前两个参数为self、cmd
    for (int i = 0 ; i < count - 2; i++) {
        // 从invocation中取的参数，必须使用 __unsafe_unretained，否则会发生多次release。
        __unsafe_unretained id value;
        
        const char *argType = [signature getArgumentTypeAtIndex:i + 2];
        switch ([self varTypeWithEncoding:argType]) {
            case MXTupleVariableType_id:
                [anInvocation getArgument:&value atIndex:i + 2];
                [tuple addObject:value];
                break;
                GetInvocationArgCase(MXTupleVariableType_CGPoint, CGPoint)
                GetInvocationArgCase(MXTupleVariableType_CGRect, CGRect)
                GetInvocationArgCase(MXTupleVariableType_CGSize, CGSize)
                GetInvocationArgCase(MXTupleVariableType_UIEdgeInsets, UIEdgeInsets)
                
                GetInvocationArgCase(MXTupleVariableType_double, double)
                GetInvocationArgCase(MXTupleVariableType_float, float)
                
                GetInvocationArgCase(MXTupleVariableType_int, int)
                GetInvocationArgCase(MXTupleVariableType_unsigned_int, unsigned int)
                
                GetInvocationArgCase(MXTupleVariableType_long, long)
                GetInvocationArgCase(MXTupleVariableType_unsigned_long, unsigned long)
                
                GetInvocationArgCase(MXTupleVariableType_long_long, long long)
                GetInvocationArgCase(MXTupleVariableType_unsigned_long_long, unsigned long long)
                
                GetInvocationArgCase(MXTupleVariableType_short, short)
                GetInvocationArgCase(MXTupleVariableType_unsigned_short, unsigned short)
                
                GetInvocationArgCase(MXTupleVariableType_char, char)
                GetInvocationArgCase(MXTupleVariableType_unsigned_char, unsigned char)
                
                GetInvocationArgCase(MXTupleVariableType_bool, bool)
            case MXTupleVariableType_unknown:
            default:
                [tuple addObject:nil];
                break;
        }
    }
    return tuple;
}

+ (id)sendMessage:(SEL)selector toTarget:(id)target signature:(NSMethodSignature *)signature tuple:(MXTuple *)tuple {
    NSInteger paramCount = tuple.count;
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    [invocation setTarget:target];
    [invocation setSelector:selector];
    
    for (int i = 0; i < paramCount; i++) {
        id value = [tuple objectAtIndex:i];
        
        const char *encoding = [signature getArgumentTypeAtIndex:i + 2];
        
        switch ([self varTypeWithEncoding:encoding]) {
            case MXTupleVariableType_id:
                [invocation setArgument:&value atIndex:i + 2];
                break;
                
            case MXTupleVariableType_CGPoint:{
                CGPoint p = [value CGPointValue];
                [invocation setArgument:&p atIndex:i + 2];
                break;
            }
                
            case MXTupleVariableType_CGSize: {
                CGSize s = [value CGSizeValue];
                [invocation setArgument:&s atIndex:i + 2];
                break;
            }
                
            case MXTupleVariableType_CGRect: {
                CGRect s = [value CGRectValue];
                [invocation setArgument:&s atIndex:i + 2];
                break;
            }
                
            case MXTupleVariableType_UIEdgeInsets: {
                UIEdgeInsets u = [value UIEdgeInsetsValue];
                [invocation setArgument:&u atIndex:i + 2];
                break;
            }
                
            case MXTupleVariableType_double:
            {
                double d = [value doubleValue];
                [invocation setArgument:&d atIndex:i + 2];
            }
                break;
                
            case MXTupleVariableType_float:
            {
                float f = [value floatValue];
                [invocation setArgument:&f atIndex:i + 2];
            }
                break;
                
            case MXTupleVariableType_int:
            {
                int j = [value intValue];
                [invocation setArgument:&j atIndex:i + 2];
            }
                break;
                
            case MXTupleVariableType_long:
            {
                long l = [value longValue];
                [invocation setArgument:&l atIndex:i + 2];
            }
                break;
                
            case MXTupleVariableType_long_long:
            {
                long long l = [value longLongValue];
                [invocation setArgument:&l atIndex:i + 2];
            }
                break;
                
            case MXTupleVariableType_short:
            {
                short l = [value shortValue];
                [invocation setArgument:&l atIndex:i + 2];
            }
                break;
                
            case MXTupleVariableType_char:
            {
                char l = [value charValue];
                [invocation setArgument:&l atIndex:i + 2];
            }
                break;
                
            case MXTupleVariableType_bool:
            {
                bool l = [value boolValue];
                [invocation setArgument:&l atIndex:i + 2];
            }
                break;
                
            case MXTupleVariableType_unsigned_char:
            {
                unsigned char l = [value unsignedCharValue];
                [invocation setArgument:&l atIndex:i + 2];
            }
                break;
                
            case MXTupleVariableType_unsigned_int:
            {
                unsigned int l = [value unsignedIntValue];
                [invocation setArgument:&l atIndex:i + 2];
            }
                break;
                
            case MXTupleVariableType_unsigned_long:
            {
                unsigned long l = [value unsignedLongValue];
                [invocation setArgument:&l atIndex:i + 2];
            }
                break;
                
            case MXTupleVariableType_unsigned_long_long:
            {
                unsigned long long l = [value unsignedLongLongValue];
                [invocation setArgument:&l atIndex:i + 2];
            }
                break;
                
            case MXTupleVariableType_unsigned_short:
            {
                unsigned short l = [value unsignedShortValue];
                [invocation setArgument:&l atIndex:i + 2];
            }
                break;
            case MXTupleVariableType_unknown:
            default:
                [invocation setArgument:&value atIndex:i + 2];
        }
    }
    
    [invocation invoke];
    // 获取返回值
    void *returnPointer = NULL;
    if (strcmp([signature methodReturnType], "v") != 0) {
        if (strcmp([signature methodReturnType], "@") == 0) {
            [invocation getReturnValue:&returnPointer];
            return (__bridge id)(returnPointer);
        } else {
            
            returnPointer = (void*)malloc([signature methodReturnLength]);
            [invocation getReturnValue:returnPointer];
            
            const char *encoding = [signature methodReturnType];
            
            id value;
            switch ([self varTypeWithEncoding:encoding]) {
                case MXTupleVariableType_CGPoint:
                    value = _MXBoxValue(encoding, *((CGPoint *)returnPointer));
                    break;
                    
                case MXTupleVariableType_CGSize:
                    value = _MXBoxValue(encoding, *((CGSize *)returnPointer));
                    break;
                    
                case MXTupleVariableType_CGRect:
                    value = _MXBoxValue(encoding, *((CGRect *)returnPointer));
                    break;
                    
                case MXTupleVariableType_UIEdgeInsets:
                    value = _MXBoxValue(encoding, *((UIEdgeInsets *)returnPointer));
                    break;
                    
                case MXTupleVariableType_double:
                    value = _MXBoxValue(encoding, *((double *)returnPointer));
                    break;
                    
                case MXTupleVariableType_float:
                    value = _MXBoxValue(encoding, *((float *)returnPointer));
                    break;
                    
                case MXTupleVariableType_int:
                    value = _MXBoxValue(encoding, *((int *)returnPointer));
                    break;
                    
                case MXTupleVariableType_long:
                    value = _MXBoxValue(encoding, *((long *)returnPointer));
                    break;
                    
                case MXTupleVariableType_long_long:
                    value = _MXBoxValue(encoding, *((long long *)returnPointer));
                    break;
                    
                case MXTupleVariableType_short:
                    value = _MXBoxValue(encoding, *((short *)returnPointer));
                    break;
                    
                case MXTupleVariableType_char:
                    value = _MXBoxValue(encoding, *((char *)returnPointer));
                    break;
                    
                case MXTupleVariableType_bool:
                    value = _MXBoxValue(encoding, *((bool *)returnPointer));
                    break;
                    
                case MXTupleVariableType_unsigned_char:
                    value = _MXBoxValue(encoding, *((unsigned char *)returnPointer));
                    break;
                    
                case MXTupleVariableType_unsigned_int:
                    value = _MXBoxValue(encoding, *((unsigned int *)returnPointer));
                    break;
                    
                case MXTupleVariableType_unsigned_long:
                    value = _MXBoxValue(encoding, *((unsigned long *)returnPointer));
                    break;
                    
                case MXTupleVariableType_unsigned_long_long:
                    value = _MXBoxValue(encoding, *((unsigned long long *)returnPointer));
                    break;
                    
                case MXTupleVariableType_unsigned_short:
                    value = _MXBoxValue(encoding, *((unsigned short *)returnPointer));
                    break;
                default:
                    value = nil;
            }
            free(returnPointer);
            return value;
        }
    }
    return nil;
}

+ (char *)getTypesForSelector:(SEL)selector fromProtocol:(Protocol *)aProtocol {
    
    struct objc_method_description desc = protocol_getMethodDescription(aProtocol, selector, YES, YES);
    if (desc.types == NULL) {
        desc = protocol_getMethodDescription(aProtocol, selector, YES, NO);
    }
    if (desc.types == NULL) {
        desc = protocol_getMethodDescription(aProtocol, selector, NO, YES);
    }
    if (desc.types == NULL) {
        desc = protocol_getMethodDescription(aProtocol, selector, NO, NO);
    }
    if (desc.types == NULL) {
        NSLog(@"protocol: [%@] doesn't contain selector [%@]", NSStringFromProtocol(aProtocol), NSStringFromSelector(selector));
        assert(NO);
    }
    return desc.types;
}

#define xxxxxx(_returnType_, _type_) \
if (strcmp(encoding, @encode(_type_)) == 0) {   \
return _returnType_; \
}

/**
 根据签名获取参数类型
 
 @param encoding encoding
 @return return value description
 */
+ (MXTupleVariableType)varTypeWithEncoding:(const char *)encoding {
    xxxxxx(MXTupleVariableType_id, id)
    else
    xxxxxx(MXTupleVariableType_CGPoint, CGPoint)
    else
    xxxxxx(MXTupleVariableType_CGSize, CGSize)
    else
    xxxxxx(MXTupleVariableType_CGRect, CGRect)
    else
    xxxxxx(MXTupleVariableType_UIEdgeInsets, UIEdgeInsets)
    else
    xxxxxx(MXTupleVariableType_double, double)
    else
    xxxxxx(MXTupleVariableType_float, float)
    else
    xxxxxx(MXTupleVariableType_int, int)
    else
    xxxxxx(MXTupleVariableType_unsigned_int, unsigned int)
    else
    xxxxxx(MXTupleVariableType_long, long)
    else
    xxxxxx(MXTupleVariableType_unsigned_long, unsigned long)
    else
    xxxxxx(MXTupleVariableType_long_long, long long)
    else
    xxxxxx(MXTupleVariableType_unsigned_long_long, unsigned long long)
    else
    xxxxxx(MXTupleVariableType_short, short)
    else
    xxxxxx(MXTupleVariableType_unsigned_short, unsigned short)
    else
    xxxxxx(MXTupleVariableType_bool, bool)
    else
    xxxxxx(MXTupleVariableType_char, char)
    else
    xxxxxx(MXTupleVariableType_unsigned_char, unsigned char)
            
    return MXTupleVariableType_unknown;
}

id _MXBoxValue(const char *type, ...) {
    
    va_list v;
    va_start(v, type);
    id obj = nil;
    if (strcmp(type, @encode(id)) == 0) {
        id actual = va_arg(v, id);
        obj = actual;
    } else if (strcmp(type, @encode(CGPoint)) == 0) {
        CGPoint actual = (CGPoint)va_arg(v, CGPoint);
        obj = [NSValue value:&actual withObjCType:type];
    } else if (strcmp(type, @encode(CGSize)) == 0) {
        CGSize actual = (CGSize)va_arg(v, CGSize);
        obj = [NSValue value:&actual withObjCType:type];
    } else if (strcmp(type, @encode(CGRect)) == 0) {
        CGRect actual = (CGRect)va_arg(v, CGRect);
        obj = [NSValue value:&actual withObjCType:type];
    } else if (strcmp(type, @encode(UIEdgeInsets)) == 0) {
        UIEdgeInsets actual = (UIEdgeInsets)va_arg(v, UIEdgeInsets);
        obj = [NSValue value:&actual withObjCType:type];
    } else if (strcmp(type, @encode(double)) == 0) {
        double actual = (double)va_arg(v, double);
        obj = [NSNumber numberWithDouble:actual];
    } else if (strcmp(type, @encode(float)) == 0) {
        float actual = (float)va_arg(v, double);
        obj = [NSNumber numberWithFloat:actual];
    } else if (strcmp(type, @encode(int)) == 0) {
        int actual = (int)va_arg(v, int);
        obj = [NSNumber numberWithInt:actual];
    } else if (strcmp(type, @encode(long)) == 0) {
        long actual = (long)va_arg(v, long);
        obj = [NSNumber numberWithLong:actual];
    } else if (strcmp(type, @encode(long long)) == 0) {
        long long actual = (long long)va_arg(v, long long);
        obj = [NSNumber numberWithLongLong:actual];
    } else if (strcmp(type, @encode(short)) == 0) {
        short actual = (short)va_arg(v, int);
        obj = [NSNumber numberWithShort:actual];
    } else if (strcmp(type, @encode(char)) == 0) {
        char actual = (char)va_arg(v, int);
        obj = [NSNumber numberWithChar:actual];
    } else if (strcmp(type, @encode(bool)) == 0) {
        bool actual = (bool)va_arg(v, int);
        obj = [NSNumber numberWithBool:actual];
    } else if (strcmp(type, @encode(unsigned char)) == 0) {
        unsigned char actual = (unsigned char)va_arg(v, unsigned int);
        obj = [NSNumber numberWithUnsignedChar:actual];
    } else if (strcmp(type, @encode(unsigned int)) == 0) {
        unsigned int actual = (unsigned int)va_arg(v, unsigned int);
        obj = [NSNumber numberWithUnsignedInt:actual];
    } else if (strcmp(type, @encode(unsigned long)) == 0) {
        unsigned long actual = (unsigned long)va_arg(v, unsigned long);
        obj = [NSNumber numberWithUnsignedLong:actual];
    } else if (strcmp(type, @encode(unsigned long long)) == 0) {
        unsigned long long actual = (unsigned long long)va_arg(v, unsigned long long);
        obj = [NSNumber numberWithUnsignedLongLong:actual];
    } else if (strcmp(type, @encode(unsigned short)) == 0) {
        unsigned short actual = (unsigned short)va_arg(v, unsigned int);
        obj = [NSNumber numberWithUnsignedShort:actual];
    }
    va_end(v);
    return obj;
}
@end
