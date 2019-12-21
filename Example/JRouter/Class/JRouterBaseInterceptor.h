//
//  JRouterBaseInterceptor.h
//  JRouter
//
//  Created by justin on 2019/10/20.
//  Copyright © 2019 justin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JRouterPostcard.h"

NS_ASSUME_NONNULL_BEGIN

@interface JRouterBaseInterceptor : NSObject

@property(nonatomic,assign)NSInteger priority;

-(instancetype)init:(NSInteger)priority NS_DESIGNATED_INITIALIZER;

-(instancetype)init NS_UNAVAILABLE;

-(void)process:(JRouterPostcard *)postcard interceptCallBack:(void(^)(BOOL))interceptCallBack;

@end

NS_ASSUME_NONNULL_END
