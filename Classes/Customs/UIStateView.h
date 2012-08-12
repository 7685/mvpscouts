//
//  UIStateView.h
//  munduIM
//
//  Created by Vinay Chavan on 26/03/10.
//  Copyright 2010 Geodesic Limited. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIStateView : UIView {
	UIImageView* _imageView;
	UILabel* _titleView;
	UILabel* _subtitleView;
}

@property(nonatomic,retain) UIImage* image;
@property(nonatomic,copy) NSString* title;
@property(nonatomic,copy) NSString* subtitle;

- (id)initWithTitle:(NSString*)title subtitle:(NSString*)subtitle image:(UIImage*)image;

@end
