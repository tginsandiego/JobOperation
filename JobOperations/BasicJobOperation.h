//
//  BasicJobOperation.h
//  NSOperationTester
//
//  Created by Specialty3 on 9/22/15.
//  Copyright (c) 2015 Specialty3. All rights reserved.
//

#import "JobOperation.h"

@interface BasicJobOperation : JobOperation

@property (assign, atomic) BOOL customWorkFinished;
@property (assign, atomic) BOOL isExecutingB;
@property (assign, atomic) BOOL isFinishedB;

-(void) indicateCustomWorkFinished;
//-(void) completeAndFinishOnHomeQueue;
-(void) completeAndFinishOnQueueT:(dispatch_queue_t)queue_t;
-(void) finish;

@end
