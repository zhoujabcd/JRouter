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

-(instancetype)initWithPath:(NSString *)path parentVC:(UIViewController *)parentVC
{
    self = [super init];
    if (self) {
        _path = path;
        _parentVC = parentVC;
    }
    return self;
}

- (void)navigation:(void(^)(NSString* status, JRouterPostcard* postcard, NSError* error) )navigationCallBack
{
    __weak typeof(self) wS = self;
    
    dispatch_async([JRouterManager shareInstance].queue, ^{
        
        [[JRouterInterceptorManager shareInstance]doIntercept:self interceptCallBack:^(BOOL ifContinue)
         {
            if(ifContinue)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(IS_DEBUG)
                    {
                        NSLog(@"!JRouter->Rout: navigation start in path: %@ on thread: %@", wS.path, [NSThread currentThread]);
                    }
                    
                    Class className = [[JRouterManager shareInstance].map objectForKey:self.path];
                            
                            if(className == nil)
                            {
                                NSError* error = [[NSError alloc]initWithDomain:JRouterErrorDomain code:JRouterErrorCodeNoPath userInfo:@{NSLocalizedDescriptionKey:NO_ROUTER_PATH}];
                                
                                navigationCallBack(ROUTER_ON_LOST, self, error);
                                
                                return;
                            }
                            
                            id obj = [[className alloc]init];
                            
                            if(obj == nil)
                            {
                                NSError* error = [[NSError alloc]initWithDomain:JRouterErrorDomain code:JRouterErrorCodeNoInstance userInfo:@{NSLocalizedDescriptionKey:NO_ROUTER_OBJ}];
                                
                                navigationCallBack(ROUTER_ON_LOST, self, error);
                                
                                return;
                            }
                            
                            navigationCallBack(ROUTER_ON_FOUND, self, nil);
                            
                            if(![obj isKindOfClass:[UIViewController class]])
                            {
                                NSError* error = [[NSError alloc]initWithDomain:JRouterErrorDomain code:JRouterErrorCodeNotVC userInfo:@{NSLocalizedDescriptionKey:NO_ROUTER_NOT_VC}];
                                
                                navigationCallBack(ROUTER_ON_LOST, self, error);
                                
                                return;
                            }
                            
                            wS.obj = obj;
                            
                            for(NSString *key in wS.values)
                            {
                                id value = [wS.values objectForKey:key];
                                
                                @try
                                {
                                    [wS.obj setValue:value forKey:key];
                                }
                                @catch (NSException *exception)
                                {
                                    if(IS_DEBUG)
                                    {
                                        NSLog(@"!JRouter->Rout: set wrong key:%@",key);
                                    }
                                }
                            }
                            
                            [wS.parentVC presentViewController:obj animated:false completion:^{
                                
                                navigationCallBack(ROUTER_ON_ARRIVAL, self, nil);
                                
                                if(IS_DEBUG)
                                {
                                    NSLog(@"!JRouter->Rout: navigation complete on thread: %@", [NSThread currentThread]);
                                }
                            }];
                        });
            }
            else
            {
                navigationCallBack(ROUTER_ON_INTERRUPT, self, nil);
            }
        }];
    });
}

- (instancetype)withValues:(NSDictionary *)values
{
    _values = values;
    
    return self;
}

@end
