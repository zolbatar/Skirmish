//
//  SKWorld.h
//  Skirmish
//
//  Created by Daryl on 21/01/2008.
//  Copyright 2008 Daryl Dudey. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <OpenGL/gl.h>
#import <OpenGL/glu.h>
#import "SKMathPerlin.h"
#import "SKMathVector.h"

#define WIREFRAME
#define cMapSize 256
#define cTotalMapDimension 6.0f
#define cMapTileSize (cTotalMapDimension / (GLfloat)cMapSize)
#define cMapShift (-cTotalMapDimension / 2.0f)
#define cPerlinOctaves		4
#define cPerlinFrequency	0.05f
#define cPerlinPersistence	0.2f

@interface SKWorld : NSObject 
{
	
	// Map
	CGFloat map[cMapSize][cMapSize];
	GLuint mapList;
	GLfloat rtri;
}

#pragma mark Setup
- (void)setupLights;
- (void)setupMap;

#pragma mark Animate & Render
- (void)animate:(CGFloat)animationTicks;
- (void)render;

@end
