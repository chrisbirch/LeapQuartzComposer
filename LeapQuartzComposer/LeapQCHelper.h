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
@class LeapScreen;

#define LEAP_ID @"id"
#define LEAP_HANDS @"hands"
#define LEAP_FINGERS @"fingers"
#define LEAP_TOOLS @"tools"
#define LEAP_POINTABLES @"pointables"
#define LEAP_IS_VALUD @"isValid"


#define LEAP_SCREEN_AXIS_HORIZONTAL @"horizontalAxis"
#define LEAP_SCREEN_AXIS_VERTICAL @"verticalAxis"

#define LEAP_SCREEN_BOTTOM_LEFT_CORNER @"bottomLeftCorner"
#define LEAP_SCREEN_NORMAL @"normal"
#define LEAP_SCREEN_WIDTH @"width"
#define LEAP_SCREEN_HEIGHT @"height"

@interface LeapQCHelper : NSObject

/**
 * If YES then vectors will be converted into dictionaries.
 * If NO then vectors will be converted into arrays. index 0: x, index 1: y, index 2: z, 
 *    then pitch roll and yaw in that order if pitch roll and yaw are being included
 */
@property(nonatomic,assign) BOOL outputVectorsAsDictionaries;

/**
 * If YES then pitch roll and yaw is included in every Vector Dictionary or Array (see outputVectorsAsDictionaries)
 */
@property(nonatomic,assign) BOOL outputYawPitchRoll;

/**
 * Returns a dictionary representation of the specified LeapScreen
 */
-(NSDictionary*) leapScreenToDictionary:(const LeapScreen*)screen;


/**
 * Returns a dictionary representation of the specified LeapFrame
 */
-(NSDictionary*) leapFrameToDictionary:(const LeapFrame*)frame;

/**
 * Returns a dictionary representation of the specified LeapHand
 */
-(NSDictionary*) leapHandToDictionary:(const LeapHand*)hand;

/**
 * Returns a dictionary representation of the specified LeapPointable (i.e finger or tool)
 */
-(NSDictionary*) leapPointableToDictionary:(const LeapPointable*)pointable;


/**
 * Returns an array filled with NSDictionary representations of LeapFingers
 */
-(NSArray*) leapFingersToQCCompatibleArray:(const NSArray*)fingers;

/**
 * Returns an array filled with NSDictionary representations of LeapHands
 */
-(NSArray*) leapHandsToQCCompatibleArray:(const NSArray*)hands;


#pragma mark -
#pragma mark Vector stuff

/**
 * depending on the setting of the outputVectorsAsDictionaries property
 * will delegate responsibility for converting the given vector to the
 * correct type.
 */
-(id)leapVectorToQCCompatibleType:(const LeapVector*)vector;

/**
 * Returns an array representation of the specified LeapVector
 */
-(NSArray*) leapVectorToArray:(const LeapVector*)vector;

/**
* Returns a dictionary representation of the specified LeapVector
*/
-(NSDictionary*) leapVectorToDictionary:(const LeapVector*)vector;


@end
