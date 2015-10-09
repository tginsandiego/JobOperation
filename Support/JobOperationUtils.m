//
//  JobOperationUtils.m
//  NSOperationTester
//
//  Created by Specialty3 on 9/22/15.
//  Copyright (c) 2015 Specialty3. All rights reserved.
//

#import "JobOperationUtils.h"
#import "JobOperation.h"
//#import "EPPZReachability.h"
//#import "ShowAlertMainQueueOperation.h"
#import <UIKit/UIKit.h>

@implementation JobOperationUtils


//+(NSBlockOperation *) jobOpToShowAlertWithTitle:(NSString *)aTitle
//                                        withMsg:(NSString *)aMsg
//                               withButton1Title:(NSString *)aTitle1
//                               withButton2Title:(NSString *)aTitle2;
//{
//    // if this operation is a dependency for others, then propogate the dependency
//    // down to the actual alert show op?
//    
//    // One alternative would be to NOT finish this until that one finishes
//    
//    NSBlockOperation *alertOp = [NSBlockOperation blockOperationWithBlock:^{
//        
//        ShowAlertOperation *showAlertOp = [[ShowAlertOperation alloc] init];
//        showAlertOp.alertTitle = aTitle;
//        showAlertOp.alertMessage = aMsg;
//        
//        if (aTitle2)
//        {
//            showAlertOp.twoButtonsTitleTwo = aTitle2;
//            showAlertOp.twoButtonsTitleOne = aTitle1;
//        }
//        else
//        {
//            showAlertOp.singleButtonTitle = aTitle1;
//        }
//        
//        if ([[NSOperationQueue currentQueue] isKindOfClass:[JobOperationQueue class]])
//        {
//            showAlertOp.queueForResults = (JobOperationQueue *)[NSOperationQueue currentQueue];
//        }
//        
//        [[NSOperationQueue mainQueue] addOperation:showAlertOp];
//    }];
//    
//    return alertOp;
//}
//
//
//+(NSBlockOperation *) jobOpToShowAlertWithTitle:(NSString *)aTitle
//                                        withMsg:(NSString *)aMsg
//                               withButton1Title:(NSString *)aTitle1
//                               withButton2Title:(NSString *)aTitle2
//                                   beforeThisOp:(JobOperation *)dependentOp;
//{
//    // if this operation is a dependency for others, then propogate the dependency
//    // down to the actual alert show op?
//    
//    // One alternative would be to NOT finish this until that one finishes
//    
//    __block NSBlockOperation *alertOp = [NSBlockOperation blockOperationWithBlock:^{
//        
//        ShowAlertOperation *showAlertOp = [[ShowAlertOperation alloc] init];
//        showAlertOp.alertTitle = aTitle;
//        showAlertOp.alertMessage = aMsg;
//        
//        if (aTitle2)
//        {
//            showAlertOp.twoButtonsTitleTwo = aTitle2;
//            showAlertOp.twoButtonsTitleOne = aTitle1;
//        }
//        else
//        {
//            showAlertOp.singleButtonTitle = aTitle1;
//        }
//        
//        if ([[NSOperationQueue currentQueue] isKindOfClass:[JobOperationQueue class]])
//        {
//            showAlertOp.queueForResults = (JobOperationQueue *)[NSOperationQueue currentQueue];
//        }
//        
//        [dependentOp addDependency:showAlertOp];
//        [[NSOperationQueue mainQueue] addOperation:showAlertOp];
//    }];
//    
//    return alertOp;
//}


//+(NSBlockOperation *) jobOpToCancelQueueIfReachabilityCheckFailsForHost:(NSString*)aHost alertUser:(BOOL)alertUser;
//{
//    __block NSString *blockHost = aHost;
//    
//    NSBlockOperation *reachabilityOp = [NSBlockOperation blockOperationWithBlock:^{
//        
//        [EPPZReachability reachHost:blockHost completion:^(EPPZReachability *reachability)
//        {
//            if (reachability.notReachable)
//            {
//                NSOperationQueue *myQ = [NSOperationQueue currentQueue];
//                assert(![myQ isEqual:[NSOperationQueue mainQueue]]);
//                
//                [myQ cancelAllOperations];
//                
//                if (alertUser)
//                {
//                    //
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"You do not seem to have internet access right now!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
//                        [alertView show];
//                    });
//                    
//                }
//                
//            }
//        }];
//        
//    }];
//    
//    return reachabilityOp;
//}

@end
