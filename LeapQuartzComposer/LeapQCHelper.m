//
//  LeapQCHelper.m
//  LeapQuartzComposer
//
//  Created by chris on 05/01/2013.
//  Copyright (c) 2013 Chris Birch. All rights reserved.
//

#import "LeapQCHelper.h"
#import "LeapObjectiveC.h"

#define NSNumberFromInt(VALUE) [[NSNumber alloc] initWithInteger:VALUE]
#define NSNumberFromDouble(VALUE) [[NSNumber alloc] initWithDouble:VALUE]
#define NSNumberFromBOOL(VALUE) [[NSNumber alloc] initWithBOOL:VALUE]

#define QCRepresentationOfVector(VALUE) [self leapVectorToQCCompatibleType:VALUE]
#define QCRepresentationOfPointablesArray(VALUE) [self leapPointablesToQCCompatibleArray:VALUE]
#define QCRepresentationOfPointable(VALUE) [self leapPointableToDictionary:VALUE]
@interface LeapQCHelper ()
{
    
}




@end

@implementation LeapQCHelper
@synthesize includeGestureSwipe=_includeGestureSwipe;
@synthesize includeGestureKeyTap=_includeGestureKeyTap;
@synthesize includeGestureCircle=_includeGestureCircle;
@synthesize includeGestureScreenTap=_includeGestureScreenTap;

#pragma mark -
#pragma mark Gesture properties

-(void)setIncludeGestureCircle:(BOOL)includeGestureCircle
{
    _includeGestureCircle = includeGestureCircle;
    [_leapController enableGesture:LEAP_GESTURE_TYPE_CIRCLE enable:includeGestureCircle];

}


-(void)setIncludeGestureKeyTap:(BOOL)includeGestureKeyTap
{
    _includeGestureKeyTap = includeGestureKeyTap;
    [_leapController enableGesture:LEAP_GESTURE_TYPE_KEY_TAP enable:includeGestureKeyTap];

}


-(void)setIncludeGestureScreenTap:(BOOL)includeGestureScreenTap
{
    _includeGestureScreenTap = includeGestureScreenTap;
    [_leapController enableGesture:LEAP_GESTURE_TYPE_SCREEN_TAP enable:includeGestureScreenTap];


}


-(void)setIncludeGestureSwipe:(BOOL)includeGestureSwipe
{
    _includeGestureSwipe = includeGestureSwipe;
    [_leapController enableGesture:LEAP_GESTURE_TYPE_SWIPE enable:includeGestureSwipe];
}



