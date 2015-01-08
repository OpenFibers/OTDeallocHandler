//
//  NSObject+OTDeallocHandler.h
//  OTDeallocHandlerDemo
//
//  Created by 史江浩 on 1/8/15.
//  Copyright (c) 2015 史江浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (OTDeallocHandler)

@property (copy) void(^deallocHandler)(void);

@end
