//
//  UIViewAdditions.m
//  appetizer
//
//  Created by Vinay Chavan on 12/12/10.
//  Copyright 2010 Vinay Chavan. All rights reserved.
//

#import "UIViewAdditions.h"


@implementation UIView (CG)

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)openPath:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);
	CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
	CGContextBeginPath(context);
}
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)closePath:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextClosePath(context);
	CGContextRestoreGState(context);
}
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)addToPath:(CGRect)rect radiusTopLeft:(CGFloat)radiusTopLeft radiusTopRight:(CGFloat)radiusTopRight radiusBottomLeft:(CGFloat)radiusBottomLeft radiusBottomRight:(CGFloat)radiusBottomRight{
	[self openPath:rect];
	
	CGFloat fw = rect.size.width;
	CGFloat fh = rect.size.height;
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextMoveToPoint(context, fw, floor(fh/2));
	CGContextAddArcToPoint(context, fw, fh, floor(fw/2), fh, RD(radiusBottomRight)); // bottomRight
	CGContextAddArcToPoint(context, 0, fh, 0, floor(fh/2), RD(radiusBottomLeft)); // bottomLeft
	CGContextAddArcToPoint(context, 0, 0, floor(fw/2), 0, RD(radiusTopLeft)); // topLeft
	CGContextAddArcToPoint(context, fw, 0, fw, floor(fh/2), RD(radiusTopRight)); // topRight
	
	[self closePath:rect];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGGradientRef)newGradientWithColors:(UIColor**)colors locations:(CGFloat*)locations count:(int)count {
	CGFloat* components = malloc(sizeof(CGFloat)*4*count);
	for (int i = 0; i < count; ++i) {
		UIColor* color = colors[i];
		size_t n = CGColorGetNumberOfComponents(color.CGColor);
		const CGFloat* rgba = CGColorGetComponents(color.CGColor);
		if (n == 2) {
			components[i*4] = rgba[0];
			components[i*4+1] = rgba[0];
			components[i*4+2] = rgba[0];
			components[i*4+3] = rgba[1];
		} else if (n == 4) {
			components[i*4] = rgba[0];
			components[i*4+1] = rgba[1];
			components[i*4+2] = rgba[2];
			components[i*4+3] = rgba[3];
		}
	}
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGColorSpaceRef space = CGBitmapContextGetColorSpace(context);
	CGGradientRef gradient = CGGradientCreateWithColorComponents(space, components, locations, count);
	free(components);
	
	return gradient;
}

@end
