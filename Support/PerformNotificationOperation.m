//
//  NotificationOperation.m
//  SpecialtyProducePRO
//
//  Created by SpecialtyDev on 9/28/15.
//
//

#import "PerformNotificationOperation.h"

@implementation PerformNotificationOperation


-(void) main;
{
    [[NSNotificationCenter defaultCenter] performSelectorOnMainThread:@selector(postNotification:)
                                                           withObject:[NSNotification notificationWithName:self.notificationName object:self.objectToPost ]
                                                        waitUntilDone: NO];

}

@end
