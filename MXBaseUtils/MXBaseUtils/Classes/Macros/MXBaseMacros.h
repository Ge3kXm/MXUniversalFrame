//
//  MXBaseMacros.h
//  MXBaseUtils
//
//  Created by maRk on 2017/9/25.
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

///////////////////////////////////////随机颜色///////////////////////////////////////
#define MXColorRGB(r,g,b,a) [UIColor colorWithRed:(float)r/255.0 green:(float)g/255.0 blue:(float)b/255.0 alpha:a]
#define MXRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:arc4random_uniform(255)/255.0]

///////////////////////////////////////系统版本///////////////////////////////////////
#define MX_OSV_LaterIOS7 MX_OSVLater(7.0)
#define MX_OSV_LaterIOS8 MX_OSVLater(8.0)
#define MX_OSV_LaterIOS9 MX_OSVLater(9.0)
#define MX_OSVLater(version) ([[UIDevice currentDevice].systemVersion doubleValue] >= version)

///////////////////////////////////////String相关///////////////////////////////////////
#define NotNil(_str_) (_str_?:@"")
#define NumberToStr(number)  [NSString stringWithFormat:@"%ld",number]
#define StringAsKey(_key_) static NSString *_key_ = @#_key_;
#define _String(...) ([NSString stringWithFormat:__VA_ARGS__])

///////////////////////////////////////Block相关///////////////////////////////////////
#define EXE_BLOCK(block,...) if (block) {block(__VA_ARGS__);}

///////////////////////////////////////Path相关///////////////////////////////////////
#define App_Document_Path ([NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject])
#define App_Library_Path  ([NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject])
#define App_Cache_Path    ([NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject])
#define App_Temp_Path     (NSTemporaryDirectory())

///////////////////////////////////////分类宏定义///////////////////////////////////////
#define MakeClassCategoryImp(_class_, _protocol_) \
        @interface _class_ (_protocol_) <_protocol_>\
        @end

#endif /* MXBaseMacros_h */
