//
//  MCService.h
//  MXModuleConnector
//
//  Created by maRk on 2017/9/27.
//

#import <Foundation/Foundation.h>
#import "MCModuleConnectorProtocol.h"

@interface MCService : NSObject

@property (nonatomic, strong) Class<ExportableProtocol> serviceClass;

- (id<ExportableProtocol>)getService;
+ (instancetype)serviceWithClass:(Class<ExportableProtocol>)clazz;

@end
