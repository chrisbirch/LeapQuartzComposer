//
//  LeapQuartzComposerPlugIn.h
//  LeapQuartzComposer
//
//  Created by chris on 05/01/2013.
//  Copyright (c) 2013 Chris Birch. All rights reserved.
//

#import <Quartz/Quartz.h>
#import "LeapObjectiveC.h"

@interface LeapQuartzComposerPlugIn : QCPlugIn<LeapDelegate>


#define INPUT_RETURN_FRAME @"inputReturnFrame"

#define OUTPUT_FRAME @"outputFrame"
#define OUTPUT_HANDS @"outputHands"
#define OUTPUT_FINGERS @"outputFingers"

/**
 * Set to YES if entire frame data should be converted to dictionary format.
 */
@property(assign) BOOL inputReturnFrame;


/**
 * QC ouput containing Leap frame dictionary.
 */
@property (assign) NSDictionary* outputFrame;

/**
 * QC output containing the hands.
 */
@property(assign) NSArray* outputHands;

/**
 * QC output containing the fingers.
 */
@property(assign) NSArray* outputFingers;


@end
