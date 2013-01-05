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


+(NSArray*) leapHandsToQCCompatibleArray:(const NSArray*)hands
{
    NSMutableArray* handsArray = [[NSMutableArray alloc] init];
    
    for(LeapHand* hand in hands)
    {
        NSDictionary* handDictionary =  [LeapQCHelper leapHandToDictionary:hand];
        [handsArray addObject:handDictionary];
    }
    
    return handsArray;
}


+(NSArray*) leapFingersToQCCompatibleArray:(const NSArray*)fingers
{
    NSMutableArray* fingersArray = [[NSMutableArray alloc] init];
    
    for(LeapFinger* finger in fingers)
    {
        NSDictionary* fingerDictionary =  [LeapQCHelper leapPointableToDictionary:finger];
        [fingersArray addObject:fingerDictionary];
    }
    
    return fingersArray;
}

+(NSDictionary*) leapFrameToDictionary:(const LeapFrame*)frame
{
    NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] init];
    
    [dictionary setObject:[[NSNumber alloc] initWithLongLong:frame.id] forKey:LEAP_ID];
    [dictionary setObject:[[NSNumber alloc] initWithLongLong:frame.timestamp] forKey:@"timestamp"];
    
    if (frame.hands)
    {
        //get an array containing the hand dictionaries
        NSArray* qcHands = [LeapQCHelper leapHandsToQCCompatibleArray:frame.hands];
        [dictionary setObject:qcHands forKey:LEAP_HANDS];
    }
    
    if (frame.fingers)
    {
        //get an array containing the finger dictionaries
        NSArray* qcFingers = [LeapQCHelper leapFingersToQCCompatibleArray:frame.fingers];
        [dictionary setObject:qcFingers forKey:LEAP_FINGERS];
    }
    
    if (frame.pointables)
    {
        //get an array containing the pointables dictionaries
        NSArray* qcPointables = [LeapQCHelper leapFingersToQCCompatibleArray:frame.pointables];
        [dictionary setObject:qcPointables forKey:LEAP_POINTABLES];
    }

    if (frame.tools)
    {
        //get an array containing the tools dictionaries
        NSArray* qcTools = [LeapQCHelper leapFingersToQCCompatibleArray:frame.tools];
        [dictionary setObject:qcTools forKey:LEAP_TOOLS];
    }
    
    
    return dictionary;
    
}

+(NSDictionary*) leapHandToDictionary:(const LeapHand*)hand
{
    NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] init];
    
    [dictionary setObject:[[NSNumber alloc] initWithInteger:hand.id] forKey:LEAP_ID];
    
    if (hand.fingers)
    {
        //get an array containing the finger dictionaries
        NSArray* qcFingers = [LeapQCHelper leapFingersToQCCompatibleArray:hand.fingers];
        [dictionary setObject:qcFingers forKey:LEAP_FINGERS];
    }
    
    //The following things may or may not exist so we need to test for each one before sending it
    //otherwise these things will be wrongly reported as being 0
    
    //Make sure the hand has a palm ray
    if (hand.palmPosition)
    {
        [dictionary setObject:[LeapQCHelper leapVectorToDictionary: hand.palmPosition] forKey:@"palmPosition"];
    }
    //make sure it has a velocity vector
    if(hand.palmVelocity)
    {
        [dictionary setObject:[LeapQCHelper leapVectorToDictionary:hand.palmVelocity] forKey:@"palmVelocity"];
    }
    //make sure it has a normal vector
    if(hand.palmNormal)
        [dictionary setObject:[LeapQCHelper leapVectorToDictionary:hand.palmNormal] forKey:@"palmNormal"];
    
    
    if(hand.direction)
    {
        [dictionary setObject:[LeapQCHelper leapVectorToDictionary:hand.direction] forKey:@"direction"];
    }
    
    if(hand.sphereCenter)
    {
        [dictionary setObject:[LeapQCHelper leapVectorToDictionary:hand.sphereCenter] forKey:@"sphereCenter"];
    }
    

    [dictionary setObject:[NSNumber numberWithFloat:hand.sphereRadius] forKey:@"sphereRadius"];
    [dictionary setObject:[NSNumber numberWithBool:hand.isValid] forKey:@"isValid"];
    
    
    return dictionary;
}

+(NSDictionary*) leapPointableToDictionary:(const LeapPointable*)pointable
{
    NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] init];
    
    [dictionary setObject:[[NSNumber alloc] initWithInteger:pointable.id] forKey:LEAP_ID];
    
    
    if(pointable.tipPosition)
    {
        [dictionary setObject:[LeapQCHelper leapVectorToDictionary:pointable.tipPosition] forKey:@"tipPosition"];
    }
    
    if(pointable.tipVelocity)
    {
        [dictionary setObject:[LeapQCHelper leapVectorToDictionary:pointable.tipVelocity] forKey:@"tipVelocity"];
    }
    
    if(pointable.direction)
    {
        [dictionary setObject:[LeapQCHelper leapVectorToDictionary:pointable.direction] forKey:@"direction"];
    }
    
    [dictionary setObject:[[NSNumber alloc] initWithFloat:pointable.width] forKey:@"width"];
    [dictionary setObject:[[NSNumber alloc] initWithFloat:pointable.length] forKey:@"length"];
    
    [dictionary setObject:[[NSNumber alloc] initWithBool:pointable.isFinger] forKey:@"isFinger"];
    [dictionary setObject:[[NSNumber alloc] initWithBool:pointable.isTool] forKey:@"isTool"];
    [dictionary setObject:[[NSNumber alloc] initWithBool:pointable.isValid] forKey:@"isValid"];
    
    
    return dictionary;
}


+(NSDictionary*) leapVectorToDictionary:(const LeapVector*)vector
{
    NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] init];
    
    [dictionary setObject:[[NSNumber alloc] initWithFloat:vector.x] forKey:@"x"];
    [dictionary setObject:[[NSNumber alloc] initWithFloat:vector.y] forKey:@"y"];
    [dictionary setObject:[[NSNumber alloc] initWithFloat:vector.z] forKey:@"z"];
    
    //TODO: maybe add some flag to decide whether the pitch, yaw and roll should be exposed
    //(most of the time probably wont be needed and we incur extra processing needlessly)
    [dictionary setObject:[[NSNumber alloc] initWithFloat:vector.pitch] forKey:@"pitch"];
    [dictionary setObject:[[NSNumber alloc] initWithFloat:vector.roll] forKey:@"roll"];
    [dictionary setObject:[[NSNumber alloc] initWithFloat:vector.yaw] forKey:@"yaw"];
    
    
    return dictionary;
}

@end
