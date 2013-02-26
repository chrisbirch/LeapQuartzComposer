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
@class LeapController;
//These define what the QC structures will be called



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

//New as of 0.7.4. Gestures!!!

//LEAP_GESTURE_TYPE_INVALID = -1
//LEAP_GESTURE_TYPE_SWIPE = 1,
//LEAP_GESTURE_TYPE_CIRCLE = 4,
//LEAP_GESTURE_TYPE_SCREEN_TAP = 5,
//LEAP_GESTURE_TYPE_KEY_TAP = 6
#define LEAP_GESTURE_TYPE @"type"

//LEAP_GESTURE_STATE_INVALID = -1
//LEAP_GESTURE_STATE_START = 1
//LEAP_GESTURE_STATE_UPDATE = 2
//LEAP_GESTURE_STATE_STOP = 3,
#define LEAP_GESTURE_STATE @"state"

//float
#define LEAP_GESTURE_DURATION_SECONDS @"durationSeconds"

//qc array of hand structures
#define LEAP_GESTURE_HANDS @"hands"
//qc array of pointable structures
#define LEAP_GESTURE_POINTABLES @"pointables"

//qc structure
#define LEAP_GESTURE_SWIPE_POSITION @"position"
#define LEAP_GESTURE_SWIPE_START_POSITION @"startPosition"
#define LEAP_GESTURE_SWIPE_DIRECTION @"direction"
#define LEAP_GESTURE_SWIPE_SPEED @"speed"
#define LEAP_GESTURE_SWIPE_POINTABLE @"pointable"



#define LEAP_GESTURE_CIRCLE_PROGRESS @"progress"
#define LEAP_GESTURE_CIRCLE_CENTER @"center"
#define LEAP_GESTURE_CIRCLE_NORMAL @"normal"
#define LEAP_GESTURE_CIRCLE_RADIUS @"radius"
#define LEAP_GESTURE_CIRCLE_POINTABLE @"pointable"
#define LEAP_GESTURE_CIRCLE_SWEPT_ANGLE @"sweptAngle"



#define LEAP_GESTURE_SCREEN_TAP_POSITION @"position"
#define LEAP_GESTURE_SCREEN_TAP_DIRECTION @"direction"
#define LEAP_GESTURE_SCREEN_TAP_PROGRESS @"progress"
#define LEAP_GESTURE_SCREEN_TAP_POINTABLE @"pointable"


#define LEAP_GESTURE_KEY_TAP_POSITION @"position"
#define LEAP_GESTURE_KEY_TAP_DIRECTION @"direction"
#define LEAP_GESTURE_KEY_TAP_PROGRESS @"progress"
#define LEAP_GESTURE_KEY_TAP_POINTABLE @"pointable"


//#define LEAP_GESTURE_ @""

@interface LeapQCHelper : NSObject

/**
 * Pointer to the leap controller
 */
@property(nonatomic,weak) LeapController* leapController;

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
 * If YES then finger arrays will in included in hand structures
 */
@property(nonatomic,assign) BOOL includeFingersInHand;

/**
 * If YES then pointable arrays will in included in hand structures
 */
@property(nonatomic,assign) BOOL includePointablesInHand;
/**
 * If YES then tool arrays will in included in hand structures
 */
@property(nonatomic,assign) BOOL includeToolsInHand;

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
-(NSArray*) leapPointablesToQCCompatibleArray:(const NSArray*)pointables;

/**
 * Returns an array filled with NSDictionary representations of LeapHands
 */
-(NSArray*) leapHandsToQCCompatibleArray:(const NSArray*)hands;

/**
 * Returns an array filled with NSDictionary representations of LeapScreens
 */
-(NSArray*) leapScreensToQCCompatibleArray:(const NSArray*)screens;


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
