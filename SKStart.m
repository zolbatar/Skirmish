//
//  SKStart.m
//  Skirmish
//
//  Created by Daryl on 20/01/2008.
//  Copyright 2008 Daryl Dudey. All rights reserved.
//

#import "SKStart.h"

@implementation SKStart

#pragma mark Alloc
- (id)init 
{
	self = [super init];
	
	// Events
	shouldQuit = NO;
	
	// Set animation timer
	animationTimer = [NSTimer scheduledTimerWithTimeInterval:0.01
													  target:self
													selector:@selector(animationTimerRedrawEvent:)
													userInfo:nil
													 repeats:YES];
	
	return self;
}

- (void)finalize 
{
	[animationTimer invalidate];
	[super finalize];
}

#pragma mark -
#pragma mark NSApplication Overrides
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification 
{
	NSLog(@"SKStart: Application finished launching.");
//	[glView enterFullScreen];										// Full screen
	[self gameLoop];												// Init and enter game loop
}

- (void)applicationWillTerminate:(NSNotification *)notification 
{
	NSLog(@"SKStart: Application exiting.");
//	[glView exitFullScreen];										// Leave full screen mode
	[[self window] orderOut:self];									// Close window
}

#pragma mark -
#pragma mark Game Loop
- (void)animationTimerRedrawEvent:(NSTimer*)aTimer 
{
	animationCount++;
}

- (void)gameLoop 
{
	NSLog(@"SKStart: Game loop");
	
	[glView initRender];											// Setup OpenGL
	world = [SKWorld new];											// Create world
	[glView setWorld:world];										// Point OpenGL view to world for rendering
	animationCount = 0.0f;											// Clear animation timer

	do																// Main loop, runs until quit is requested
	{
		// Process any waiting events
		NSEvent *event;
		while (event = [NSApp nextEventMatchingMask:NSAnyEventMask
										  untilDate:nil
											 inMode:NSDefaultRunLoopMode 
											dequeue:YES]) 
		{
			switch ([event type]) 
			{
				case NSKeyDown:
					[self keyDown:event];
					break;
				case NSKeyUp:
					[self keyUp:event];
					break;
				case NSLeftMouseDown:
					[self mouseDown:event];
					break;
				case NSLeftMouseUp:
					[self mouseUp:event];
					break;
				case NSMouseMoved:
					[self mouseMoved:event];
					break;
				case NSScrollWheel:
					[self scrollWheel:event];
					break;
			}
		}
		
		// Animate
		if (animationCount > 0.0f) 
		{
			[world animate:animationCount];
			animationCount = 0.0f;									// Clear animation timer
			[glView setNeedsDisplay:YES];							// Now render
		}
		
	} while(!shouldQuit);
	
	[NSApp terminate:self];											// Terminate application
}

#pragma mark -
#pragma mark Events & Input
- (void)setToQuit 
{
	NSLog(@"SKStart: Quit requested.");
	shouldQuit = YES;
}

- (void)keyDown:(NSEvent *)theEvent 
{
	NSString *chars = [theEvent charactersIgnoringModifiers];
	if ([chars length] == 1) {
		unichar keyChar = [chars characterAtIndex:0];
		switch (keyChar) 
		{
			case 27:
				[self setToQuit];
				break;
		}
	}
}

@end
