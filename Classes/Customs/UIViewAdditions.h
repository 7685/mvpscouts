//
//  UIViewAdditions.h
//  appetizer
//
//  Created by Vinay Chavan on 12/12/10.
//  Copyright 2010 Vinay Chavan. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TT_ROUNDED -1
#define RD(_RADIUS) (_RADIUS == TT_ROUNDED ? round(fh/2) : _RADIUS)

@interface UIView (CG) 

- (void)openPath:(CGRect)rect;

- (void)closePath:(CGRect)rect;

- (void)addToPath:(CGRect)rect 
	radiusTopLeft:(CGFloat)radiusTopLeft 
   radiusTopRight:(CGFloat)radiusTopRight
 radiusBottomLeft:(CGFloat)radiusBottomLeft 
radiusBottomRight:(CGFloat)radiusBottomRight;

- (CGGradientRef)newGradientWithColors:(UIColor**)colors locations:(CGFloat*)locations count:(int)count;

@end