-(NSDictionary*) leapGestureToDictionary:(const LeapGesture*)gesture
{
    NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] init];

    
    [dictionary setObject:NSNumberFromInt(gesture.type) forKey:LEAP_GESTURE_TYPE];
    [dictionary setObject:NSNumberFromInt(gesture.state) forKey:LEAP_GESTURE_STATE];
    [dictionary setObject:NSNumberFromDouble(gesture.durationSeconds) forKey:LEAP_GESTURE_DURATION_SECONDS];

    //Now add properties to the output for each of the specific types
    //of gesture
    switch (gesture.type)
    {
        case LEAP_GESTURE_TYPE_CIRCLE:
        {
            LeapCircleGesture *circleGesture = (LeapCircleGesture *)gesture;
            // Calculate the angle swept since the last frame
            float sweptAngle = 0;

            if(circleGesture.state != LEAP_GESTURE_STATE_START)
            {
                LeapCircleGesture *previousUpdate = (LeapCircleGesture *)[[_leapController frame:1] gesture:gesture.id];
                sweptAngle = (circleGesture.progress - previousUpdate.progress) * 2 * LEAP_PI;
                sweptAngle *= LEAP_RAD_TO_DEG;
            }
            
            [dictionary setObject:NSNumberFromDouble(sweptAngle) forKey:LEAP_GESTURE_CIRCLE_SWEPT_ANGLE];
            
//            NSLog(@"Circle id: %d, %@, progress: %f, radius %f, angle: %f degrees",
//                  circleGesture.id, [Sample stringForState:gesture.state],
//                  circleGesture.progress, circleGesture.radius, sweptAngle * LEAP_RAD_TO_DEG);
            break;
        }
        case LEAP_GESTURE_TYPE_SWIPE:
        {
            LeapSwipeGesture *swipeGesture = (LeapSwipeGesture *)gesture;
            
            [dictionary setObject:QCRepresentationOfVector(swipeGesture.position) forKey:LEAP_GESTURE_SWIPE_POSITION];
            [dictionary setObject:QCRepresentationOfVector(swipeGesture.startPosition) forKey:LEAP_GESTURE_SWIPE_START_POSITION];
            [dictionary setObject:QCRepresentationOfVector(swipeGesture.direction) forKey:LEAP_GESTURE_SWIPE_DIRECTION];
            [dictionary setObject:QCRepresentationOfPointable(swipeGesture.pointable) forKey:LEAP_GESTURE_SWIPE_POINTABLE];
            
//            NSLog(@"Swipe id: %d, %@, position: %@, direction: %@, speed: %f",
//                  swipeGesture.id, [Sample stringForState:swipeGesture.state],
//                  swipeGesture.position, swipeGesture.direction, swipeGesture.speed);
            break;
        }
        case LEAP_GESTURE_TYPE_KEY_TAP:
        {
            LeapKeyTapGesture *keyTapGesture = (LeapKeyTapGesture *)gesture;
            [dictionary setObject:QCRepresentationOfVector(keyTapGesture.position) forKey:LEAP_GESTURE_KEY_TAP_POSITION];
            [dictionary setObject:QCRepresentationOfVector(keyTapGesture.direction) forKey:LEAP_GESTURE_KEY_TAP_DIRECTION];
            [dictionary setObject:NSNumberFromDouble(keyTapGesture.progress) forKey:LEAP_GESTURE_KEY_TAP_PROGRESS];
            [dictionary setObject:QCRepresentationOfPointable(keyTapGesture.pointable) forKey:LEAP_GESTURE_KEY_TAP_POINTABLE];
            
            //
            
//            NSLog(@"Key Tap id: %d, %@, position: %@, direction: %@",
//                  keyTapGesture.id, [Sample stringForState:keyTapGesture.state],
//                  keyTapGesture.position, keyTapGesture.direction);
            break;
        }
        case LEAP_GESTURE_TYPE_SCREEN_TAP:
        {
            LeapScreenTapGesture *screenTapGesture = (LeapScreenTapGesture *)gesture;
            
            [dictionary setObject:QCRepresentationOfVector(screenTapGesture.position) forKey:LEAP_GESTURE_SCREEN_TAP_POSITION];
            [dictionary setObject:QCRepresentationOfVector(screenTapGesture.direction) forKey:LEAP_GESTURE_SCREEN_TAP_DIRECTION];
            [dictionary setObject:NSNumberFromDouble(screenTapGesture.progress) forKey:LEAP_GESTURE_SCREEN_TAP_PROGRESS];
            [dictionary setObject:QCRepresentationOfPointable(screenTapGesture.pointable) forKey:LEAP_GESTURE_SCREEN_TAP_POINTABLE];
//            
//            NSLog(@"Screen Tap id: %d, %@, position: %@, direction: %@",
//                  screenTapGesture.id, [Sample stringForState:screenTapGesture.state],
//                  screenTapGesture.position, screenTapGesture.direction);
            break;
        }
        default:
            NSLog(@"Unknown gesture type");
            break;
    }

    
    
    return dictionary;
}

