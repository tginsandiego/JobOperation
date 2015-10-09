//
//  AlertOperation.m
//  NSOperationTester
//
//  Created by Specialty3 on 9/21/15.
//  Copyright (c) 2015 Specialty3. All rights reserved.
//

#import "ShowAlertMainQueueNSOp.h"
#import <UIKit/UIKit.h>

@implementation ShowAlertMainQueueNSOp


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
{
    // determine result
    NSString *buttonClickedTitle = [alertView buttonTitleAtIndex:buttonIndex];
    
    // notify any queue waiting for results.
    if (self.queueForResults)
    {
        [self.queueForResults.jobDictionary setObject:buttonClickedTitle forKey:JOB_RESULT_ALERT_BUTTON_TITLE];
        
        // in case there are multiple alerts for this job, store a dictionary to help users find this one.
        [self.queueForResults.jobDictionary setObject:buttonClickedTitle forKey:self.alertMessage];
    }
    
    self.isFinishedAlertB = YES;
    [self finish];
}
//[alert show];


-(BOOL) isConcurrent
{
    return NO;
}

- (void)main {
    
    // a lengthy operation
    @autoreleasepool
    {
        if (self.isCancelled)
        {    // finish!
            self.isFinishedAlertB = YES;
            [self finish];
            return;
        }
        
        // must run on main main quue since is an UI operation
        if (![[NSThread currentThread] isEqual:[NSThread mainThread]])
        {
            NSLog(@"UI Operation (show UIAlertView) attempted on thread that is NOT MAIN");
            return;
        }
        
        self.isFinishedAlertB = NO;
        
        if (self.alertTitle == nil)
        {
            self.alertTitle = @"Alert";
        }
        
        UIAlertView* alert;
        if (self.twoButtonsTitleOne == nil)
        {
            // use singleButtonTitle
            if (self.singleButtonTitle == nil)
            {
                self.singleButtonTitle = @"Ok";
            }
            
            alert = [[UIAlertView alloc] initWithTitle:self.alertTitle
                                                            message:self.alertMessage
                                                           delegate:self
                                                  cancelButtonTitle:self.singleButtonTitle
                                                  otherButtonTitles:nil];
            
            [alert show];
        }
        else  // two buttons
        {
            alert = [[UIAlertView alloc] initWithTitle:self.alertTitle
                                               message:self.alertMessage
                                              delegate:self
                                     cancelButtonTitle:self.twoButtonsTitleOne
                                     otherButtonTitles:self.twoButtonsTitleTwo, nil];
            
            [alert show];
        }

        // so this will fall out of main and try to end this task.  Override the "finish" methods to wait until the user responds
    }
}


///////////////////////


- (id)init
{
    if((self = [super init])) {
        _isExecutingB = NO;
        _isFinishedB = NO;
    }
    
    return self;
}


- (void)start
{
    //[super start]; // needed?  buggy?
    
    if (![NSThread isMainThread])
    {
        NSLog(@"UI Operation attempted from NON MAIN THREAD!");
        [self performSelectorOnMainThread:@selector(start) withObject:nil waitUntilDone:NO];
        return;
    }
    
    if ([self isCancelled]) {
        [self willChangeValueForKey:@"isFinished"];
        _isFinishedB = YES;
        [self didChangeValueForKey:@"isFinished"];
        return;
    }
    
    [self willChangeValueForKey:@"isExecuting"];
    _isExecutingB = YES;
    [self didChangeValueForKey:@"isExecuting"];
    
    [self main];
}

- (void)finish
{
    if (!self.isFinishedAlertB)
    {
        return;  // must get user input before finishing!
    }
    
    [self willChangeValueForKey:@"isExecuting"];
    [self willChangeValueForKey:@"isFinished"];
    
    _isExecutingB = NO;
    _isFinishedB = YES;
    
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

- (BOOL)isExecuting {
    return _isExecutingB;
}

- (BOOL)isFinished {
    return _isFinishedB;
}




@end
