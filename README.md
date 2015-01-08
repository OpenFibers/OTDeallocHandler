# OTDeallocHandler

### Description

Add a block to handle anything after object's dealloc called.

### Usage

Usage is simple:
just copy ***NSObject+OTDeallocHandler.h*** and ***NSObject+OTDeallocHandler.m*** to your projects. Then set the ***deallocHandler*** property to any object:

    NSObject *foo = [[NSObject alloc] init];
    __weak NSObject *weakFoo = foo;
    foo.deallocHandler = ^{
    	//The two line NSLog will get called after foo dealloced
        NSLog(@"foo was dealloced");
        NSLog(@"Now foo is %@", weakFoo);
    };

Typically, you can remove observer after observer dealloced, set delegate to nil after delegate dealloced, or remove assigned reference in 'weak' containers after object dealloced:

    //Typical usage : remove observer
    foo.deallocHandler = ^{
        [[NSNotificationCenter defaultCenter] removeObserver:weakFoo];
    };
    
    //Typical usage : set delegate to nil after delegate dealloced.
    __weak id weakSelf = self;
    self.delegate.deallocHandler = ^{
        weakSelf.delegate = nil;
    };
    
    //Typical usage : remove assigned reference
    foo.deallocHandler = ^{
        [barArrayContainsWeakValues removeObject:weakFoo];
    };
    