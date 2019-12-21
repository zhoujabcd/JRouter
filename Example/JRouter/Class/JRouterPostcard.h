//
//  WERouterAction.h
//  WERouter
//
//  Created by 周俊 on 2019/9/20.
//  Copyright © 2019 Webi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JRouterPostcard : NSObject

@property(nonatomic,copy)NSString* path;

@property(nonatomic,weak)UIViewController* parentVC;
@property(nonatomic,strong)id obj;
@property(nonatomic,copy)NSDictionary* values;
@property(nonatomic,assign)BOOL isAnimation;

-(instancetype)initWithPath:(NSString*) path parentVC:(UIViewController *) parentVC;

-(void)navigation:(void(^)(NSString*, JRouterPostcard*, NSError*) )navigationCallBack;

-(instancetype)withValues:(NSDictionary*)values;

-(instancetype)withAnimation:(BOOL)animation;

@end

NS_ASSUME_NONNULL_END
