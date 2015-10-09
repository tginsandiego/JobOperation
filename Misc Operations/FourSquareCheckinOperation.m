//
//  FourSquareCheckinOperation.m
//  SpecialtyProducePRO
//
//  Created by SpecialtyDev on 10/6/15.
//
//

#import "FourSquareCheckinOperation.h"
#import "Foursquare2.h"


@implementation FourSquareCheckinOperation

- (void)doCustomWorkHere
{
    //__block FourSquareCheckinOperation *safeSelf = self;
    //__block NSString *blockVenueID = self.venueID;
    
    [Foursquare2  createCheckinAtVenue:self.venueID venue:nil shout:self.comment
                              callback:^(BOOL success, id result)
     {
         if (success)
         {
             // let listeners know about it.
             NSLog(@"4Square checkin success!  :)");
             NSArray *levelOneKeys = [((NSDictionary *)result) allKeys];  // notifications, meta, response
             NSDictionary *responseDict = [((NSDictionary *)result) objectForKey:@"response"];
             NSDictionary *checkinDict = [responseDict objectForKey:@"checkin"];
             NSString *checkinID = [checkinDict objectForKey:@"id"];
             
             if (self.anImage != nil)
             {
                 [Foursquare2 addPhoto:self.anImage toCheckin:checkinID callback:^(BOOL success, id result)
                  {
                      if (success)
                      {
                          // let listeners know about it.
                          NSLog(@"4Square photo add success!  :)");
                          [self indicateCustomWorkFinished];
                          [self finish];
                      }
                      else
                      {
                          // let listeners know about it.
                          NSLog(@"4Square photo add failed  :(");    
                          [self indicateCustomWorkFinished];
                          [self finish];
                      }
                  }];
             }
             else 
             {
                 [self indicateCustomWorkFinished];
                 [self finish];
             }
         }
         else
         {
             // let listeners know about it.
             NSLog(@"4Square checkin failed  :(");
             [self indicateCustomWorkFinished];
             [self finish];
         }
     }];

}


@end
