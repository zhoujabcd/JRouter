//
//  WECommon.m
//  WERouter
//
//  Created by 周俊 on 2019/9/20.
//  Copyright © 2019 Webi. All rights reserved.
//

#import "JRouterCommon.h"

NSString * const NO_ROUTER_PATH = @"没有注册的路由";
NSString * const NO_ROUTER_OBJ = @"没有注册的路由对象";
NSString * const NO_ROUTER_NOT_VC = @"注册的路由对象不是ViewControllor";

NSString * const ROUTER_ON_FOUND = @"router_on_found";
NSString * const ROUTER_ON_ARRIVAL = @"router_on_arrival";
NSString * const ROUTER_ON_LOST = @"router_on_lost";
NSString * const ROUTER_ON_INTERRUPT = @"router_on_interrupt";

NSErrorDomain const JRouterErrorDomain = @"WERouterErrorDomain";

BOOL IS_DEBUG = NO;

@implementation JRouterCommon

@end
