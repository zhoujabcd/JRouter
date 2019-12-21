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
{
    NSLock *_cardLock;
    NSLock *_lock;
}

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

- (void)dealloc
{
    _cardMap = nil;
    _map = nil;
    _queue = nil;
    _lock = nil;
    _cardLock = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _map = [[NSMutableDictionary alloc]init];
        
        _queue = dispatch_queue_create("com.justin.jrouter", DISPATCH_QUEUE_SERIAL);
        
        _cardLock = [[NSLock alloc]init];
        
        _lock = [[NSLock alloc]init];
    }
    return self;
}

- (JRouterPostcard *)build:(NSString *)path parentVC:(UIViewController *)parentVC
{
    JRouterPostcard* action = [[JRouterPostcard alloc]initWithPath:path parentVC:parentVC];
    
    return action;
}

- (JRouterPostcard *)build:(NSString *)path parentVC:(UIViewController *)parentVC cashed:(BOOL)cashed
{
    JRouterPostcard *postCard = [_cardMap objectForKey:path];
    
    if(postCard == nil)
    {
        postCard = [[JRouterPostcard alloc]initWithPath:path parentVC:parentVC];
        
        if(cashed)
        {
            [_cardLock lock];
            NSMutableDictionary *mDic = [[NSMutableDictionary alloc]initWithDictionary:_cardMap];
            [mDic setObject:postCard forKey:path];
            _cardMap = mDic;
            [_cardLock unlock];
        }
    }
    
    return postCard;
}

- (void)removePostCard:(NSString *)path
{
    [_cardLock lock];
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc]initWithDictionary:_cardMap];
    [mDic removeObjectForKey:path];
    _cardMap = mDic;
    [_cardLock unlock];
}

-(void)inject:(Class)viewClass url:(NSString *)url
{
    [_lock lock];
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc]initWithDictionary:_map];
    [mDic setObject:viewClass forKey:url];
    _map = mDic;
    [_lock unlock];
}

@end
