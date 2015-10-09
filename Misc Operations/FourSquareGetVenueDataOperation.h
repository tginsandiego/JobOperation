//
//  FourSquareGetVenueData.h
//  SpecialtyProducePRO
//
//  Created by SpecialtyDev on 10/2/15.
//
//

#import "BasicJobOperation.h"

#define JOB_RESULTS_FOURSQUARE_VENUE_DATA   @"foursquareVenueData"

@interface FourSquareGetVenueDataOperation : BasicJobOperation

@property (copy, atomic) NSString *foursquareVenueIDString;
@property (assign, atomic) BOOL errorCancelsSubsequentOperations;
@property (assign, atomic) BOOL alertUserOnError;

@end
