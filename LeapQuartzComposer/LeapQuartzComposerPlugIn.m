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


#define	kQCPlugIn_Name				@"LeapQuartzComposer"
#define	kQCPlugIn_Description		@"A Simple plugin to expose Leap data to Quartz Composer"

@interface LeapQuartzComposerPlugIn ()
{
    LeapController* leapController;
}

@end

@implementation LeapQuartzComposerPlugIn

@dynamic outputFrame;




+ (NSDictionary *)attributes
{
	// Return a dictionary of attributes describing the plug-in (QCPlugInAttributeNameKey, QCPlugInAttributeDescriptionKey...).
    return @{QCPlugInAttributeNameKey:kQCPlugIn_Name, QCPlugInAttributeDescriptionKey:kQCPlugIn_Description};
}

+ (NSDictionary *)attributesForPropertyPortWithKey:(NSString *)key
{
	// Specify the optional attributes for property based ports (QCPortAttributeNameKey, QCPortAttributeDefaultValueKey...).
	return nil;
}

+ (QCPlugInExecutionMode)executionMode
{
	return kQCPlugInExecutionModeProcessor;
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

        //Create the leap controller
        leapController = [[LeapController alloc] initWithDelegate:self];
        
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
    // Get the most recent frame and report some basic information
    LeapFrame* frame = [aController frame:0];
   
    NSDictionary* qcCompatibleFrameDictionary = [LeapQCHelper leapFrameToDictionary:frame];
    
    self.outputFrame = qcCompatibleFrameDictionary;
    
    
    NSLog(@"%@",qcCompatibleFrameDictionary);
    
    
}



@end

@implementation LeapQuartzComposerPlugIn (Execution)

- (BOOL)startExecution:(id <QCPlugInContext>)context
{
	// Called by Quartz Composer when rendering of the composition starts: perform any required setup for the plug-in.
	// Return NO in case of fatal failure (this will prevent rendering of the composition to start).
	
	return YES;
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
