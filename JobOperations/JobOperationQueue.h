//
//  JobOperationQueue.h
//  NSOperationTester
//
//  Created by Specialty3 on 9/17/15.
//  Copyright (c) 2015 Specialty3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ThreadSafeMutableDictionary.h"

// A subclass of NSOperationQueue
// Adds a thread-safe dictionary that queue operations can read/write
// in order to share operation results with other operations.

@interface JobOperationQueue : NSOperationQueue

// If data needs to be passed to or between job operations
@property (strong, atomic) ThreadSafeMutableDictionary *jobDictionary;


-(void)addOperation:(NSOperation *)operation;
-(void)addOperations:(NSArray<NSOperation *> *)ops waitUntilFinished:(BOOL)wait;

+(BOOL) checkQueue:(JobOperationQueue *)queue hasOpsOlderThan:(NSInteger)secondsThreshold cancelStaleOps:(BOOL)cancelOps;


-(void) dump;


@end