-(NSDictionary*) leapScreenToDictionary:(const LeapScreen*)screen
{
    NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] init];

    [dictionary setObject:[self leapVectorToQCCompatibleType:screen.horizontalAxis] forKey:LEAP_SCREEN_AXIS_HORIZONTAL];
    [dictionary setObject:[self leapVectorToQCCompatibleType:screen.verticalAxis] forKey:LEAP_SCREEN_AXIS_VERTICAL];
    [dictionary setObject:[self leapVectorToQCCompatibleType:screen.bottomLeftCorner] forKey:LEAP_SCREEN_BOTTOM_LEFT_CORNER];
    [dictionary setObject:[self leapVectorToQCCompatibleType:screen.normal] forKey:LEAP_SCREEN_NORMAL];
    

    [dictionary setObject:[[NSNumber alloc] initWithInt:screen.widthPixels] forKey:LEAP_SCREEN_WIDTH];
    [dictionary setObject:[[NSNumber alloc] initWithInt:screen.heightPixels] forKey:LEAP_SCREEN_HEIGHT];
    [dictionary setObject:[[NSNumber alloc] initWithBool:screen.isValid] forKey:LEAP_IS_VALUD];
    
    
    return dictionary;
}



-(NSDictionary*) leapFrameToDictionary:(const LeapFrame*)frame
{
    NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] init];
    
    [dictionary setObject:[[NSNumber alloc] initWithLongLong:frame.id] forKey:LEAP_ID];
    [dictionary setObject:[[NSNumber alloc] initWithLongLong:frame.timestamp] forKey:@"timestamp"];
    
//    if (frame.hands)
//    {
//        //get an array containing the hand dictionaries
//        NSArray* qcHands = [self leapHandsToQCCompatibleArray:frame.hands];
//        [dictionary setObject:qcHands forKey:LEAP_HANDS];
//    }
//    
//    if (frame.fingers)
//    {
//        //get an array containing the finger dictionaries
//        NSArray* qcFingers = [self leapFingersToQCCompatibleArray:frame.fingers];
//        [dictionary setObject:qcFingers forKey:LEAP_FINGERS];
//    }
    
//    if (frame.pointables)
//    {
//        //get an array containing the pointables dictionaries
//        NSArray* qcPointables = [self leapPointablesToQCCompatibleArray:frame.pointables];
//        [dictionary setObject:qcPointables forKey:LEAP_POINTABLES];
//    }
//
//    if (frame.tools)
//    {
//        //get an array containing the tools dictionaries
//        NSArray* qcTools = [self leapPointablesToQCCompatibleArray:frame.tools];
//        [dictionary setObject:qcTools forKey:LEAP_TOOLS];
//    }
    
    
    return dictionary;
    
}

-(NSDictionary*) leapHandToDictionary:(const LeapHand*)hand
{
    NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] init];
    
    [dictionary setObject:[[NSNumber alloc] initWithInteger:hand.id] forKey:LEAP_ID];

    if (_includeFingersInHand)
    {
        NSArray* items = hand.fingers;
        //get an array
        NSArray* dict = [self leapPointablesToQCCompatibleArray:items];
        [dictionary setObject:dict forKey:LEAP_FINGERS];
    }

    
    if (_includePointablesInHand)
    {
        NSArray* items = hand.pointables;
        //get an array
        NSArray* dict = [self leapPointablesToQCCompatibleArray:items];
        [dictionary setObject:dict forKey:LEAP_POINTABLES];
    }
    
    if (_includeToolsInHand)
    {
        NSArray* items = hand.tools;
        //get an array
        NSArray* dict = [self leapPointablesToQCCompatibleArray:items];
        [dictionary setObject:dict forKey:LEAP_TOOLS];
    }

    //The following things may or may not exist so we need to test for each one before sending it
    //otherwise these things will be wrongly reported as being 0
    
    //Make sure the hand has a palm ray
    if (hand.palmPosition)
    {
        [dictionary setObject:[self leapVectorToQCCompatibleType: hand.palmPosition] forKey:@"palmPosition"];
    }
    //make sure it has a velocity vector
    if(hand.palmVelocity)
    {
        [dictionary setObject:[self leapVectorToQCCompatibleType:hand.palmVelocity] forKey:@"palmVelocity"];
    }
    //make sure it has a normal vector
    if(hand.palmNormal)
        [dictionary setObject:[self leapVectorToQCCompatibleType:hand.palmNormal] forKey:@"palmNormal"];
    
    
    if(hand.direction)
    {
        [dictionary setObject:[self leapVectorToQCCompatibleType:hand.direction] forKey:@"direction"];
    }
    
    if(hand.sphereCenter)
    {
        [dictionary setObject:[self leapVectorToQCCompatibleType:hand.sphereCenter] forKey:@"sphereCenter"];
    }
    

    [dictionary setObject:[NSNumber numberWithFloat:hand.sphereRadius] forKey:@"sphereRadius"];
    [dictionary setObject:[NSNumber numberWithBool:hand.isValid] forKey:@"isValid"];
    
    
    return dictionary;
}

