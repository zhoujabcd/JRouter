//
//  WERouterManager.m
//  WERouter
//
//  Created by 周俊 on 2019/9/18.
//  Copyright © 2019 Webi. All rights reserved.
//

#import "JRouterManager.h"
#import "JRouterCommon.h"

@implementation JRouterManager

+(instancetype)shareInstance{
    static JRouterManager *p = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (p == nil) {
            p = [[JRouterManager alloc]init];
        }
    });
    return p;
}

+(void)openDebug
{
    IS_DEBUG = YES;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _map = [[NSMutableDictionary alloc]init];
        
        _queue = dispatch_queue_create("com.justin.arouter", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (JRouterPostcard *)build:(NSString *)path parentVC:(UIViewController *)parentVC
{
    JRouterPostcard* action = [[JRouterPostcard alloc]initWithPath:path parentVC:parentVC];
    
    return action;
}

-(void)inject:(Class)viewClass url:(NSString *)url
{
    [_map setObject:viewClass forKey:url];
}

//- (id)routerWithParams:(NSString *)name sel:(NSString *)method params:(NSArray*) params
//{
//    Class subclass = NSClassFromString(name);
//    
//    SEL anotherSel=NSSelectorFromString(method);
//    
//    id obj = [[subclass alloc]init];
//    
//    NSMethodSignature *signature = [subclass instanceMethodSignatureForSelector:anotherSel];
//    
//    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
//    
//    invocation.target = obj;
//    invocation.selector = anotherSel;
//    
//    for(NSInteger i = 0; i < params.count; i++)
//    {
//        id p = params[i];
//        [invocation setArgument:&p atIndex:i+2];
//    }
//    
//    [invocation invoke];
//    
//    return obj;
//}

@end
