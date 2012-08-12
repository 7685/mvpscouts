//
//  UIHudView.h
//  appetizer
//
//  Created by Vinay Chavan on 12/12/10.
//  Copyright 2010 Vinay Chavan. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIHudView : UIView {
	UIImageView *_imageView;
	UILabel *_titleLabel;
	UIActivityIndicatorView *_activityIndicator;
	
	UIColor *_backgroundColor1;
	UIColor *_borderColor;
	UIColor *_textColor;
	
	BOOL shouldShowActivityIndicator;
	CGAffineTransform rotationTransform;
}

@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) NSString *title;

@property (nonatomic, retain) UIColor *backgroundColor1;
@property (nonatomic, retain) UIColor *borderColor;
@property (nonatomic, retain) UIColor *textColor;

@property (assign) BOOL shouldShowActivityIndicator;

- (void)show;
- (void)hide;

@end
