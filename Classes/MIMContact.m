//
//  MIMContact.m
//  munduIM
//
//  Created by Vinay Chavan on 18/07/09.
//  Copyright 2009 Home. All rights reserved.
//

#import "MIMContact.h"
//#import "MIMCore.h"

@implementation MIMContact

@synthesize uid = _uid;
@synthesize contactId = _contact_id;
@synthesize service = _service;
@synthesize userId = _user_id;
@synthesize alias = _alias;
@synthesize avatar = _avatar;
@synthesize customStatus = _custom_status;
@synthesize group = _group;
@synthesize status = _status;
@synthesize isBlocked = _blocked;
@synthesize chatState = _chat_state;
@synthesize subscriptionState = _subscription_state;
@synthesize lastReadMessageUid = _last_read_message_uid;
@synthesize unreadMessages = _unread_messages;
@synthesize isFavorite = _is_favorite;
@synthesize addressBookID = _address_book_id;
@synthesize userStatus = _user_status;
@synthesize subscription = _subscription;

- (id) init {
	self = [super init];
	if (self != nil) {
		_contact_id = nil;
		_user_id = nil;
		_service = nil;
		_alias = nil;
		_avatar = [[NSString alloc] initWithString:@""];
		_custom_status = [[NSString alloc] initWithString:@""];
		_group = [[NSString alloc] initWithString:@""];
		_status = OFFLINE;
		_blocked = NO;
		_chat_state = MIMChatStateNoChat;
		_subscription_state = MIMSubscriptionStateMutual;
		_last_read_message_uid = 0;
		_unread_messages = 0;
		_is_favorite = NO;
		_address_book_id = -1;
		_user_status = OFFLINE;
		_subscription = nil;
	}
	return self;
}


- (id) initContact:(NSString*)aContact user:(NSString*)aUser service:(NSString*)aService {
	if( self = [self init] ) {
		_contact_id = [aContact copy];
		_user_id = [aUser copy];
		_service = [aService copy];
	}
	return self;
}

- (void) dealloc {
	[_subscription release], _subscription = nil;
	[_service release], _service = nil;
	[_contact_id release], _contact_id = nil;
	[_user_id release], _user_id = nil;
	[_alias release], _alias = nil;
	[_avatar release], _avatar = nil;
	[_custom_status release], _custom_status = nil;
	[_group release], _group = nil;
	[super dealloc];
}

- (NSString*) title {
	if (!_alias) {
		return _contact_id;
	}
	if( [_alias isEqualToString:@""] )
		return _contact_id;
	return _alias;
}

- (NSString*)key {
	return [NSString stringWithFormat:kConversationSessionKeyFormat, _service, _user_id, _contact_id];
}

- (NSString*) description {
	return [self key];
}

+ (int)codeForStatus:(NSString*)aStatus {
	int status = OFFLINE;
	
	if (aStatus == nil) {
		return status;
	}
	
	if( [aStatus isEqualToString:@"offline"] ) {
		status = OFFLINE;
	}else if( [aStatus isEqualToString:@"online"] ) {
		status = ONLINE;
	}else if( [aStatus isEqualToString:@"busy"] ) {
		status = BUSY;
	}else if( [aStatus isEqualToString:@"away"] ) {
		status = AWAY;
	}else if( [aStatus isEqualToString:@"idle"] ) {
		status = IDLE;
	}else if( [aStatus isEqualToString:@"custom"] ) {
		status = IDLE;
	}
	
	return status;
}

+ (NSString*)stringForStatusCode:(MIMStatus)code {
	switch (code) {
		case OFFLINE: return NSLocalizedString(@"Offline", @"");
		case ONLINE: return NSLocalizedString(@"Online", @"");
		case BUSY: return NSLocalizedString(@"Busy", @"");
		case AWAY: return NSLocalizedString(@"Away", @"");
		case IDLE: return NSLocalizedString(@"Idle", @"");
	}
	return @"";
}

+ (int)codeForBlocked:(NSString*)aState {
	if (aState == nil) {
		return 0;
	}
	
	if( [aState isEqualToString:@"yes"] ) {
		return 1;
	}else {
		return 0;
	}
}

@end
