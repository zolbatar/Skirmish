//
//  SKOpenGLView.m
//  Skirmish
//
//  Created by Daryl on 20/01/2008.
//  Copyright 2008 Daryl Dudey. All rights reserved.
//

#import "SKOpenGLView.h"

@implementation SKOpenGLView

@synthesize world;

#pragma mark Full Screen
- (void)enterFullScreen 
{
	[self enterFullScreenMode:[NSScreen mainScreen] withOptions:nil];
	NSLog(@"SKOpenGLView: Entered full screen mode.");
}

- (void)exitFullScreen 
{
	[self exitFullScreenModeWithOptions: nil];
	NSLog(@"SKOpenGLView: Exited full screen mode.");
}

#pragma mark Render
- (void)initRender 
{
	NSLog(@"SKOpenGLView: Init renderer.");
	NSRect sceneBounds;

	// Get size of context
	[[self openGLContext] update];
	sceneBounds = [self bounds];
	NSLog(@"SKOpenGLView: %ld x %ld pixels.", (long)sceneBounds.size.width, (long)sceneBounds.size.height);
	
	// Reset current viewport
	glViewport(0, 0, sceneBounds.size.width, sceneBounds.size.height);

	// Projection matrix
	glMatrixMode(GL_PROJECTION);									// Select the projection matrix
	glLoadIdentity();												// And reset it
	gluPerspective(45.0f, sceneBounds.size.width / sceneBounds.size.height,
                   0.1f, 100.0f);

	// Modelview matrix
	glMatrixMode(GL_MODELVIEW);										// Select the modelview matrix
/*	gluLookAt(0.0f, 0.0f, 5.0f, 
			  0.0f, 0.0f, 0.0f, 
			  0.0f, 1.0f, 0.0f);									// Point to look at */
	glLoadIdentity();												// and reset it

	// Set some rendering parameters
	glShadeModel(GL_SMOOTH);										// Enable smooth shading
	glClearColor(0.0f, 0.0f, 0.0f, 0.0f);							// Black background

	// Enable depth testing
	glClearDepth(1.0f);												// Depth buffer setup
	glEnable(GL_DEPTH_TEST);
	glDepthFunc(GL_LEQUAL);											// Type of depth test to do
	glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST);				// Really nice perspective calculations

	// Smooth lines
	glEnable(GL_LINE_SMOOTH);
	glEnable(GL_BLEND);
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
	glHint(GL_LINE_SMOOTH_HINT, GL_DONT_CARE);
}

- (void)drawRect: (NSRect)bounds
{
	// Clear background and depth buffer
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);				
	
	// Render world
	[world render];

	// Flush, we're finished!
	[[self openGLContext] flushBuffer];
}

@end
