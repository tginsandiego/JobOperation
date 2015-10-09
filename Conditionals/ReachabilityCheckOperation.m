//
//  ReachabilityCheckOperation.m
//  NSOperationTester
//
//  Created by Specialty3 on 9/22/15.
//  Copyright (c) 2015 Specialty3. All rights reserved.
//

#import "ReachabilityCheckOperation.h"
//#import "EPPZReachability.h"
#import <UIKit/UIKit.h>
#import "Reachability.h"

@implementation ReachabilityCheckOperation

-(void) hostNotReachable
{
    
}

-(void) hostReachable
{
    
}

- (void)doCustomWorkHere
{
    Reachability *reachStatus = [Reachability reachabilityWithHostName:self.hostToCheck];
    
    if ([reachStatus currentReachabilityStatus] == NotReachable)
    {
        NSLog(@"Reachability Check Operation:  host was NOT reachable.");
        NSLog(@"Reachability Check Operation:  cancelling pending operations.");
        
        [[NSOperationQueue currentQueue] cancelAllOperations];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"You do not seem to have internet access right now!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
            [alertView show];
        });
    }
    else
    {
        NSLog(@"Reachability Check Operation:  host was reachable.");
    }
    
    [self indicateCustomWorkFinished];
    [self finish];

}

@end
