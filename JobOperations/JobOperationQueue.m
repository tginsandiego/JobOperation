//
//  JobOperationQueue.m
//  NSOperationTester
//
//  Created by Specialty3 on 9/17/15.
//  Copyright (c) 2015 Specialty3. All rights reserved.
//

#import "JobOperationQueue.h"
#import "JobOperation.h"


@implementation JobOperationQueue


-(void) dump;
{
    NSString *jobQName = @"JobOperationQueue";
    if ([self.name length] > 0) 
    {
        jobQName = self.name;
        //NSLog(@"JobOperationQueue %@ information dump:",self.name);
    }
    NSLog(@"JobOperationQueue '%@' information dump", jobQName);
    
    NSLog(@"  '%@' # operations:%d  maxConcurrentOps:%d",jobQName, self.operationCount, self.maxConcurrentOperationCount);
    
    for (JobOperation *aJobOp in self.operations) 
    {
        [aJobOp dump];
    }
    
}

// if this method returns NO, should set the queue to nil and alloc a new one
+(BOOL) checkQueue:(JobOperationQueue *)queue hasOpsOlderThan:(NSInteger)secondsThreshold cancelStaleOps:(BOOL)cancelOps
{
    if (queue == nil) 
    {
        return NO;
    }
    
    if ([queue operationCount] > 0) 
    {
        NSLog(@"previous share still processing!");
        
        // recently started or stale?  Check the enqueue date of the first op.
        JobOperation *oldOp = [[queue operations] objectAtIndex:0];
        
        NSTimeInterval sourceSeconds = [[NSDate date] timeIntervalSinceReferenceDate];
        NSTimeInterval destinationSeconds = [oldOp.enqueueDate timeIntervalSinceReferenceDate];    
        double diff =  fabs( destinationSeconds - sourceSeconds );        
        
        if (diff > secondsThreshold) 
        {
            // more than three minutes old!  Let's cancel them and tell caller to proceed
            [queue cancelAllOperations];
            return NO;
        }
        else
        {
            return YES;
        }
        
    }
    return NO;
}


-(id) init;
{
    if((self = [super init])) {
        _jobDictionary = [[ThreadSafeMutableDictionary alloc] initWithCapacity:12];
    }
    
    return self;
}

-(void)addOperation:(NSOperation *)operation;
{
    if (operation == nil) 
    {
        return;
    }
    
    if ([operation isKindOfClass:[JobOperation class]]) 
    {
        ((JobOperation *)operation).enqueueDate = [NSDate date];
        //((JobOperation *)operation).homeQueueT = self.underlyingQueue; // dispatch_get_current_queue();
        ((JobOperation *)operation).homeJobQueue = self;
    }
    
    [super addOperation:operation];    
}

-(void)addOperations:(NSArray<NSOperation *> *)ops waitUntilFinished:(BOOL)wait;
{
    for (NSOperation *operation  in ops) 
    {
        if ([operation isKindOfClass:[JobOperation class]]) 
        {
            ((JobOperation *)operation).enqueueDate = [NSDate date];
            //((JobOperation *)operation).homeQueueT = self.underlyingQueue; //dispatch_get_current_queue();
            ((JobOperation *)operation).homeJobQueue = self;
        }
    }
    
    [super addOperations:ops waitUntilFinished:wait];
}

@end  
