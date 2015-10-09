//
//  BasicJobOperation.m
//  NSOperationTester
//
//  Created by Specialty3 on 9/22/15.
//  Copyright (c) 2015 Specialty3. All rights reserved.
//

#import "BasicJobOperation.h"

@implementation BasicJobOperation

//-(void) completeAndFinishOnHomeQueue;
//{
//    dispatch_async(self.homeQueueT, ^{
//        [self indicateCustomWorkFinished];
//        [self finish];
//    });
//}

-(void) completeAndFinishOnQueueT:(dispatch_queue_t)queue_t;
{
    dispatch_async(queue_t, ^{
        [self indicateCustomWorkFinished];
        [self finish];
    });
}

- (void)doCustomWorkHere
{
    // do stuff
    NSLog(@"BasicJobOperation:doCustomWorkHere method called - shouldn't it be overriden?");
    
    // when done, finish up
    [self indicateCustomWorkFinished];
    [self finish];
}

-(void) indicateCustomWorkFinished
{
    self.customWorkFinished = YES;
}


-(BOOL) isConcurrent
{
    return NO;
}

- (void)main {
    
    // a lengthy operation
    @autoreleasepool
    {
        NSOperationQueue *myQ = [NSOperationQueue currentQueue];
        NSOperationQueue *mainQ = [NSOperationQueue mainQueue];

        if (self.isCancelled)
        {
            // finish!
            [self indicateCustomWorkFinished];
            [self finish];
            return;
        }
        
        
        // do real work here.
        //self.homeQueueT = dispatch_get_current_queue();
        [self doCustomWorkHere];
    }
}


///////////////////////


- (id)init
{
    if((self = [super init])) {
        _isExecutingB = NO;
        _isFinishedB = NO;
        _customWorkFinished = NO;
    }
    
    return self;
}


- (void)start
{
    NSOperationQueue *myQ = [NSOperationQueue currentQueue];
    NSOperationQueue *mainQ = [NSOperationQueue mainQueue];
    
    //[super start]; // needed?  buggy?
    
//    if (![NSThread isMainThread])
//    {
//        NSLog(@"UI Operation attempted from NON MAIN THREAD!");
//        [self performSelectorOnMainThread:@selector(start) withObject:nil waitUntilDone:NO];
//        return;
//    }
    
    if ([self isCancelled]) {
        [self willChangeValueForKey:@"isFinished"];
        _isFinishedB = YES;
        [self didChangeValueForKey:@"isFinished"];
        return;
    }
    
    [self willChangeValueForKey:@"isExecuting"];
    _isExecutingB = YES;
    [self didChangeValueForKey:@"isExecuting"];
    
    [self main];
}

- (void)finish
{
    
    // an example of how this can be modified
    if (!self.customWorkFinished)
    {
        return;  // must finish custom work first!
    }
    
    [self willChangeValueForKey:@"isExecuting"];
    [self willChangeValueForKey:@"isFinished"];
    
    _isExecutingB = NO;
    _isFinishedB = YES;
    
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

- (BOOL)isExecuting {
    return _isExecutingB;
}

- (BOOL)isFinished {
    return _isFinishedB;
}




@end
