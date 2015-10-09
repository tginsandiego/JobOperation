//
//  FourSquareGetVenueData.m
//  SpecialtyProducePRO
//
//  Created by SpecialtyDev on 10/2/15.
//
//

#import "FourSquareGetVenueDataOperation.h"

#import "FourSquareVenue.h"
#import "ReusableObjects.h"
#import "ThreadSafeMutableDictionary.h"


@implementation FourSquareGetVenueDataOperation

-(void) handleResponse:(NSString *)responseString
{
    NSString *jsonString = responseString;    
    NSDictionary *jsonObjects =  [[ReusableObjects singleton].JSONParser objectWithString:jsonString];

    ThreadSafeMutableDictionary *jobDict = [self getJobDict];
    [jobDict setObject:jsonObjects forKey:JOB_RESULTS_FOURSQUARE_VENUE_DATA];
}

- (void)doCustomWorkHere
{    
    NSLog(@"%s ",__PRETTY_FUNCTION__);
    
    // kick off the file load.  Assume network connectivity was checked by caller
    NSString *venueURLString = [NSString stringWithFormat:FS_VENUE_URL_TEMPLATE, self.foursquareVenueIDString];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:venueURLString]];
    
    // Send the request!
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:self.homeJobQueue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) 
                           {
                               if (error || !data || !response) 
                               {
                                   //Unable to reach server
                                   NSLog(@"PutSpotWSOperation: call did not succeed!");
                                   if (self.errorCancelsSubsequentOperations) 
                                   {
                                       [self.homeJobQueue cancelAllOperations];
                                   }
                                   
                                   if (self.alertUserOnError) 
                                   {
                                       // tell the user that the spot didn't proceed
                                       dispatch_async(dispatch_get_main_queue(), ^{
                                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"There seems to be an issue with the network, so your operation was cancelled." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                                           [alertView show];
                                       });
                                   }                                   
                               }
                               else 
                               {
                                   NSLog(@"Network operation: all good!");
                                   
                                   NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                   NSLog(@"responseString = %@", responseString);
                                   
                                   [self handleResponse:responseString];
                               }
                               
                               // ALWAYS clean up ASAP.  All paths lead here
                               [self indicateCustomWorkFinished];
                               [self finish];                               

                           }];
}


@end
