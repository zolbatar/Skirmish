//
//  SKOpenGLView.h
//  Skirmish
//
//  Created by Daryl on 20/01/2008.
//  Copyright 2008 Daryl Dudey. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <OpenGL/gl.h>
#import <OpenGL/glu.h>
#import "SKWorld.h"

@interface SKOpenGLView : NSOpenGLView 
{
	SKWorld *world;
}
@property (assign)SKWorld *world;

#pragma mark Full Screen
- (void)enterFullScreen;
- (void)exitFullScreen;

#pragma mark Render
- (void)initRender;

@end
