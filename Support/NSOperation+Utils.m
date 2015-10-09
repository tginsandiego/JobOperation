//
//  NSOperation+Utils.m
//  NSOperationTester
//
//  Created by Specialty3 on 9/22/15.
//  Copyright (c) 2015 Specialty3. All rights reserved.
//

#import "NSOperation+Utils.h"

@implementation NSOperation (Utils)

-(void) mustWaitToStartUntilAfterFinishing:(NSOperation *)op2;
{
    if (op2 == nil) 
    {
        return;  // no dependency
    }
    
    [self addDependency:op2];
}
-(void) mustFinishBeforeStarting:(NSOperation *)op2;
{
    [op2 addDependency:self];
}


@end
