//
//  SKMathVector.h
//  Skirmish
//
//  Created by Daryl on 31/01/2008.
//  Copyright 2008 Daryl Dudey. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SKMathVector : NSObject 
{
}

typedef struct {
	CGFloat x, y, z;
} vector;

- (vector)addVector:(vector)a plus:(vector)b;
- (vector)subVector:(vector)a plus:(vector)b;
- (CGFloat)dot:(vector)a plus:(vector)b;
- (vector)getNormal:(vector)a plus:(vector)b;
- (vector)normalize:(vector)a;

@end
