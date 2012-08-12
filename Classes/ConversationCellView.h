//
//  ConversationCellView.h
//  munduIM
//
//  Created by Vinay Chavan on 27/01/11.
//  Copyright 2009 Geodesic Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MIMContact;

@interface ConversationCellView : UIView {
	MIMContact *contact;
	NSString *message;
	
	UIImageView *statusImageView;
	UIImageView *avatarImageView;
	UIImageView *serviceImageView;
	UILabel *titleLabel;
	UILabel *subtitleLabel;
	UIImageView *unreadBadgeImageView;
	UILabel *unreadTextLabel;
}

@property(nonatomic, assign) BOOL editing;

@property (nonatomic, retain) MIMContact * contact;
@property (nonatomic, retain) NSString * message;

@end
