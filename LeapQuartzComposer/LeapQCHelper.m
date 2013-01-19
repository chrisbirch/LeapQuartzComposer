//
//  LeapQCHelper.m
//  LeapQuartzComposer
//
//  Created by chris on 05/01/2013.
//  Copyright (c) 2013 Chris Birch. All rights reserved.
//

#import "LeapQCHelper.h"
#import "LeapObjectiveC.h"

@interface LeapQCHelper ()
{
    
}

/**
 * Returns an array filled with NSDictionary representations of LeapFingers
 */
+(NSArray*) leapFingersToQCCompatibleArray:(const NSArray*)fingers;

/**
 * Returns an array filled with NSDictionary representations of LeapHands
 */
+(NSArray*) leapHandsToQCCompatibleArray:(const NSArray*)hands;


@end

@implementation LeapQCHelper


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