-(NSDictionary*) leapPointableToDictionary:(const LeapPointable*)pointable
{
    NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] init];
    
    [dictionary setObject:[[NSNumber alloc] initWithInteger:pointable.id] forKey:LEAP_ID];
    
    
    if(pointable.tipPosition)
    {
        [dictionary setObject:[self leapVectorToQCCompatibleType:pointable.tipPosition] forKey:@"tipPosition"];
    }
    
    if(pointable.tipVelocity)
    {
        [dictionary setObject:[self leapVectorToQCCompatibleType:pointable.tipVelocity] forKey:@"tipVelocity"];
    }
    
    if(pointable.direction)
    {
        [dictionary setObject:[self leapVectorToQCCompatibleType:pointable.direction] forKey:@"direction"];
    }
    
    [dictionary setObject:[[NSNumber alloc] initWithFloat:pointable.width] forKey:@"width"];
    [dictionary setObject:[[NSNumber alloc] initWithFloat:pointable.length] forKey:@"length"];
    
    [dictionary setObject:[[NSNumber alloc] initWithBool:pointable.isFinger] forKey:@"isFinger"];
    [dictionary setObject:[[NSNumber alloc] initWithBool:pointable.isTool] forKey:@"isTool"];
    [dictionary setObject:[[NSNumber alloc] initWithBool:pointable.isValid] forKey:@"isValid"];
    
    
    return dictionary;
}


#pragma mark -
#pragma mark Array output functions

-(NSArray*) leapScreensToQCCompatibleArray:(const NSArray*)screens
{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    
    for (LeapScreen* screen in screens)
    {
        [array addObject:[self leapScreenToDictionary:screen]];
    }
    
    return array;
}


-(NSArray*) leapHandsToQCCompatibleArray:(const NSArray*)hands
{
    NSMutableArray* handsArray = [[NSMutableArray alloc] init];
    
    for(LeapHand* hand in hands)
    {
        NSDictionary* handDictionary =  [self leapHandToDictionary:hand];
        [handsArray addObject:handDictionary];
    }
    
    return handsArray;
}


-(NSArray*) leapPointablesToQCCompatibleArray:(const NSArray*)pointables
{
    NSMutableArray* fingersArray = [[NSMutableArray alloc] init];
    
    for(LeapPointable* pointable in pointables)
    {
        NSDictionary* fingerDictionary =  [self leapPointableToDictionary:pointable];
        [fingersArray addObject:fingerDictionary];
    }
    
    return fingersArray;
}

/**
 * Based on the configuration of this instances properties, returns YES or NO depeding on whether
 * user code wishes each type of gesture to be included in the ouput
 */
-(BOOL)shouldIncludeGestureInArray:(LeapGesture*)gesture
{
    switch(gesture.type)
    {
        case LEAP_GESTURE_TYPE_CIRCLE:
        {
            return _includeGestureCircle;
        }
        case LEAP_GESTURE_TYPE_KEY_TAP:
        {
            return _includeGestureKeyTap;
        }
        case LEAP_GESTURE_TYPE_SCREEN_TAP:
        {
            return _includeGestureScreenTap;
        }
        case LEAP_GESTURE_TYPE_SWIPE:
        {
            return _includeGestureSwipe;
        }
        case LEAP_GESTURE_TYPE_INVALID:
        {
            return NO;
        }
    }

    return NO;

}




