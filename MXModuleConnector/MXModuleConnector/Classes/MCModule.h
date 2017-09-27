//
//  MCModule.h
//  MXModuleConnector
//
//  Created by maRk on 2017/9/27.
//

#import <Foundation/Foundation.h>
#import "MCModuleConnectorProtocol.h"

typedef NS_ENUM(NSInteger, MCModulePriority) {
    /**
     执行顺序最后
     */
    MCModulePriority_Low = 1000,
    /**
     执行顺序中等
     */
    MCModulePriority_Normal = 2000,
    /**
     执行顺序最优先
     */
    MCModulePriority_High = 3000,
};

@interface MCModule : NSObject

@property (nonatomic, strong) Class <ModuleConnectorProtocol> moduleClass;
@property (nonatomic, assign) MCModulePriority priority;
@property (nonatomic, strong) id<ModuleConnectorProtocol> moduleObject;

+ (instancetype)moduleWithClass:(Class<ModuleConnectorProtocol>) priority:(MCModulePriority)priority;

@end
