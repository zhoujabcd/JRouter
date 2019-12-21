//
//  JRouterInterceptorManager.m
//  JRouter
//
//  Created by justin on 2019/10/20.
//  Copyright © 2019 justin. All rights reserved.
//

#import "JRouterInterceptorManager.h"
#import "JRouterCommon.h"

@implementation JRouterInterceptorManager
{
    NSLock *_lock;
}

- (void)dealloc
{
    _interceptorList = nil;
    
    _lock = nil;
}

+(instancetype)shareInstance{
    static JRouterInterceptorManager *p = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (p == nil) {
            p = [[JRouterInterceptorManager alloc]init];
        }
    });
    return p;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _interceptorList = [[NSArray alloc]init];
        
        _lock = [[NSLock alloc]init];
    }
    return self;
}

-(void)addToList:(JRouterBaseInterceptor *)interceptor
{
    NSInteger insertIndex = 0;
    
    for(int i=0; i<_interceptorList.count; i++){
        
        JRouterBaseInterceptor *mInterceptor = [_interceptorList objectAtIndex:i];
        
        if(mInterceptor.priority >= interceptor.priority)
        {
            insertIndex = i;
            
            break;
        }
        else
        {
            insertIndex = i+1;
        }
    }
    
    [_lock lock];
    NSMutableArray *mArr = [[NSMutableArray alloc]initWithArray:_interceptorList];
    [mArr insertObject:interceptor atIndex:insertIndex];
    _interceptorList = mArr;
    [_lock unlock];
    
    if(IS_DEBUG)
    {
        NSLog(@"!JRouter->Interceptor: add a interceptor in: %@", _interceptorList);
    }
}

-(void)doIntercept:(JRouterPostcard *)postcard  interceptCallBack:(void(^)(BOOL))interceptCallBack
{
//    if(IS_DEBUG)
//    {
//        NSLog(@"!JRouter: start intercept in path: %@", postcard.path);
//    }
    
    __block BOOL ifRout = YES;
    
    for(int i=0; i<_interceptorList.count; i++){
        
        JRouterBaseInterceptor *mInterceptor = [_interceptorList objectAtIndex:i];
        
        [mInterceptor process:postcard interceptCallBack:^(BOOL ifIntercept)
         {
            ifRout = !ifIntercept;
        }];
    }
    
    interceptCallBack(ifRout);
    
    if(IS_DEBUG)
    {
        NSLog(@"!JRouter->Interceptor: complete intercept if router %@ at path: %@ on thread: %@", ifRout?@"YES":@"NO", postcard.path, [NSThread currentThread]);
    }
}

@end
