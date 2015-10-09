//
//  ReachabilityCheckOperation.h
//  NSOperationTester
//
//  Created by Specialty3 on 9/22/15.
//  Copyright (c) 2015 Specialty3. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JobOperation.h"
#import "BasicJobOperation.h"

@interface ReachabilityCheckOperation : BasicJobOperation

@property (copy, atomic) NSString *hostToCheck;
@property (assign, atomic) BOOL alertUser;




@end
