//
//  JobBlockOperation.h
//  SpecialtyProducePRO
//
//  Created by SpecialtyDev on 10/2/15.
//
//

#import "JobOperation.h"

@interface JobBlockOperation : JobOperation

+ (instancetype)jobOperationWithBlock:(void (^)(JobOperation *enclosingOperation))block;

@property (copy) void (^blockProperty)(JobOperation *enclosingOperation);

@end
