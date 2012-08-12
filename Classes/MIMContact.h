//
//  MIMContact.h
//  munduIM
//
//  Created by Vinay Chavan on 18/07/09.
//  Copyright 2009 Home. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MIMConstants.h"

@interface MIMContact : NSObject {
	NSInteger _uid;
	NSString * _service;
	NSString * _contact_id;
	NSString * _user_id;
	NSString * _alias;
	NSString * _avatar;
	NSString * _group;
	NSString * _custom_status;
	MIMStatus _status;
	BOOL _blocked;
	MIMChatState _chat_state;
	MIMSubscriptionState _subscription_state;
	NSInteger _last_read_message_uid;
	NSInteger _unread_messages;
	BOOL _is_favorite;
	NSInteger _address_book_id;
	MIMStatus _user_status;
	NSString *_subscription;
}

@property (nonatomic, assign) NSInteger uid;
@property (readonly) NSString * title;
@property (nonatomic, copy) NSString * contactId;
@property (nonatomic, copy) NSString * service;
@property (nonatomic, copy) NSString * userId;
@property (nonatomic, copy) NSString * alias;
@property (nonatomic, copy) NSString * avatar;
@property (nonatomic, copy) NSString * subscription;
@property (assign) MIMStatus status;
@property (nonatomic, copy) NSString * customStatus;
@property (nonatomic, copy) NSString * group;
@property (assign) BOOL isBlocked;
@property (assign) MIMChatState chatState;
@property (assign) MIMSubscriptionState subscriptionState;
@property (nonatomic, assign) NSInteger lastReadMessageUid;
@property (nonatomic, assign) NSInteger unreadMessages;
@property (assign) BOOL isFavorite;
@property (nonatomic, assign) NSInteger addressBookID;
@property (assign) MIMStatus userStatus; // Cant use it as of now

- (id) initContact:(NSString*)aContact user:(NSString*)aUser service:(NSString*)aService;

- (NSString*)key;

+ (int)codeForStatus:(NSString*)aStatus;
+ (int)codeForBlocked:(NSString*)aState;
+ (NSString*)stringForStatusCode:(MIMStatus)code;

@end
