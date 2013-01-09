//
//  LeapQCHelper.h
//  LeapQuartzComposer
//
//  Created by chris on 05/01/2013.
//  Copyright (c) 2013 Chris Birch. All rights reserved.
//

/**
 * Implemented as a helper class so to allow easy modification if leap sdk objective c wrapper changes
 */

#import <Foundation/Foundation.h>

@class LeapHand;
@class LeapPointable;
@class LeapVector;
@class LeapFrame;

#define LEAP_ID @"id"
#define LEAP_HANDS @"hands"
#define LEAP_FINGERS @"fingers"
#define LEAP_TOOLS @"tools"
#define LEAP_POINTABLES @"pointables"


@interface LeapQCHelper : NSObject

/**
 * Returns a dictionary representation of the specified LeapFrame
 */
+(NSDictionary*) leapFrameToDictionary:(const LeapFrame*)frame;

/**
 * Returns a dictionary representation of the specified LeapHand
 */
+(NSDictionary*) leapHandToDictionary:(const LeapHand*)hand;

/**
 * Returns a dictionary representation of the specified LeapPointable (i.e finger or tool)
 */
+(NSDictionary*) leapPointableToDictionary:(const LeapPointable*)pointable;


/**
 * Returns a dictionary representation of the specified LeapVector
 */
+(NSDictionary*) leapVectorToDictionary:(const LeapVector*)vector;


/**
 * Returns an array filled with NSDictionary representations of LeapFingers
 */
+(NSArray*) leapFingersToQCCompatibleArray:(const NSArray*)fingers;

/**
 * Returns an array filled with NSDictionary representations of LeapHands
 */
+(NSArray*) leapHandsToQCCompatibleArray:(const NSArray*)hands;


@end
