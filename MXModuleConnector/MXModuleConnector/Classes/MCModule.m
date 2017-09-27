//
//  MCModule.m
//  MXModuleConnector
//
//  Created by maRk on 2017/9/27.
//

#import "MCModule.h"

@implementation MCModule

+ (instancetype)moduleWithClass:(Class<ModuleConnectorProtocol>)aClass priority:(MCModulePriority)priority {
    MCModule *module = [[MCModule alloc] init];
    module.moduleClass = aClass;
    module.priority = priority;
    return module;
}

- (id<ModuleConnectorProtocol>)moduleObject {
    if (!_moduleObject) {
        return [[(Class)_moduleClass alloc] init];
    }
    return _moduleObject;
}

@end
