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

//Dictates the type of QC compativle construct used to represent vectors
#define INPUT_USEDICTIONARIESTOREPRESENTVECTORS @"inputUseDictionariesToRepresentVectors"
//Dictates whether or not vectors include yaw pitch and roll
#define INPUT_VECTORSINCLUDEYAWPITCHROLL @"inputVectorsIncludeYawPitchRoll"
//Information about the frame
#define OUTPUT_FRAME @"outputFrame"
//Array of Hand structures
#define OUTPUT_HANDS @"outputHands"
//Array of Finger structures
#define OUTPUT_FINGERS @"outputFingers"
//Dictates whether or not frame object is created
#define INPUT_RETURNFRAME @"inputReturnFrame"


//Port Properties

@property (assign) BOOL inputUseDictionariesToRepresentVectors;
@property (assign) BOOL inputVectorsIncludeYawPitchRoll;
@property (copy) NSDictionary* outputFrame;
@property (copy) NSArray* outputHands;
@property (copy) NSArray* outputFingers;
@property (assign) BOOL inputReturnFrame;


@end
