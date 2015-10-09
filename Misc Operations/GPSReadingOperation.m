//
//  GPSReadingOperation.m
//  SpecialtyProducePRO
//
//  Created by SpecialtyDev on 10/1/15.
//
//

#import "GPSReadingOperation.h"
#import "ThreadSafeMutableDictionary.h"

@implementation GPSReadingOperation

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusAuthorized || status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) 
    {
        // start requesting info
        [self.locationManager startUpdatingLocation];
    }
    else
    {
        if (self.alertUserOnError)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"The app has been denied access to GPS data, so some functions are not available." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [alertView show];
            });
        }
        
        // not authorized, or denied, or ???
        if (self.errorCancelsSubsequentOperations)
        {
            [self.homeJobQueue cancelAllOperations];
        }
        
        self.locationManager.delegate = nil;
        [self indicateCustomWorkFinished];
        [self finish];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation 
{
    float lat = newLocation.coordinate.latitude;
    float lon = newLocation.coordinate.longitude;    
    
    if (newLocation.horizontalAccuracy <= self.desiredAccuracyInMeters) 
    {
        // good reading!
        ThreadSafeMutableDictionary *jobDict = [self getJobDict];
        [jobDict setObject:newLocation forKey:JOB_RESULTS_GPS_READING];
        
        self.locationManager.delegate = nil;
        [self.locationManager stopUpdatingLocation];
     
        [self indicateCustomWorkFinished];
        [self finish];   
    }
    
}


- (void)doCustomWorkHere
{       
    // From iOS 8.0 We must explicitly request access to location
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusAuthorized || status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse) 
    {
        NSLog(@"location access authorized, nothing to worry about");
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self; 
        [self.locationManager startUpdatingLocation];
    } 
    else if (status == kCLAuthorizationStatusDenied)
    {
        if (self.alertUserOnError)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"The app has been denied access to GPS data, so some functions are not available." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [alertView show];
            });
        }
        
        // not authorized, or denied, or ???
        if (self.errorCancelsSubsequentOperations)
        {
            [self.homeJobQueue cancelAllOperations];            
        }
        [self indicateCustomWorkFinished];
        [self finish];
    }
    else if (status == kCLAuthorizationStatusNotDetermined)
    {
        NSLog(@"location access not authorized, prompt");

        self.locationManager = [[CLLocationManager alloc] init];  
        self.locationManager.delegate = self; 
        if (self.requestAlwaysPermission) 
        {
            [self.locationManager requestAlwaysAuthorization];
        }
        else
        {
            [self.locationManager requestWhenInUseAuthorization];            
        }
    }        
}



@end
