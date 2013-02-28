//
//  AppDelegate.h
//  LeapStandaloneTest
//
//  Created by chris on 28/02/2013.
//  Copyright (c) 2013 Chris Birch. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LeapObjectiveC.h"

@interface AppDelegate : NSObject <NSApplicationDelegate,LeapListener>

@property (assign) IBOutlet NSWindow *window;

@end
