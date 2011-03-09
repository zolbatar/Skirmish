//
//  SKWorld.m
//  Skirmish
//
//  Created by Daryl on 21/01/2008.
//  Copyright 2008 Daryl Dudey. All rights reserved.
//

#import "SKWorld.h"

@implementation SKWorld

#pragma mark Alloc
- (id)init 
{
	self = [super init];
	[self setupLights];
	[self setupMap];
	return self;
}

#pragma mark -
#pragma mark Setup
GLfloat LightAmbient[]= { 0.5f, 0.5f, 0.5f, 1.0f };
GLfloat LightDiffuse[]= { 1.0f, 1.0f, 1.0f, 1.0f };
GLfloat LightPosition[]= { 0.0f, 0.0f, 2.0f, 1.0f };

- (void)setupLights 
{
	glLightfv(GL_LIGHT1, GL_AMBIENT, LightAmbient);					// Ambient light
	glLightfv(GL_LIGHT1, GL_DIFFUSE, LightDiffuse);					// Diffuse light
	glLightfv(GL_LIGHT1, GL_POSITION,LightPosition);				// Position light
	glEnable(GL_LIGHT1);											// And enable the light
//	glEnable(GL_LIGHTING);
}

- (void)setupMap 
{
	NSLog(@"SKWorld: Setup map.");

	// Reset position, scale etc.
	rtri = 0.0f;

	// Render landscape
	SKMathPerlin *perlin = [SKMathPerlin new];
	[perlin setOctaves:cPerlinOctaves];
	[perlin setFrequency:cPerlinFrequency];
	[perlin setPersistence:cPerlinPersistence];
	NSUInteger x, z;
	for (x = 0; x < cMapSize; x++) 
	{
		for (z = 0; z < cMapSize; z++) 
		{
			map[x][z] = [perlin perlinNoise2DX:x Y:z];
		}
	}
	
	// Create display list
	mapList = glGenLists(1);
	glNewList(mapList, GL_COMPILE);
			
#ifdef WIREFRAME
    glBegin(GL_LINES);
	glColor3f(1.0f, 1.0f, 1.0f);							// Show all lines as white

	// Horizontal & Diagonal
	for (x = 0; x < cMapSize - 1; x++) 
	{
		for (z = 0; z < cMapSize; z++) 
		{
			glVertex3f(cMapTileSize * x + cMapShift,		map[x][z],			cMapTileSize * z + cMapShift);
			glVertex3f(cMapTileSize * (x + 1) + cMapShift,	map[x + 1][z],		cMapTileSize * z + cMapShift);
//			glVertex3f(cMapTileSize * x + cMapShift,		map[x][z],			cMapTileSize * z + cMapShift);
//			glVertex3f(cMapTileSize * (x + 1) + cMapShift,	map[x + 1][z + 1],	cMapTileSize * (z + 1) + cMapShift);
		}
	}

	// Vertical
	for (x = 0; x < cMapSize; x++) 
	{
		for (z = 0; z < cMapSize - 1; z++) 
		{
			glVertex3f(cMapTileSize * x + cMapShift,		map[x][z],			cMapTileSize * z + cMapShift);
			glVertex3f(cMapTileSize * x + cMapShift,		map[x][z + 1],		cMapTileSize * (z + 1) + cMapShift);
		}
	}
			
#else
    glBegin(GL_TRIANGLES);
	for (i = 0; i < cMapSize - 1; i++) 
	{
		for (j = 0; j < cMapSize - 1; j++) 
		{

			// Triangle 1
//			if (i == 0 && j == 0)
//				glColor3f(1.0f, 1.0f, 1.0f);
//			else
				glColor3f(1.0f, 0.0f, 0.0f);
			glVertex3f(cMapTileSize * i + cMapShift,		map[i][j],			cMapTileSize * j + cMapShift);
			glVertex3f(cMapTileSize * (i + 1) + cMapShift,	map[i + 1][j],		cMapTileSize * j + cMapShift);
			glVertex3f(cMapTileSize * (i + 1) + cMapShift,	map[i + 1][j + 1],	cMapTileSize * (j + 1) + cMapShift);
			
			// Triangle 2
			glColor3f(1.0f, 0.0f, 0.0f);
			glVertex3f(cMapTileSize * i + cMapShift,		map[i][j],			cMapTileSize * j  + cMapShift);
			glVertex3f(cMapTileSize * i + cMapShift,		map[i][j + 1],		cMapTileSize * (j + 1) + cMapShift);
			glVertex3f(cMapTileSize * (i + 1) + cMapShift,	map[i + 1][j + 1],	cMapTileSize * (j + 1 ) + cMapShift);
			
		}
	}
#endif

    glEnd();
	glEndList();
}

#pragma mark -
#pragma mark Animate & Render
- (void)animate:(CGFloat)animationTicks 
{
	rtri += 0.1f * animationTicks;
}

- (void)render 
{
	glLoadIdentity();
	glTranslatef(0.0f, -1.0f, -6.0f);								
	glRotatef(rtri, 0.0f, 1.0f, 0.0f);
	glCallList(mapList);	
}

@end
