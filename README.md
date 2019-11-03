# JRouter

[![CI Status](https://img.shields.io/travis/zhoujabcd/JRouter.svg?style=flat)](https://travis-ci.org/zhoujabcd/JRouter)
[![Version](https://img.shields.io/cocoapods/v/JRouter.svg?style=flat)](https://cocoapods.org/pods/JRouter)
[![License](https://img.shields.io/cocoapods/l/JRouter.svg?style=flat)](https://cocoapods.org/pods/JRouter)
[![Platform](https://img.shields.io/cocoapods/p/JRouter.svg?style=flat)](https://cocoapods.org/pods/JRouter)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

JRouter is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
source 'https://github.com/zhoujabcd/mySpecs'
pod 'JRouter'
```

## Use

### Register a routing object
```ruby
[[JRouterManager shareInstance] inject:ViewController.class  url:@"VC"];
```

### Start route jump interface：
```ruby
[[[JRouterManager shareInstance]build:@"VC" parentVC:self]navigation:^(NSString* status, JRouterPostcard* action, NSError* e){
        NSLog(@"navigation status: %@", status);
    }];

/*Status:
NSString * const ROUTER_ON_FOUND = @"router_on_found";
NSString * const ROUTER_ON_ARRIVAL = @"router_on_arrival";
NSString * const ROUTER_ON_LOST = @"router_on_lost";
NSString * const ROUTER_ON_INTERRUPT = @"router_on_interrupt";
*/
```

### Start route jump interface with params：
```ruby
NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:@"hello word",@"key", nil];
    
[[[[JRouterManager shareInstance]build:@"VC" parentVC:self]withValues:dic] navigation:^(NSString* status, JRouterPostcard* action, NSError* e){
        NSLog(@"navigation status: %@", status);
    }];
```


### Interceptor：
Create an interceptor class that inherits from the basic interceptor, overrides the interceptor's process method, 
```ruby
#import <Foundation/Foundation.h>
#import "JRouterBaseInterceptor.h"

NS_ASSUME_NONNULL_BEGIN

@interface ARouterInterceptor : JRouterBaseInterceptor


@end

NS_ASSUME_NONNULL_END

-(void)process:(JRouterPostcard *)postcard interceptCallBack:(void(^)(BOOL))interceptCallBack
{
//    NSLog(@"intercept status: %@ is processing postcard: %@",self, postcard);
    [super process:postcard interceptCallBack:interceptCallBack];
}
```

instantiates it when it is used，the priority parameter in the constructor is the interceptor priority
```ruby
[[ARouterInterceptor alloc]init:1];
```
#### Does the interceptor intercept this route：
```ruby
-(void)process:(JRouterPostcard *)postcard interceptCallBack:(void(^)(BOOL))interceptCallBack
{
//    NSLog(@"intercept status: %@ is processing postcard: %@",self, postcard);
    [super process:postcard interceptCallBack:interceptCallBack];
    
    interceptCallBack(NO);
}
```
interceptCallBack(NO);//No interception
interceptCallBack(YES);//Interception

### Log enable
```ruby
[JRouterManager openDebug];
```


## Author

zhoujabcd, labinnah1982@hotmail.com

## License

JRouter is available under the MIT license. See the LICENSE file for more info.
