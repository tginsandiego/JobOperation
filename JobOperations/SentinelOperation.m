//
//  SentinelOperation.m
//  SpecialtyProducePRO
//
//  Created by SpecialtyDev on 9/29/15.
//
//

#import "SentinelOperation.h"

@implementation SentinelOperation

- (void)main
{
    if ([self.name length]<1) {
        self.name = @"unnamed";
    }
    
    // do stuff
    NSLog(@"Sentinel Operation:%@", self.name);
}

@end
