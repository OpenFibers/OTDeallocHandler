//
//  NSObject+OTDeallocHandler.m
//  OTDeallocHandlerDemo
//
//  Created by 史江浩 on 1/8/15.
//  Copyright (c) 2015 史江浩. All rights reserved.
//

#import "NSObject+OTDeallocHandler.h"
#import <objc/runtime.h>

#define OTDeallocHandlerDeallocingObjectKey @"OTDeallocHandlerDeallocingObjectKey"

@interface ComOpenthreadOTDeallocHandlerDeallocingObject : NSObject
@property (copy) void(^deallocHandler)(void);
@end

@implementation ComOpenthreadOTDeallocHandlerDeallocingObject

- (void)dealloc
{
    if (self.deallocHandler)
    {
        self.deallocHandler();
    }
}

@end

@implementation NSObject (OTDeallocHandler)

- (void(^)(void))deallocHandler
{
    ComOpenthreadOTDeallocHandlerDeallocingObject *object = nil;
    object = objc_getAssociatedObject(self, OTDeallocHandlerDeallocingObjectKey);
    if (object)
    {
        return object.deallocHandler;
    }
    return nil;
}

- (void)setDeallocHandler:(void (^)(void))deallocHandler
{
    ComOpenthreadOTDeallocHandlerDeallocingObject *object = nil;
    if (deallocHandler)
    {
        object = [[ComOpenthreadOTDeallocHandlerDeallocingObject alloc] init];
        object.deallocHandler = deallocHandler;
    }
    objc_setAssociatedObject(self,
                             OTDeallocHandlerDeallocingObjectKey,
                             object,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
