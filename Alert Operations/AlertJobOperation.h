//
//  AlertOperation.h
//  NSOperationTester
//
//  Created by Specialty3 on 9/22/15.
//  Copyright (c) 2015 Specialty3. All rights reserved.
//

#import "BasicJobOperation.h"

// This operation can be scheduled in any JobQueue and when it executes
// it schedules a ShowAlert operation on the main queue.

// It also propogates all dependents to the ShowAlert op, to ensure the alert 
// is shown BEFORE any dependents make progress so although this routine should 
// execute and complete quickly, it will NOT result in race conditions.

@interface AlertJobOperation : BasicJobOperation

@property (copy, atomic) NSString *alertTitle;
@property (copy, atomic) NSString *alertMessage;

@property (copy, atomic) NSString *singleButtonTitle;

@property (copy, atomic) NSString *twoButtonsTitleOne;
@property (copy, atomic) NSString *twoButtonsTitleTwo;

@end
