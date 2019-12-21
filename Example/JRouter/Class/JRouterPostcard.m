//
//  WERouterAction.m
//  WERouter
//
//  Created by 周俊 on 2019/9/20.
//  Copyright © 2019 Webi. All rights reserved.
//

#import "JRouterPostcard.h"
#import "JRouterManager.h"
#import "JRouterCommon.h"
#import "JRouterInterceptorManager.h"

@implementation JRouterPostcard

- (void)dealloc
{
    _path = nil;
    
    _parentVC = nil;
    
    _values = nil;
    
    _obj = nil;
    
    _isAnimation = NO;
}

-(instancetype)initWithPath:(NSString *)path parentVC:(UIViewController *)parentVC
{
    self = [super init];
    if (self) {
        _path = path;
        _parentVC = parentVC;
        _isAnimation = NO;
    }
    return self;
}

- (void)navigation:(void(^)(NSString* status, JRouterPostcard* postcard, NSError* error) )navigationCallBack
{
    __weak typeof(self) wS = self;
    
    dispatch_async([JRouterManager shareInstance].queue, ^{
        
        __strong typeof(self) sS = wS;
        
        if(sS != nil)
        {
            [[JRouterInterceptorManager shareInstance]doIntercept:sS interceptCallBack:^(BOOL ifContinue)
             {
                 if(ifContinue)
                 {
                     dispatch_async(dispatch_get_main_queue(), ^{
                         if(IS_DEBUG)
                         {
                             NSLog(@"!JRouter->Rout: navigation start in path: %@ on thread: %@", sS.path, [NSThread currentThread]);
                         }
                         
                         if(sS.obj == nil)
                         {
                             Class className = [[JRouterManager shareInstance].map objectForKey:sS.path];
                             
                             if(className == nil)
                             {
                                 NSError* error = [[NSError alloc]initWithDomain:JRouterErrorDomain code:JRouterErrorCodeNoPath userInfo:@{NSLocalizedDescriptionKey:NO_ROUTER_PATH}];
                                 
                                 navigationCallBack(ROUTER_ON_LOST, sS, error);
                                 
                                 return;
                             }
                             
                             id obj = [[className alloc]init];
                             
                             if(obj == nil)
                             {
                                 NSError* error = [[NSError alloc]initWithDomain:JRouterErrorDomain code:JRouterErrorCodeNoInstance userInfo:@{NSLocalizedDescriptionKey:NO_ROUTER_OBJ}];
                                 
                                 navigationCallBack(ROUTER_ON_LOST, sS, error);
                                 
                                 return;
                             }
                             
                             navigationCallBack(ROUTER_ON_FOUND, sS, nil);
                             
                             if(![obj isKindOfClass:[UIViewController class]])
                             {
                                 NSError* error = [[NSError alloc]initWithDomain:JRouterErrorDomain code:JRouterErrorCodeNotVC userInfo:@{NSLocalizedDescriptionKey:NO_ROUTER_NOT_VC}];
                                 
                                 navigationCallBack(ROUTER_ON_LOST, sS, error);
                                 
                                 return;
                             }
                             
                             sS.obj = obj;
                         }
                         
                         for(NSString *key in sS.values)
                         {
                             id value = [sS.values objectForKey:key];
                             
                             @try
                             {
                                 [sS.obj setValue:value forKey:key];
                             }
                             @catch (NSException *exception)
                             {
                                 if(IS_DEBUG)
                                 {
                                     NSLog(@"!JRouter->Rout: set wrong key:%@",key);
                                 }
                             }
                         }
                         
                         [sS.parentVC presentViewController:sS.obj animated:false completion:^{
                             
                             navigationCallBack(ROUTER_ON_ARRIVAL, sS, nil);
                             
                             if(IS_DEBUG)
                             {
                                 NSLog(@"!JRouter->Rout: navigation complete on thread: %@", [NSThread currentThread]);
                             }
                         }];
                     });
                 }
                 else
                 {
                     navigationCallBack(ROUTER_ON_INTERRUPT, sS, nil);
                 }
             }];
        }
    });
}

- (instancetype)withValues:(NSDictionary *)values
{
    _values = values;
    
    return self;
}

- (instancetype)withAnimation:(BOOL)animation
{
    _isAnimation = animation;
    
    return self;
}

@end
