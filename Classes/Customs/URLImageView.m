//
//  URLImageView.m
//  appetizer
//
//  Created by Vinay Chavan on 12/12/10.
//  Copyright 2010 Vinay Chavan. All rights reserved.
//

#import "URLImageView.h"
#import "UIImageAdditions.h"

@implementation URLImageView

@synthesize placeHolderImage;
@synthesize roundedCorner;
@synthesize shouldShowActivityIndicator;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
		placeHolderImage = nil;
		request = nil;
		delegate = nil;
		callback = NULL;
		roundedCorner = NO;
		shouldShowActivityIndicator = NO;
		self.backgroundColor = [UIColor clearColor];
		self.userInteractionEnabled = YES;
		
		UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapSelf:)];
		[self addGestureRecognizer:tapGesture];
		[tapGesture release];
    }
    return self;
}

- (void)dealloc {
	if ([request isLoading]) {
		[request cancel];
		[request release], request = nil;
	}
	[placeHolderImage release], placeHolderImage = nil;
    [super dealloc];
}




#pragma mark - Private Methods

- (void)didTapSelf:(id)sender {
	if (delegate) {
		if ([delegate respondsToSelector:callback]) {
			[delegate performSelector:callback withObject:self];
		}
	}
}



#pragma mark - Public Methods

- (void)setRemoteImage:(NSString*)url {
	NSLog(@"urllll :: %@", url);
	if ([request isLoading]) {
		[request cancel];
		[request release], request = nil;
	}
	
	request = [[TTURLRequest requestWithURL:url delegate:self] retain];
	request.cachePolicy = TTURLRequestCachePolicyDefault;
	request.cacheExpirationAge = TT_DEFAULT_CACHE_EXPIRATION_AGE;
	request.response = [[[TTURLImageResponse alloc] init] autorelease];
	
	if (!activityIndicator && shouldShowActivityIndicator) {
		activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
		[activityIndicator sizeToFit];
		activityIndicator.center = self.center;
		activityIndicator.hidesWhenStopped = YES;
		activityIndicator.userInteractionEnabled = NO;
		[self addSubview:activityIndicator];
	}
	[activityIndicator startAnimating];
	[self bringSubviewToFront:activityIndicator];

	[request send];
}

- (void)addTarget:(id)target withSelector:(SEL)selector {
	delegate = target;
	callback = selector;
}


#pragma mark - TTURLRequestDelegate Methods

- (void)requestDidFinishLoad:(TTURLRequest*)aRequest {
	TTURLImageResponse *response = aRequest.response;
	if (roundedCorner) {
		UIImage *temp = response.image;
		self.image = [temp imageWithRoundedCorner:floor(temp.size.width*0.20)];
	}else {
		if (response.image.size.width > response.image.size.height) {
			self.image = [UIImage imageWithCGImage:response.image.CGImage scale:1 orientation:UIImageOrientationRight];
		}else {
			self.image = response.image;
		}
	}

	[activityIndicator stopAnimating];
	[activityIndicator removeFromSuperview];
	[activityIndicator release], activityIndicator = nil;

	[request release], request = nil;
}

- (void)request:(TTURLRequest*)aRequest didFailLoadWithError:(NSError*)error {
	[activityIndicator stopAnimating];
	[activityIndicator removeFromSuperview];
	[activityIndicator release], activityIndicator = nil;
	[request release], request = nil;
}

- (void)requestDidCancelLoad:(TTURLRequest*)aRequest {
	[activityIndicator stopAnimating];
	[activityIndicator removeFromSuperview];
	[activityIndicator release], activityIndicator = nil;
	[request release], request = nil;
}



@end
