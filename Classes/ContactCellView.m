//
//  ContactCellView.m
//  munduIM
//
//  Created by Vinay Chavan on 27/01/11.
//  Copyright 2009 Geodesic Ltd. All rights reserved.
//	

#import "ContactCellView.h"

#import "UIViewAdditions.h"

#import "NSStringAdditions.h"
//#import "MIMCoreAvatarsAddition.h"
//#import "MIMDBConstants.h"
#import "UIConstants.h"

@implementation ContactCellView

@synthesize contact;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
 		self.backgroundColor = [UIColor whiteColor];
		self.opaque = YES;
		self.clearsContextBeforeDrawing = NO;
		self.clipsToBounds = YES;
		
		statusImageView = [[UIImageView alloc] initWithFrame:CGRectMake(7, 19, 16, 16)];
		statusImageView.backgroundColor = [UIColor whiteColor];
		statusImageView.opaque = YES;
		statusImageView.clipsToBounds = YES;
		statusImageView.clearsContextBeforeDrawing = NO;
		[self addSubview:statusImageView];
		
		avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 5, 44, 44)];
		avatarImageView.backgroundColor = [UIColor whiteColor];
		avatarImageView.opaque = YES;
		avatarImageView.clipsToBounds = YES;
		avatarImageView.clearsContextBeforeDrawing = NO;
		[self addSubview:avatarImageView];
		
		avatarImageOverlay = [[UIImageView alloc] initWithFrame:CGRectMake(50, 24, 20, 20)];
		avatarImageOverlay.backgroundColor = [UIColor clearColor];
		avatarImageOverlay.opaque = YES;
		avatarImageOverlay.clipsToBounds = YES;
		avatarImageOverlay.clearsContextBeforeDrawing = NO;
		[self addSubview:avatarImageOverlay];
		
		serviceImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 31, 20, 20)];
		serviceImageView.backgroundColor = [UIColor clearColor];
		serviceImageView.clipsToBounds = YES;
		serviceImageView.clearsContextBeforeDrawing = NO;
		[self addSubview:serviceImageView];
		
		subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(82, 27, 200, 22)];
		subtitleLabel.opaque = YES;
		subtitleLabel.clipsToBounds = YES;
		subtitleLabel.clearsContextBeforeDrawing = NO;
		subtitleLabel.adjustsFontSizeToFitWidth = YES;
		subtitleLabel.font = [UIFont systemFontOfSize:DETAIL_FONT_SIZE];
		subtitleLabel.minimumFontSize = MIN_DETAIL_FONT_SIZE;
		subtitleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		subtitleLabel.backgroundColor = [UIColor whiteColor];
		subtitleLabel.textColor = [UIColor darkGrayColor];
		subtitleLabel.highlightedTextColor = [UIColor whiteColor];		
		[self addSubview:subtitleLabel];
		
		titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(82, 5, 200, 22)];
		titleLabel.opaque = YES;
		titleLabel.clipsToBounds = YES;
		titleLabel.clearsContextBeforeDrawing = NO;
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

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code.
 }
 */

- (void)layoutSubviews {
	CGFloat titleWidth = self.bounds.size.width - 92;
	
	
	
    titleLabel.frame = CGRectMake(82, 16, titleWidth, 22);
	
	subtitleLabel.frame = CGRectMake(82, 27, titleWidth, 22);
}

- (void)dealloc {
	[contact release], contact = nil;
	[statusImageView release], statusImageView = nil;
	[avatarImageView release], avatarImageView = nil;
	[avatarImageOverlay release], avatarImageOverlay = nil;
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
	
    
	avatarImageView.image = [UIImage imageNamed:@"default_avatar.png"];
	
	
	[self setNeedsLayout];
}

@end
