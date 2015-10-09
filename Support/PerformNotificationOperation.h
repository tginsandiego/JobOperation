//
//  NotificationOperation.h
//  SpecialtyProducePRO
//
//  Created by SpecialtyDev on 9/28/15.
//
//

#import "JobOperation.h"

@interface PerformNotificationOperation : JobOperation

@property (strong, atomic) NSString *notificationName;
@property (strong, atomic) NSString *objectToPost;


@end
