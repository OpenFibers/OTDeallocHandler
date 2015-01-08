//
//  AppDelegate.m
//  OTDeallocHandlerDemo
//
//  Created by 史江浩 on 1/8/15.
//  Copyright (c) 2015 史江浩. All rights reserved.
//

#import "AppDelegate.h"
#import "NSObject+OTDeallocHandler.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //Usage for dealloc handler
    NSObject *foo = [[NSObject alloc] init];
    __weak NSObject *weakFoo = foo;
    foo.deallocHandler = ^{
        //The two line NSLog will get called after foo dealloced
        NSLog(@"foo was dealloced");
        NSLog(@"Now foo is %@", weakFoo);
    };
    
    //Typical usage : remove observer
//    foo.deallocHandler = ^{
//        [[NSNotificationCenter defaultCenter] removeObserver:weakFoo];
//    };
    
    //Typical usage : set delegate to nil after delegate dealloced.
//    __weak id weakSelf = self;
//    self.delegate.deallocHandler = ^{
//        weakSelf.delegate = nil;
//    };
    
    //Typical usage : remove assigned reference
//    foo.deallocHandler = ^{
//        [barArrayContainsWeakValues removeObject:weakFoo];
//    };
    return YES;
}

@end
