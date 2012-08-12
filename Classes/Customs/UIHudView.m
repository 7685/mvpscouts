//
//  UIHudView.m
//  appetizer
//
//  Created by Vinay Chavan on 12/12/10.
//  Copyright 2010 Vinay Chavan. All rights reserved.
//

#import "UIHudView.h"

#import "UIViewAdditions.h"

///////////////////////////////////////////////////////////////////////////////////////////////////
// global

static CGFloat kVPadding = 10;
static CGFloat kHPadding = 10;

///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation UIHudView

@synthesize backgroundColor1 = _backgroundColor1;
@synthesize borderColor = _borderColor;
@synthesize textColor = _textColor;
@synthesize shouldShowActivityIndicator;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		_backgroundColor1 = [[UIColor colorWithWhite:0.2 alpha:0.7] retain];
		_borderColor = [[UIColor colorWithWhite:0.2 alpha:0.7] retain];
		_textColor = [[UIColor whiteColor] retain];
		self.alpha = 0;
		
		_titleLabel = [[UILabel alloc] init];
		_titleLabel.backgroundColor = [UIColor clearColor];
		_titleLabel.textColor = [UIColor whiteColor];
		_titleLabel.shadowColor = [UIColor blackColor];
		_titleLabel.shadowOffset = CGSizeMake(0, 1);
		_titleLabel.font = [UIFont boldSystemFontOfSize:15];
		_titleLabel.textAlignment = UITextAlignmentCenter;
		_titleLabel.numberOfLines = 0;
		[self addSubview:_titleLabel];
		
		_imageView = [[UIImageView alloc] init];
		_imageView.contentMode = UIViewContentModeCenter;
		[self addSubview:_imageView];
		
		_activityIndicator = [[UIActivityIndicatorView alloc] init];
		_activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
		_activityIndicator.hidesWhenStopped = YES;
		[self addSubview:_activityIndicator];
		
		rotationTransform = CGAffineTransformIdentity;
		[[NSNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(deviceOrientationDidChange:) 
													 name:UIDeviceOrientationDidChangeNotification 
												   object:nil];
    }
    return self;
}

- (void) dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	
	[_imageView release];
	[_titleLabel release];
	[_activityIndicator release];
	[_backgroundColor1 release];
	[_borderColor release];
	[_textColor release];
	[super dealloc];
}




#pragma mark -
#pragma mark Public Properties

- (NSString*)title {
	return _titleLabel.text;
}

- (void)setTitle:(NSString *)title {
	_titleLabel.text = title;
	[self setNeedsLayout];
}

- (UIImage*)image {
	return _imageView.image;
}

- (void)setImage:(UIImage *)image {
	_imageView.image = image;
	if (_imageView.image == nil) {
		if (shouldShowActivityIndicator) {
			[_activityIndicator startAnimating];
		}else {
			[_activityIndicator stopAnimating];
		}
	}else {
		[_activityIndicator stopAnimating];
	}
	
	[self setNeedsLayout];
}

#pragma mark -
#pragma mark Draw Code


- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);
	
	// Fill background
	[self addToPath:rect
	  radiusTopLeft:15
	 radiusTopRight:15
   radiusBottomLeft:15
  radiusBottomRight:15];
	CGContextClip(context);
	
	CGContextSetFillColorWithColor(context, self.backgroundColor1.CGColor);
	CGContextFillRect(context, rect);
	
	// Draw border
	[self addToPath:rect
	  radiusTopLeft:15 
	 radiusTopRight:15 
   radiusBottomLeft:15 
  radiusBottomRight:15];
	CGContextSetStrokeColorWithColor(context, self.borderColor.CGColor);
	CGContextSetLineWidth(context, 2);
	CGContextStrokePath(context);
	
	
	// done drawing
	CGContextRestoreGState(context);
}



#pragma mark -
#pragma mark Layout

- (void)layoutSubviews {
	CGRect rect;
	
	UIView *upperView = nil;
	if (_imageView.image == nil && shouldShowActivityIndicator) {
		upperView = _activityIndicator;
	}else {
		upperView = _imageView;
	}
	
	rect = _titleLabel.bounds;
	rect.size = [_titleLabel sizeThatFits:CGSizeMake(self.bounds.size.width - kHPadding*2, 0)];
	_titleLabel.bounds = rect;
	[upperView sizeToFit];
	
	CGFloat maxHeight = (upperView.bounds.size.height + 
						 _titleLabel.bounds.size.height + 
						 kVPadding);
	BOOL canShowImage = (_imageView.image || shouldShowActivityIndicator) && self.bounds.size.height > maxHeight;
	
	CGFloat totalHeight = 0;
	
	if (canShowImage) {
		totalHeight += upperView.bounds.size.height;
	}
	if (_titleLabel.text.length) {
		totalHeight += (totalHeight ? kVPadding : 0) + _titleLabel.bounds.size.height;
	}
	
	CGFloat top = floor((self.bounds.size.height - totalHeight)/2);
	
	if (canShowImage) {
		rect = upperView.frame;
		rect.origin = CGPointMake(floor((self.bounds.size.width - upperView.bounds.size.width)/2), top);
		upperView.frame = rect;
		upperView.hidden = NO;
		top += upperView.bounds.size.height + kVPadding;
	} else {
		upperView.hidden = YES;
	}
	
	if (_titleLabel.text.length) {
		rect = _titleLabel.frame;
		rect.origin = CGPointMake(floor((self.bounds.size.width - _titleLabel.bounds.size.width)/2), top);
		_titleLabel.frame = rect;
	}
}


#pragma mark -
#pragma mark -
#pragma mark Gesture Detection

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[super touchesBegan:touches withEvent:event];
	[self hide];
}





#pragma mark -
#pragma mark Public Methods

#define RADIANS(degrees) ((degrees * M_PI) / 180.0)

- (void)show {
	if (self.alpha != 1) {
		self.transform = CGAffineTransformConcat(rotationTransform, CGAffineTransformMakeScale(0.5, 0.5));
	}
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:0.3];
	self.alpha = 1;
	self.transform = CGAffineTransformConcat(rotationTransform, CGAffineTransformMakeScale(1.0, 1.0));
	[UIView commitAnimations];
}


- (void)hide {
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationDuration:0.5];
	self.alpha = 0;
	self.transform = CGAffineTransformMakeScale(1.5, 1.5);
	[UIView commitAnimations];
}



#pragma mark -
#pragma mark Manual oritentation change

#define RADIANS(degrees) ((degrees * M_PI) / 180.0)

- (void)setTransformForCurrentOrientation:(BOOL)animated {
	UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
	NSInteger degrees = 0;
	
	if (UIInterfaceOrientationIsLandscape(orientation)) {
		if (orientation == UIInterfaceOrientationLandscapeLeft) {
			degrees = -90;
		} else { 
			degrees = 90;
		}
	} else {
		if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
			degrees = 180; 
		} else {
			degrees = 0; 
		}
	}
	
	rotationTransform = CGAffineTransformMakeRotation(RADIANS(degrees));
	
	if (animated) {
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:0.3];
	}
	[self setTransform:rotationTransform];
	if (animated) {
		[UIView commitAnimations];
	}
}

- (void)deviceOrientationDidChange:(NSNotification *)notification { 
	if (!self.superview) {
		return;
	}
	if ([self.superview isKindOfClass:[UIWindow class]]) {
		[self setTransformForCurrentOrientation:YES];
	}
}


@end
