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


//Port Defines
//Port Defines

//Yes if hands array is exposed to QC
#define INPUT_RETRIEVEHANDS @"inputRetrieveHands"
//Yes if fingers array is exposed to QC
#define INPUT_RETRIEVEFINGERS @"inputRetrieveFingers"
//Yes if tools array is exposed to QC
#define INPUT_RETRIEVETOOLS @"inputRetrieveTools"
//Yes if pointables array is exposed to QC
#define INPUT_RETRIEVEPOINTABLES @"inputRetrievePointables"
//Yes if fingers array is exposed in hand structure
#define INPUT_INCLUDEFINGERSINHAND @"inputIncludeFingersInHand"
//Yes if tools array is exposed in hand structure
#define INPUT_INCLUDETOOLSINHAND @"inputIncludeToolsInHand"
//Yes if pointables array is exposed in hand structure
#define INPUT_INCLUDEPOINTABLESINHAND @"inputIncludePointablesInHand"
//Dictates the type of QC compativle construct used to represent vectors
#define INPUT_USEDICTIONARIESTOREPRESENTVECTORS @"inputUseDictionariesToRepresentVectors"
//Dictates whether or not vectors include yaw pitch and roll
#define INPUT_VECTORSINCLUDEYAWPITCHROLL @"inputVectorsIncludeYawPitchRoll"
//Yes if Swipe gestures are exposed to QC
#define INPUT_RETRIEVEGESTURESWIPE @"inputRetrieveGestureSwipe"
//Yes if Screen Tap gestures are exposed to QC
#define INPUT_RETRIEVEGESTURESCREENTAP @"inputRetrieveGestureScreenTap"
//Yes if Key Tap gestures are exposed to QC
#define INPUT_RETRIEVEGESTUREKEYTAP @"inputRetrieveGestureKeyTap"
//Yes if circle gestures are exposed to QC
#define INPUT_RETRIEVEGESTURECIRCLE @"inputRetrieveGestureCircle"
//Array of Hand structures
#define OUTPUT_HANDS @"outputHands"
//Array of Finger structures
#define OUTPUT_FINGERS @"outputFingers"
//Array of tools
#define OUTPUT_TOOLS @"outputTools"
//Array of pointables
#define OUTPUT_POINTABLES @"outputPointables"
//Information about the frame
#define OUTPUT_FRAME @"outputFrame"
//Exposes the screens as a QC array
#define OUTPUT_SCREENS @"outputScreens"
//Information about the Swipe gestures
#define OUTPUT_GESTURESWIPES @"outputGestureSwipes"
//Information about the Screen Tap gestures
#define OUTPUT_GESTURESCREENTAPS @"outputGestureScreenTaps"
//Information about the Key Tap gestures
#define OUTPUT_GESTUREKEYTAPS @"outputGestureKeyTaps"
//Information about the Circle gestures
#define OUTPUT_GESTURECIRCLES @"outputGestureCircles"
//The number of the calibrated screen to use
#define INPUT_LEAPSCREEN @"inputLeapScreen"







//Port Properties

@property (assign) BOOL inputRetrieveHands;
@property (assign) BOOL inputRetrieveFingers;
@property (assign) BOOL inputRetrieveTools;
@property (assign) BOOL inputRetrievePointables;
@property (assign) BOOL inputIncludeFingersInHand;
@property (assign) BOOL inputIncludeToolsInHand;
@property (assign) BOOL inputIncludePointablesInHand;
@property (assign) BOOL inputUseDictionariesToRepresentVectors;
@property (assign) BOOL inputVectorsIncludeYawPitchRoll;
@property (assign) BOOL inputRetrieveGestureSwipe;
@property (assign) BOOL inputRetrieveGestureScreenTap;
@property (assign) BOOL inputRetrieveGestureKeyTap;
@property (assign) BOOL inputRetrieveGestureCircle;
@property (assign) NSArray* outputHands;
@property (assign) NSArray* outputFingers;
@property (assign) NSArray* outputTools;
@property (assign) NSArray* outputPointables;
@property (assign) NSDictionary* outputFrame;
@property (assign) NSArray* outputScreens;
@property (assign) NSArray* outputGestureSwipes;
@property (assign) NSArray* outputGestureScreenTaps;
@property (assign) NSArray* outputGestureKeyTaps;
@property (assign) NSArray* outputGestureCircles;
@property (assign) NSUInteger inputLeapScreen;




//Settings view

@property(copy) NSNumber* useScreenCoordinates;

@end
