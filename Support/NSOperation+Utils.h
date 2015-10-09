//
//  NSOperation+Utils.h
//  NSOperationTester
//
//  Created by Specialty3 on 9/22/15.
//  Copyright (c) 2015 Specialty3. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSOperation (Utils)

-(void) mustWaitToStartUntilAfterFinishing:(NSOperation *)op2;
-(void) mustFinishBeforeStarting:(NSOperation *)op2;

@end
