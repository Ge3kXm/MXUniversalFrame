//
//  MXBaseMacros.h
//  MXBase
//
//  Created by maRk on 2017/9/22.
//  Copyright © 2017年 maRk. All rights reserved.
//

#ifndef MXBaseMacros_h
#define MXBaseMacros_h


///////////////////////////////////////单例宏///////////////////////////////////////

#define MXSingleton(_method_)\
            + (instancetype)_method_;

#define MXSingletonImpl(_method_)\
            + (instancetype)_method_ {\
            if(__shareInstance)return __shareInstance;\
            return [[self alloc] init];\
            }\
            static id __shareInstance;\
            + (instancetype)allocWithZone:(struct _NSZone *)zone {\
            static dispatch_once_t onceToken;\
            dispatch_once(&onceToken, ^{\
            __shareInstance = [super allocWithZone:zone];\
            });\
            return __shareInstance;\
            }\

///////////////////////////////////////动态添加属性///////////////////////////////////////
#define MX_DYNAMIC_PROPERTY_OBJECT(_getter_, _setter_, _association_, _type_) \
            - (void)_setter_ : (_type_)object { \
            [self willChangeValueForKey:@#_getter_]; \
            objc_setAssociatedObject(self, _cmd, object, _association_); \
            [self didChangeValueForKey:@#_getter_]; \
            } \
            - (_type_)_getter_ { \
            return objc_getAssociatedObject(self, @selector(_setter_:)); \
            }
#endif /* MXBaseMacros_h */
