//
//  AlertOperation.h
//  NSOperationTester
//
//  Created by Specialty3 on 9/21/15.
//  Copyright (c) 2015 Specialty3. All rights reserved.
//

// this alert Operation can prompt the user for
//  Ok or Cancel/Other and will return the
// result to another JobOperationQueue's jobDictionary

#import <Foundation/Foundation.h>
#import "JobOperationQueue.h"

// The user selected button title will get stored in TWO places:
// the key shown below, but also associated with the alertMessage 
// which allows multiple alerts to co-exist in a single job queue
#define JOB_RESULT_ALERT_BUTTON_TITLE          @"alertResultKey"

@interface ShowAlertMainQueueNSOp : NSOperation

@property (weak, atomic) JobOperationQueue *queueForResults;

@property (copy, atomic) NSString *alertTitle;
@property (copy, atomic) NSString *alertMessage;

@property (copy, atomic) NSString *singleButtonTitle;

@property (copy, atomic) NSString *twoButtonsTitleOne;
@property (copy, atomic) NSString *twoButtonsTitleTwo;

@property (assign, atomic) BOOL isFinishedAlertB;
@property (assign, atomic) BOOL isExecutingB;
@property (assign, atomic) BOOL isFinishedB;

@end
