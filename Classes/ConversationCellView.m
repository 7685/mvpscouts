//
//  ConversationCellView.m
//  munduIM
//
//  Created by Vinay Chavan on 27/01/11.
//  Copyright 2009 Geodesic Ltd. All rights reserved.
//

#import "ConversationCellView.h"
#import "constants.h"
#import "UIViewAdditions.h"
//#import "MIMCoreAvatarsAddition.h"
#import "MIMContact.h"
#import "NSStringAdditions.h"
#import "UIImageAdditions.h"

#import "UIConstants.h"

@implementation ConversationCellView

@synthesize contact;
@synthesize message;
//@synthesize editing; 


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
 		self.backgroundColor = [UIColor whiteColor];
		self.opaque = YES;
		self.clearsContextBeforeDrawing = NO;
		self.clipsToBounds = YES;
		
		statusImageView = [[UIImageView alloc] initWithFrame:CGRectMake(7, 19, 16, 16)];
		statusImageView.backgroundColor = self.backgroundColor;
		statusImageView.opaque = YES;
		statusImageView.clipsToBounds = YES;
		statusImageView.clearsContextBeforeDrawing = NO;
		[self addSubview:statusImageView];
		
		avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(7, 5, 44, 44)];
		avatarImageView.backgroundColor = self.backgroundColor;
		avatarImageView.opaque = YES;
		avatarImageView.clipsToBounds = YES;
		avatarImageView.clearsContextBeforeDrawing = NO;
		[self addSubview:avatarImageView];
		
		serviceImageView = [[UIImageView alloc] initWithFrame:CGRectMake(7, 31, 20, 20)];
		serviceImageView.backgroundColor = [UIColor clearColor];
		serviceImageView.clipsToBounds = YES;
		serviceImageView.clearsContextBeforeDrawing = NO;
		[self addSubview:serviceImageView];
		
		subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(59, 27, 200, 22)];
		subtitleLabel.adjustsFontSizeToFitWidth = YES;
		subtitleLabel.font = [UIFont systemFontOfSize:DETAIL_FONT_SIZE];
		subtitleLabel.minimumFontSize = MIN_DETAIL_FONT_SIZE;
		subtitleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		subtitleLabel.backgroundColor = [UIColor whiteColor];
		subtitleLabel.textColor = [UIColor darkGrayColor];
		subtitleLabel.highlightedTextColor = [UIColor whiteColor];		
		[self addSubview:subtitleLabel];
		
		titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(59, 5, 200, 22)];
		titleLabel.adjustsFontSizeToFitWidth = YES;
		titleLabel.font = [UIFont boldSystemFontOfSize:NAME_FONT_SIZE];
		titleLabel.minimumFontSize = MIN_NAME_FONT_SIZE;
		titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		titleLabel.backgroundColor = [UIColor whiteColor];
		titleLabel.textColor = [UIColor colorWithWhite:0.2 alpha:1];
		titleLabel.highlightedTextColor = [UIColor whiteColor];
		[self addSubview:titleLabel];
		
		unreadBadgeImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		unreadBadgeImageView.image = [[UIImage imageNamed:@"unreadBadge.png"] stretchableImageWithLeftCapWidth:15
																								  topCapHeight:0];
		unreadBadgeImageView.backgroundColor = [UIColor clearColor];
		unreadBadgeImageView.clipsToBounds = YES;
		unreadBadgeImageView.clearsContextBeforeDrawing = NO;
		unreadBadgeImageView.hidden = YES;
		[self addSubview:unreadBadgeImageView];
		
		unreadTextLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		unreadTextLabel.textAlignment = UITextAlignmentCenter;
		unreadTextLabel.adjustsFontSizeToFitWidth = YES;
		unreadTextLabel.font = [UIFont boldSystemFontOfSize:DETAIL_FONT_SIZE];
		unreadTextLabel.minimumFontSize = MIN_DETAIL_FONT_SIZE;
		unreadTextLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		unreadTextLabel.backgroundColor = [UIColor clearColor];
		unreadTextLabel.textColor = [UIColor whiteColor];
		unreadTextLabel.highlightedTextColor = [UIColor whiteColor];
		unreadTextLabel.hidden = YES;
		[self addSubview:unreadTextLabel];
    }
    return self;
}

- (void)layoutSubviews {
	CGFloat titleWidth = self.bounds.size.width - 92;
	
	
		unreadTextLabel.hidden = YES;
		unreadBadgeImageView.hidden = YES;
	
	
	if(!message || [self.message isEqualToString:@""]) {
		titleLabel.frame = CGRectMake(59, 16, titleWidth, 22);
	}else {
		titleLabel.frame = CGRectMake(59, 5, titleWidth, 22);
	}
	
	subtitleLabel.frame = CGRectMake(59, 27, titleWidth, 22);
}

- (void)dealloc {
	[contact release], contact = nil;
	[statusImageView release], statusImageView = nil;
	[avatarImageView release], avatarImageView = nil;
	[serviceImageView release], serviceImageView = nil;
	[titleLabel release], titleLabel = nil;
	[subtitleLabel release], subtitleLabel = nil;
	[unreadBadgeImageView release], unreadBadgeImageView = nil;
	[unreadTextLabel release], unreadTextLabel = nil;
    [super dealloc];
}


- (void)setContact:(MIMContact *)aContact {
	[contact release], contact = nil;
	contact = [aContact retain];
	
    UIImage *avatar;
    if ([aContact.avatar isEqualToString:BLANK_STRING]) {
        avatar = [UIImage imageNamed:@"default_avatar.png"];
    }
	else {
        avatar = [UIImage imageWithContentsOfFile:aContact.avatar];
    }
    
	avatarImageView.image = avatar;
	titleLabel.text = self.contact.title;
	
	[self setNeedsLayout];
}

- (void)setMessage:(NSString *)aMessage {
	[message release], message = nil;
	message = [aMessage retain];
	
	if (self.message) {
		subtitleLabel.text = [NSString replaceEmoticonsInString:self.message];
	}else {
		subtitleLabel.text = @"";
	}

	[self setNeedsLayout];
}

@end