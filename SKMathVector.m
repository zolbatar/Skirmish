//
//  SKMathVector.m
//  Skirmish
//
//  Created by Daryl on 31/01/2008.
//  Copyright 2008 Daryl Dudey. All rights reserved.
//

#import "SKMathVector.h"

@implementation SKMathVector

- (vector)addVector:(vector)a plus:(vector)b
{
	vector r;
	
	r.x = a.x + b.x;
	r.y = a.y + b.y;
	r.z = a.z + b.z;
	
	return r;
}

- (vector)subVector:(vector)a plus:(vector)b
{
	vector r;
	
	r.x = a.x - b.x;
	r.y = a.y - b.y;
	r.z = a.z - b.z;
	
	return r;
}

- (CGFloat)dot:(vector)a plus:(vector)b
{
	return (a.x * b.x) + (a.y * b.y) + (a.z * b.z);
}

- (vector)getNormal:(vector)a plus:(vector)b 
{
	vector result;
	CGFloat distance;
	
	result.x = a.y * b.z - a.z * b.y;
	result.y = a.z * b.x - a.x * b.z;
	result.z = a.x * b.y - a.y * b.x;
	
	distance = sqrt(result.x*result.x + result.y*result.y + result.z*result.z);
	
	result.x = -result.x/distance;
	result.y = -result.y/distance;
	result.z = -result.z/distance;
	
	return result;
}

- (vector)normalize:(vector)a
{
	vector result;
	CGFloat distance;
	
	result.x = a.x;
	result.y = a.y;
	result.z = a.z;
	
	distance = sqrt(result.x*result.x + result.y*result.y + result.z*result.z);
	
	result.x = result.x/distance;
	result.y = result.y/distance;
	result.z = result.z/distance;
	
	return result;
}

@end
