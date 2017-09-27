//
//  MCService.m
//  MXModuleConnector
//
//  Created by maRk on 2017/9/27.
//

#import "MCService.h"

@interface MCService()

@property (nonatomic, strong) id<ExportableProtocol> singletonService;

@end

@implementation MCService

+ (instancetype)serviceWithClass:(Class<ExportableProtocol>)clazz {
    MCService *service = [[MCService alloc] init];
    service.serviceClass = clazz;
    return service;
}

- (id<ExportableProtocol>)getService {
    if ([_serviceClass isSingleton]) {
        return [self singletonService];
    }else {
        return [self generateService];
    }
}

- (id<ExportableProtocol>)singletonService {
    if (!_singletonService) {
        _singletonService = [self generateService];
    }
    return _singletonService;
}

- (id<ExportableProtocol>)generateService {
    return [_serviceClass ep_defaultInstance]?:[[((Class)_serviceClass) alloc] init];
}
@end
