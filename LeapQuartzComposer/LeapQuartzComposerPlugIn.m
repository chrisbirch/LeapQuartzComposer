//
//  LeapQuartzComposerPlugIn.m
//  LeapQuartzComposer
//
//  Created by chris on 05/01/2013.
//  Copyright (c) 2013 Chris Birch. All rights reserved.
//

// It's highly recommended to use CGL macros instead of changing the current context for plug-ins that perform OpenGL rendering
#import <OpenGL/CGLMacro.h>

#import "LeapQuartzComposerPlugIn.h"
#import "LeapQCHelper.h"


#define	kQCPlugIn_Name				@"Leap Device Interface"
#define	kQCPlugIn_Description		@"Version: 0.11\nAllows QC compositions to access data returned by Leap Motion devices"
#define kQCPlugIn_AuthorDescription @"© 2013 by Chris Birch, all rights reserved."

@interface LeapQuartzComposerPlugIn ()
{
    LeapController* leapController;
    LeapQCHelper *helper;
}

@end

@implementation LeapQuartzComposerPlugIn


//Port Synthesizes

@dynamic inputUseDictionariesToRepresentVectors;
@dynamic inputVectorsIncludeYawPitchRoll;
@dynamic outputFrame;
@dynamic outputHands;
@dynamic outputFingers;
@dynamic inputReturnFrame;

+ (NSDictionary *)attributes
{
	// Return a dictionary of attributes describing the plug-in (QCPlugInAttributeNameKey, QCPlugInAttributeDescriptionKey...).
    return @{
                QCPlugInAttributeNameKey:kQCPlugIn_Name,
                QCPlugInAttributeDescriptionKey:kQCPlugIn_Description,
                QCPlugInAttributeCopyrightKey: kQCPlugIn_AuthorDescription
    
            };
}

+ (NSDictionary *)attributesForPropertyPortWithKey:(NSString *)key
{
	// Specify the optional attributes for property based ports (QCPortAttributeNameKey, QCPortAttributeDefaultValueKey...).
    
    //Port Attributes
    
    //Dictates the type of QC compativle construct used to represent vectors
    if([key isEqualToString:INPUT_USEDICTIONARIESTOREPRESENTVECTORS])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                @"Use dictionaries to represent vectors", QCPortAttributeNameKey,
                [NSNumber numberWithBool:YES], QCPortAttributeDefaultValueKey,
                nil];
    //Dictates whether or not vectors include yaw pitch and roll
    else if([key isEqualToString:INPUT_VECTORSINCLUDEYAWPITCHROLL])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                @"Vectors include Yaw Pitch Roll", QCPortAttributeNameKey,
                [NSNumber numberWithBool:YES], QCPortAttributeDefaultValueKey,
                nil];
    //Information about the frame
    else if([key isEqualToString:OUTPUT_FRAME])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                @"Frame", QCPortAttributeNameKey,
                nil];
    //Array of Hand structures
    else if([key isEqualToString:OUTPUT_HANDS])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                @"Hands", QCPortAttributeNameKey,
                nil];
    //Array of Finger structures
    else if([key isEqualToString:OUTPUT_FINGERS])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                @"Fingers", QCPortAttributeNameKey,
                nil];
    //Dictates whether or not frame object is created
    else if([key isEqualToString:INPUT_RETURNFRAME])
        return [NSDictionary dictionaryWithObjectsAndKeys:
                @"Should Return Frame", QCPortAttributeNameKey,
                [NSNumber numberWithBool:YES], QCPortAttributeDefaultValueKey,
                nil];
    
    return nil;
}

+ (QCPlugInExecutionMode)executionMode
{
	return kQCPlugInExecutionModeProvider;
}

+ (QCPlugInTimeMode)timeMode
{
	return kQCPlugInTimeModeIdle;
}

- (id)init
{
	self = [super init];
	if (self)
    {

        helper = [[LeapQCHelper alloc] init];
        
        //set up helper
        helper.outputVectorsAsDictionaries = YES;
        helper.outputYawPitchRoll = YES;
        
	}
	
	return self;
}







#pragma mark - SampleDelegate Callbacks

- (void)onInit:(LeapController*)aController
{
    NSLog(@"Initialized");
}

- (void)onConnect:(LeapController*)aController
{
    NSLog(@"Connected");
}

- (void)onDisconnect:(LeapController*)aController
{
    NSLog(@"Disconnected");
}

- (void)onFrame:(LeapController*)aController
{
      
    
}



@end

@implementation LeapQuartzComposerPlugIn (Execution)

- (BOOL)startExecution:(id <QCPlugInContext>)context
{
	// Called by Quartz Composer when rendering of the composition starts: perform any required setup for the plug-in.
	// Return NO in case of fatal failure (this will prevent rendering of the composition to start).
	
    //Create the leap controller
    leapController = [[LeapController alloc] initWithDelegate:self];
    
    
	return leapController != nil;
}

- (void)enableExecution:(id <QCPlugInContext>)context
{
	// Called by Quartz Composer when the plug-in instance starts being used by Quartz Composer.
}

- (BOOL)execute:(id <QCPlugInContext>)context atTime:(NSTimeInterval)time withArguments:(NSDictionary *)arguments
{
	/*
	Called by Quartz Composer whenever the plug-in instance needs to execute.
	Only read from the plug-in inputs and produce a result (by writing to the plug-in outputs or rendering to the destination OpenGL context) within that method and nowhere else.
	Return NO in case of failure during the execution (this will prevent rendering of the current frame to complete).
	
	The OpenGL context for rendering can be accessed and defined for CGL macros using:
	CGLContextObj cgl_ctx = [context CGLContextObj];
	*/
    
    //Port Value Changed code
    
    //Dictates the type of QC compativle construct used to represent vectors
    if ([self didValueForInputKeyChange:INPUT_USEDICTIONARIESTOREPRESENTVECTORS])
    {
        helper.outputVectorsAsDictionaries = self.inputUseDictionariesToRepresentVectors;
    }
    //Dictates whether or not vectors include yaw pitch and roll
    if ([self didValueForInputKeyChange:INPUT_VECTORSINCLUDEYAWPITCHROLL])
    {
        helper.outputYawPitchRoll = self.inputVectorsIncludeYawPitchRoll;
    }

    
    // Get the most recent frame and report some basic information
    LeapFrame* frame = [leapController frame:0];
    
    NSDictionary* qcDict=nil;
    
    
    //Only generate the full frame dictionary if we are being asked for it
    if (self.inputReturnFrame)
    {
        qcDict = [helper leapFrameToDictionary:frame];

        self.outputFrame = qcDict;
    }
    else
    {
        self.outputHands = [helper leapHandsToQCCompatibleArray:frame.hands];
        self.outputFingers = [helper leapFingersToQCCompatibleArray:frame.fingers];
    }
    
    //NSLog(@"%@",qcCompatibleFrameDictionary);

	
	return YES;
}

- (void)disableExecution:(id <QCPlugInContext>)context
{
	// Called by Quartz Composer when the plug-in instance stops being used by Quartz Composer.
}

- (void)stopExecution:(id <QCPlugInContext>)context
{
	// Called by Quartz Composer when rendering of the composition stops: perform any required cleanup for the plug-in.
    
}

@end
