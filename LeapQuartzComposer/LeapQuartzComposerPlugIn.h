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

/**
 * QC ouput containing Leap frame dictionary.
 */
@property (copy) NSDictionary* outputFrame;

@end
