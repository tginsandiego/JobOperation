//
//  JobOperation.h
//  NSOperationTester
//
//  Created by Specialty3 on 9/17/15.
//  Copyright (c) 2015 Specialty3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JobOperationQueue.h"
#import "ThreadSafeMutableDictionary.h"
#import "ThreadSafeMutableArray.h"

// Light weight subclass of NSOperation.
// Defines convenience operations.

@interface JobOperation : NSOperation

@property (strong, atomic) ThreadSafeMutableArray *dependents;
//@property (strong, atomic) ThreadSafeMutableArray *conditions;
//@property (strong, atomic) ThreadSafeMutableArray *observers;

@property (strong, atomic) NSDate *enqueueDate;

//@property (assign, atomic) dispatch_queue_t homeQueueT;
@property (weak, atomic) JobOperationQueue *homeJobQueue;

-(ThreadSafeMutableDictionary *)getJobDict;

-(void) dump;
-(NSString *) stateDump;

@end
