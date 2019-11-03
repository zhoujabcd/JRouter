//
//  JRouterInterceptorManager.h
//  JRouter
//
//  Created by justin on 2019/10/20.
//  Copyright © 2019 justin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JRouterBaseInterceptor.h"
#import "JRouterPostcard.h"

NS_ASSUME_NONNULL_BEGIN

@interface JRouterInterceptorManager : NSObject

+(instancetype)shareInstance;

@property (nonatomic,copy) NSMutableArray * interceptorList;

- (instancetype)init;
-(void)addToList:(JRouterBaseInterceptor *) interceptor;
-(void)doIntercept:(JRouterPostcard *)postcard  interceptCallBack:(void(^)(BOOL))interceptCallBack;

@end
NS_ASSUME_NONNULL_END