-(void) processLeapGestures:(const NSArray*)gestures
{
    //we need to create arrays to hold the different type of gestures
    //since we need to expose each type of gesture to the correct ouputPort
    NSMutableArray* swipeArray = [[NSMutableArray alloc] init];
    NSMutableArray* circleArray = [[NSMutableArray alloc] init];
    NSMutableArray* keyTapArray = [[NSMutableArray alloc] init];
    NSMutableArray* screenTapArray = [[NSMutableArray alloc] init];

    //Set instance properties
    _frameGestureSwipes = swipeArray;
    _frameGestureCircles = circleArray;
    _frameGestureScreenTaps = screenTapArray;
    _frameGestureKeyTaps = keyTapArray;

    
    for(LeapGesture* gesture in gestures)
    {
        //Only include this gesture if user code has told us it wants it.
        //*see inputPorts for more info about how this helper is used.
        if ([self shouldIncludeGestureInArray:gesture])
        {
            //create a leap compatible dictionary to add to an array
            NSDictionary* gestureDictionary =  [self leapGestureToDictionary:gesture];
            
            //Now we need to decide which array to put this gesture in
            switch(gesture.type)
            {
                case LEAP_GESTURE_TYPE_CIRCLE:
                {
                    [circleArray addObject:gestureDictionary];
                }
                case LEAP_GESTURE_TYPE_KEY_TAP:
                {
                    [keyTapArray addObject:gestureDictionary];
                }
                case LEAP_GESTURE_TYPE_SCREEN_TAP:
                {
                    [screenTapArray addObject:gestureDictionary];
                }
                case LEAP_GESTURE_TYPE_SWIPE:
                {
                    [swipeArray addObject:gestureDictionary];
                }
                case LEAP_GESTURE_TYPE_INVALID:
                {
                    NSLog(@"Invalid type of gesture");
                }
            }
            
        }
        
    }
    
}


#pragma mark -
#pragma mark Vector stuff


-(id)leapVectorToQCCompatibleType:(const LeapVector*)vector
{
    if (_outputVectorsAsDictionaries)
    {
        return [self leapVectorToDictionary:vector];
    }
    else
    {
        return [self leapVectorToArray:vector];
    }
}


-(NSArray*) leapVectorToArray:(const LeapVector*)vector
{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    
    
    [array addObject:[[NSNumber alloc] initWithFloat:vector.x]];
    [array addObject:[[NSNumber alloc] initWithFloat:vector.y]];
    [array addObject:[[NSNumber alloc] initWithFloat:vector.z]];
    
    if (_outputYawPitchRoll)
    {
        [array addObject:[[NSNumber alloc] initWithFloat:vector.yaw]];
        [array addObject:[[NSNumber alloc] initWithFloat:vector.pitch]];
        [array addObject:[[NSNumber alloc] initWithFloat:vector.roll]];


    }
    
    return array;
}


-(NSDictionary*) leapVectorToDictionary:(const LeapVector*)vector
{
    NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] init];
    
    [dictionary setObject:[[NSNumber alloc] initWithFloat:vector.x] forKey:@"x"];
    [dictionary setObject:[[NSNumber alloc] initWithFloat:vector.y] forKey:@"y"];
    [dictionary setObject:[[NSNumber alloc] initWithFloat:vector.z] forKey:@"z"];
    
    if (_outputYawPitchRoll)
    {
        [dictionary setObject:[[NSNumber alloc] initWithFloat:vector.yaw] forKey:@"yaw"];
        [dictionary setObject:[[NSNumber alloc] initWithFloat:vector.pitch] forKey:@"pitch"];
        [dictionary setObject:[[NSNumber alloc] initWithFloat:vector.roll] forKey:@"roll"];

    }
    
    
    return dictionary;
}

@end
