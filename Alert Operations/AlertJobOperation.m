//
//  AlertOperation.m
//  NSOperationTester
//
//  Created by Specialty3 on 9/22/15.
//  Copyright (c) 2015 Specialty3. All rights reserved.
//

#import "AlertJobOperation.h"
#import "ShowAlertMainQueueNSOp.h"
#import "NSOperation+Utils.h"


@implementation AlertJobOperation

- (void)doCustomWorkHere
{
    // do stuff
    ShowAlertMainQueueNSOp *showAlertOp = [[ShowAlertMainQueueNSOp alloc] init];
    showAlertOp.alertTitle = self.alertTitle;
    showAlertOp.alertMessage = self.alertMessage;
    
    if (self.twoButtonsTitleTwo)
    {
        showAlertOp.twoButtonsTitleTwo = self.twoButtonsTitleTwo;
        showAlertOp.twoButtonsTitleOne = self.twoButtonsTitleOne;
    }
    else
    {
        showAlertOp.singleButtonTitle = self.singleButtonTitle;
    }
    

    
    if ([[NSOperationQueue currentQueue] isKindOfClass:[JobOperationQueue class]])
    {
        showAlertOp.queueForResults = (JobOperationQueue *)[NSOperationQueue currentQueue];
    }
    
    // propagate dependents...
    for (JobOperation *dependentOp in self.dependents)
    {
        [showAlertOp mustFinishBeforeStarting:dependentOp];
    }
        
    [[NSOperationQueue mainQueue] addOperation:showAlertOp];
    
    // when done, finish up
    [self indicateCustomWorkFinished];
    [self finish];
}

@end
