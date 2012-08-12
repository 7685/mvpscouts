//
//  ContactCellView.h
//  munduIM
//
//  Created by Vinay Chavan on 27/01/11.
//  Copyright 2009 Geodesic Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MIMContact;

@interface ContactCellView : UIView {
	MIMContact *contact;
	
	UIImageView *statusImageView;
	UIImageView *avatarImageView;
	UIImageView *avatarImageOverlay;
	UIImageView *serviceImageView;
	UILabel *titleLabel;
	UILabel *subtitleLabel;
	UIImageView *unreadBadgeImageView;
	UILabel *unreadTextLabel;
}

@property (nonatomic, retain) MIMContact *contact;

@end
