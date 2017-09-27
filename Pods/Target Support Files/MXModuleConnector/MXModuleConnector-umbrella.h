#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "MCAppDelegate.h"
#import "MCContext.h"
#import "MCModule.h"
#import "MCModuleConnector.h"
#import "MCModuleConnectorProtocol.h"
#import "MCService.h"

FOUNDATION_EXPORT double MXModuleConnectorVersionNumber;
FOUNDATION_EXPORT const unsigned char MXModuleConnectorVersionString[];

