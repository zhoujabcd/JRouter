//
//  WERouterManager.h
//  WERouter
//
//  Created by 周俊 on 2019/9/18.
//  Copyright © 2019 Webi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JRouterPostcard.h"

NS_ASSUME_NONNULL_BEGIN

@interface JRouterManager : NSObject
{
}

@property (nonatomic, copy)NSMutableDictionary* map;

@property (nonatomic, strong)dispatch_queue_t queue;

+(instancetype)shareInstance;
+(void)openDebug;


-(void)inject:(Class)viewClass url:(NSString *)url;

-(JRouterPostcard *)build:(NSString*)path parentVC:(UIViewController *)parentVC;

@end

NS_ASSUME_NONNULL_END
