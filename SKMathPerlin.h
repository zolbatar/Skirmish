//
//  SKMathPerlin.h
//  Skirmish
//
//  Created by Daryl on 31/01/2008.
//  Copyright 2008 Daryl Dudey. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SKMathPerlin : NSObject 
{
	CGFloat octaves;
	CGFloat frequency;
	CGFloat persistence;
}

@property(assign, readwrite) CGFloat octaves; 
@property(assign, readwrite) CGFloat frequency; 
@property(assign, readwrite) CGFloat persistence; 

- (CGFloat)perlinNoise2DX:(CGFloat)x Y:(CGFloat)y;

@end
