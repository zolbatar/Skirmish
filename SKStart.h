//
//  SKStart.h
//  Skirmish
//
//  Created by Daryl on 20/01/2008.
//  Copyright 2008 Daryl Dudey. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SKOpenGLView.h"
#import "SKWorld.h"

@interface SKStart : NSWindowController 
{

	// Display
	IBOutlet SKOpenGLView *glView;
	
	// Animation
	CGFloat animationCount;
	NSTimer *animationTimer;
	
	// Events
	BOOL shouldQuit;
	
	// The world and objects within
	SKWorld *world;
}

#pragma mark Game Loop
- (void)gameLoop;

#pragma mark Events & Input
- (void)setToQuit;

@end
