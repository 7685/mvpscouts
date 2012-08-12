//
//  URLImageView.h
//  appetizer
//
//  Created by Vinay Chavan on 12/12/10.
//  Copyright 2010 Vinay Chavan. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <Three20Network/Three20Network.h>

@interface URLImageView : UIImageView <TTURLRequestDelegate> {
	UIImage *placeHolderImage;
	TTURLRequest *request;
	
	UIActivityIndicatorView *activityIndicator;
	BOOL shouldShowActivityIndicator;
	
	// Rounded Corner
	BOOL roundedCorner;
	
	// Tap
	id delegate;
	SEL callback;
}

@property (nonatomic, retain) UIImage *placeHolderImage;
@property (assign) BOOL roundedCorner;
@property (assign) BOOL shouldShowActivityIndicator;

- (void)setRemoteImage:(NSString*)url;

- (void)addTarget:(id)target withSelector:(SEL)selector;

@end

