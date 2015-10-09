//
//  JobOperation.m
//  NSOperationTester
//
//  Created by Specialty3 on 9/17/15.
//  Copyright (c) 2015 Specialty3. All rights reserved.
//

#import "JobOperation.h"

@implementation JobOperation

-(NSString *) stateDump;
{
    if (self.isCancelled) 
        return @"cancelled";
    
    else if (self.isFinished)
        return @"finished";
    
    else if (self.isExecuting)
        return @"executing";
    
    else if (self.isReady)
        return @"ready";
    
    return @"waiting";
}

// desired:  JobOperation 'name' - (n) dependencies:  {dependency1[class]:state, dependency2[class]:state}
-(void) dump;
{
    NSString *dumpString = @"  ";

    NSString *className = NSStringFromClass([self class]);
    dumpString = [dumpString stringByAppendingFormat:@"[%@]", className];

    if ([self.name length]>0) 
    {
        dumpString = [dumpString stringByAppendingFormat:@" '%@'", self.name];
    }

    dumpString = [dumpString stringByAppendingFormat:@" %d dependencies", [self.dependencies count] ];

    if ([self.dependencies count]>0) 
    {
        dumpString = [dumpString stringByAppendingString:@": {"];
        for (JobOperation *aPrecursorOp in self.dependencies) 
        {
            NSString *opName = @" '<NoName>'";
            if ([aPrecursorOp.name length]>0) 
            {
                opName = [NSString stringWithFormat:@" '%@'",aPrecursorOp.name];
            }
            dumpString = [dumpString stringByAppendingString:opName];
            NSString *className = NSStringFromClass([aPrecursorOp class]);
            dumpString = [dumpString stringByAppendingFormat:@"[%@]:", className];
            dumpString = [dumpString stringByAppendingString:[aPrecursorOp stateDump]];
            
        }
        dumpString = [dumpString stringByAppendingString:@"}"];
    }

    NSLog(dumpString);
}

- (id)init
{
    if((self = [super init])) {
        _dependents = [[ThreadSafeMutableArray alloc] init];
//        _conditions = [[ThreadSafeMutableArray alloc] init];
//        _observers =  [[ThreadSafeMutableArray alloc] init];
        //self.name = @"";
    }
    
    return self;
}


-(ThreadSafeMutableDictionary *)getJobDict
{
    id owningQueue = self.homeJobQueue;
    if (owningQueue && [owningQueue isKindOfClass:[JobOperationQueue class]])
    {
        return ((JobOperationQueue *)owningQueue).jobDictionary;
    }
    
    owningQueue = [NSOperationQueue currentQueue];
    if (owningQueue && [owningQueue isKindOfClass:[JobOperationQueue class]])
    {
        return ((JobOperationQueue *)owningQueue).jobDictionary;
    }
    
    return nil;
}

-(void) addDependency:(NSOperation *)op
{
    [super addDependency:op];  // this adds op into our list of dependencies
    
    if ([op isKindOfClass:[JobOperation class]])
    {
        [((JobOperation *)op).dependents addObject:self];  // let the other job op know we are depending on them
    }
}



@end
