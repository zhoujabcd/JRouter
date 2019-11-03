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
Register a routing object
```ruby
[[JRouterManager shareInstance] inject:ViewController.class  url:@"VC"];
```

Start route jump interface
```ruby
[[[JRouterManager shareInstance]build:@"VC" parentVC:self]navigation:^(NSString* status, JRouterPostcard* action, NSError* e){
        NSLog(@"navigation status: %@", status);
    }];
```

Log enable
```ruby
[JRouterManager openDebug];
```


## Author

zhoujabcd, labinnah1982@hotmail.com

## License

JRouter is available under the MIT license. See the LICENSE file for more info.
