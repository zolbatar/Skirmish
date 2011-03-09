//
//  SKMathPerlin.m
//  Skirmish
//
//  Created by Daryl on 31/01/2008.
//  Copyright 2008 Daryl Dudey. All rights reserved.
//

#import "SKMathPerlin.h"

@implementation SKMathPerlin

@synthesize octaves; 
@synthesize frequency; 
@synthesize persistence; 

- (CGFloat)noiseX:(NSInteger)x Y:(NSInteger)y 
{
	NSUInteger n = x + y * 57;
	n = (n<<13) ^ n;
	return ( 1.0 - ( (n * (n * n * 15731 + 789221) + 1376312589) & 0x7fffffff) / 1073741824.0);    
}

- (CGFloat)smoothX:(CGFloat)x Y:(CGFloat)y 
{
	CGFloat corners =	[self noiseX:(x - 1) Y:(y - 1)] +
	[self noiseX:(x + 1) Y:(y - 1)] +
	[self noiseX:(x - 1) Y:(y + 1)] +
	[self noiseX:(x + 1) Y:(y + 1)];
	corners /= 16.0f;
	CGFloat sides =		[self noiseX:(x - 1) Y:y] +
	[self noiseX:(x + 1) Y:y] +
	[self noiseX:x		Y:(y - 1)] +
	[self noiseX:x		Y:(y + 1)];
	sides /= 8.0f;
	CGFloat centre =	[self noiseX:x Y:y];
	centre /= 4.0f;
	return corners + sides + centre;
}

- (CGFloat)interpolateA:(CGFloat)a B:(CGFloat)b X:(CGFloat)x 
{
	CGFloat val = (1 - cos(x * 3.1415927f)) * 0.5f;
	return a*(1-val) + b*val;
}

- (CGFloat)interpolatedNoiseX:(CGFloat)x Y:(CGFloat)y 
{
	CGFloat v1 = [self smoothX:(NSInteger)x			Y:(NSInteger)y];
	CGFloat v2 = [self smoothX:((NSInteger)x) + 1		Y:(NSInteger)y];
	CGFloat v3 = [self smoothX:(NSInteger)x			Y:((NSInteger)y) + 1];
	CGFloat v4 = [self smoothX:((NSInteger)x) + 1		Y:((NSInteger)y) + 1];
	CGFloat fractionalX = x - (NSInteger)x;
	CGFloat fractionalY = y - (NSInteger)y;
	CGFloat i1 = [self interpolateA:v1 B:v2 X:fractionalX];
	CGFloat i2 = [self interpolateA:v3 B:v4 X:fractionalX];
	return [self interpolateA:i1 B:i2 X:fractionalY];
}

- (CGFloat)perlinNoise2DX:(CGFloat)x Y:(CGFloat)y 
{
	CGFloat total = 0.0f;
	CGFloat amplitude = 1.0f;
	CGFloat _frequency = frequency;
	CGFloat _persistence = persistence;
	NSUInteger i;
	for (i = 0; i < octaves; i++) 
	{
		total += [self interpolatedNoiseX:(x * _frequency) Y:(y * _frequency)] * amplitude;
		_frequency *= 2;
		amplitude *= _persistence;
	}
	return total;
}

@end
