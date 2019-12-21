//
//  JRouterBaseInterceptor.m
//  JRouter
//
//  Created by justin on 2019/10/20.
//  Copyright © 2019 justin. All rights reserved.
//

#import "JRouterBaseInterceptor.h"
#import "JRouterInterceptorManager.h"
#import "JRouterCommon.h"

@implementation JRouterBaseInterceptor

- (void)dealloc
{
}

- (instancetype)init:(NSInteger)priority
{
    self = [super init];
    if (self) {
        [[JRouterInterceptorManager shareInstance]addToList:self];
        
        _priority = priority;
    }
    return self;
}

-(void)process:(JRouterPostcard *)postcard interceptCallBack:(void(^)(BOOL))interceptCallBack
{
//     @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:[NSString stringWithFormat:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)] userInfo:nil];
    if(IS_DEBUG)
    {
        NSLog(@"!JRouter->Interceptor: start intercept at path: %@ on thread: %@ in class: %@", postcard.path, [NSThread currentThread], self.class);
    }
}

@end
