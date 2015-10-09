//
//  GPSReadingOperation.h
//  SpecialtyProducePRO
//
//  Created by SpecialtyDev on 10/1/15.
//
//

#import "BasicJobOperation.h"
#import <CoreLocation/CoreLocation.h>

#define JOB_RESULTS_GPS_READING    @"gpsReadingResult"

@interface GPSReadingOperation : BasicJobOperation <CLLocationManagerDelegate>

@property (strong, atomic) CLLocationManager *locationManager;

//@property (assign, atomic) BOOL requestInUsePermission;
@property (assign, atomic)  BOOL        requestAlwaysPermission;
@property (assign, atomic)  CGFloat     desiredAccuracyInMeters;

@property (assign, atomic) BOOL errorCancelsSubsequentOperations;
@property (assign, atomic) BOOL alertUserOnError;


@end
