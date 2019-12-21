//
//  WECommon.h
//  WERouter
//
//  Created by 周俊 on 2019/9/20.
//  Copyright © 2019 Webi. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const NO_ROUTER_PATH;
extern NSString * const NO_ROUTER_OBJ;
extern NSString * const NO_ROUTER_NOT_VC;

extern NSString * const ROUTER_ON_FOUND;
extern NSString * const ROUTER_ON_ARRIVAL;
extern NSString * const ROUTER_ON_LOST;
extern NSString * const ROUTER_ON_INTERRUPT;

extern BOOL IS_DEBUG;

FOUNDATION_EXPORT NSErrorDomain const JRouterErrorDomain;

typedef NS_ENUM(NSInteger,JRouterErrorCode){
    JRouterErrorCodeUnKnow = -1000,
    JRouterErrorCodeNoPath = -1001,
    JRouterErrorCodeNoInstance = -1002,
    JRouterErrorCodeNotVC = -1003,
};

NS_ASSUME_NONNULL_BEGIN

@interface JRouterCommon : NSObject

@end

NS_ASSUME_NONNULL_END
