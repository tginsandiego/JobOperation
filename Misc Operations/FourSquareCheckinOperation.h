//
//  FourSquareCheckinOperation.h
//  SpecialtyProducePRO
//
//  Created by SpecialtyDev on 10/6/15.
//
//

#import "BasicJobOperation.h"

@interface FourSquareCheckinOperation : BasicJobOperation


@property (copy, atomic) NSString *venueID;
@property (copy, atomic) NSString *comment;
@property (strong, atomic) UIImage *anImage;


@end
