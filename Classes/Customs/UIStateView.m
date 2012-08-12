//
//  UIStateView.m
//  munduIM
//
//  Created by Vinay Chavan on 26/03/10.
//  Copyright 2010 Geodesic Limited. All rights reserved.
//

#import "UIStateView.h"

///////////////////////////////////////////////////////////////////////////////////////////////////
// global

static CGFloat kVPadding1 = 30;
static CGFloat kVPadding2 = 20;
static CGFloat kHPadding = 10;

///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation UIStateView

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)initWithTitle:(NSString*)title subtitle:(NSString*)subtitle image:(UIImage*)image {
	if (self = [self init]) {
		self.title = title;
		self.subtitle = subtitle;
		self.image = image;
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		self.backgroundColor = [UIColor clearColor];
		
		_imageView = [[UIImageView alloc] init];
		_imageView.contentMode = UIViewContentModeCenter;
		[self addSubview:_imageView];
		
		_titleView = [[UILabel alloc] init];
		_titleView.backgroundColor = [UIColor clearColor];
		_titleView.textColor = [UIColor darkGrayColor];
		_titleView.font = [UIFont boldSystemFontOfSize:18];
		_titleView.textAlignment = UITextAlignmentCenter;
		[self addSubview:_titleView];
		
		_subtitleView = [[UILabel alloc] init];
		_subtitleView.backgroundColor = [UIColor clearColor];
		_subtitleView.textColor = [UIColor darkGrayColor];
		_subtitleView.font = [UIFont boldSystemFontOfSize:12];
		_subtitleView.textAlignment = UITextAlignmentCenter;
		_subtitleView.numberOfLines = 0;
		[self addSubview:_subtitleView];
	}
	return self;
}

/*
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc {
	[_imageView release], _imageView = nil;
	[_titleView release], _titleView = nil;
	[_subtitleView release], _subtitleView = nil;
    [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// UIView

- (void)layoutSubviews {
	CGRect rect;
	
	rect = _subtitleView.bounds;
	rect.size = [_subtitleView sizeThatFits:CGSizeMake(self.bounds.size.width - kHPadding*2, 0)];
	_subtitleView.bounds = rect;
	[_titleView sizeToFit];
	[_imageView sizeToFit];
	
	CGFloat maxHeight = _imageView.bounds.size.height + _titleView.bounds.size.height + _subtitleView.bounds.size.height
	+ kVPadding1 + kVPadding2;
	BOOL canShowImage = _imageView.image && self.bounds.size.height > maxHeight;
	
	CGFloat totalHeight = 0;
	
	if (canShowImage) {
		totalHeight += _imageView.bounds.size.height;
	}
	if (_titleView.text.length) {
		totalHeight += (totalHeight ? kVPadding1 : 0) + _titleView.bounds.size.height;
	}
	if (_subtitleView.text.length) {
		totalHeight += (totalHeight ? kVPadding2 : 0) + _subtitleView.bounds.size.height;
	}
	
	CGFloat top = floor(self.bounds.size.height/2 - totalHeight/2);
	
	if (canShowImage) {
		rect = _imageView.frame;
		rect.origin = CGPointMake(floor(self.bounds.size.width/2 - _imageView.bounds.size.width/2), top);
		_imageView.frame = rect;
		_imageView.hidden = NO;
		top += _imageView.bounds.size.height + kVPadding1;
	} else {
		_imageView.hidden = YES;
	}
	if (_titleView.text.length) {
		rect = _titleView.frame;
		rect.origin = CGPointMake(floor(self.bounds.size.width/2 - _titleView.bounds.size.width/2), top);
		_titleView.frame = rect;
		top += _titleView.bounds.size.height + kVPadding2;
	}
	if (_subtitleView.text.length) {
		rect = _subtitleView.frame;
		rect.origin = CGPointMake(floor(self.bounds.size.width/2 - _subtitleView.bounds.size.width/2), top);
		_subtitleView.frame = rect;
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////

- (NSString*)title {
	return _titleView.text;
}

- (void)setTitle:(NSString*)title {
	_titleView.text = title;
}

- (NSString*)subtitle {
	return _subtitleView.text;
}

- (void)setSubtitle:(NSString*)subtitle {
	_subtitleView.text = subtitle;
}

- (UIImage*)image {
	return _imageView.image;
}

- (void)setImage:(UIImage*)image {
	_imageView.image = image;
}

@end
