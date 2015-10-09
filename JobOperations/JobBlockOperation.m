//
//  JobBlockOperation.m
//  SpecialtyProducePRO
//
//  Created by SpecialtyDev on 10/2/15.
//
//

#import "JobBlockOperation.h"

@implementation JobBlockOperation


+ (instancetype)jobOperationWithBlock:(void (^)(JobOperation *enclosingOperation))block;
{
    JobBlockOperation *newBlockJobOp = [[JobBlockOperation alloc] init];
    newBlockJobOp.blockProperty = block;
    return newBlockJobOp;
}

-(void) main
{
    // a lengthy operation
    @autoreleasepool
    {        
        if (self.isCancelled)
        {
             return;
        }
        
        // do real work here.
        self.blockProperty(self);
        NSLog(@"block job op finishing!");
    }
}

@end
