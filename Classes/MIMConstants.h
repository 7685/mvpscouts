/*
 *  CONST.h
 *  munduIM
 *
 *  Created by Vinay Chavan on 20/07/09.
 *  Copyright 2009 Geodesic Ltd. All rights reserved.
 *
 */

/////////////////////////////////////////////////////////////////////////////////////////
/*!
    @defined    DEVELOPER_MODE
    @abstract   Specifies if application mode is developer or user. Events will not be tracked for developer mode
    @discussion Comment following line when not in developer mode
*/
//#define DEVELOPER_MODE
#define ENABLE_NETWORK_LOG
//#define TEST_USER_ACCOUNTS_MODE

/////////////////////////////////////////////////////////////////////////////////////////
/*!
    @defined    SECURE_PASSWORD_MODE
    @abstract   Specifies if application server uses RC4 for security while login process
    @discussion Comment following line when not using encrypted mode
*/
#define SECURE_PASSWORD_MODE

/////////////////////////////////////////////////////////////////////////////////////////
/*!
    @defined    AVATAR_SUPPORT_MODE
    @abstract   Specifies if application supports buddy display picture support
    @discussion Comment to disable avatars
*/
#define AVATAR_SUPPORT_MODE

///////////////////////////////////////////////////////////////////////////////////////// 
/*!
    @defined    iAD_SUPPORT_MODE
    @abstract   Specifies if application shows iAds in the contact list
    @discussion 
*/
//#define iAD_SUPPORT_MODE

///////////////////////////////////////////////////////////////////////////////////////// 
/*!
 @defined    FILE_TRANSFER_SUPPORT_MODE
 @abstract   Specifies if application supports file transfer
 @discussion 
 */
//#define FILE_TRANSFER_SUPPORT_MODE

///////////////////////////////////////////////////////////////////////////////////////// 
/*!
 @defined    POLL_TIMER_SUPPORT_MODE
 @abstract   Specifies if application supports poll with timer
 @discussion 
 */
//#define POLL_TIMER_SUPPORT_MODE

///////////////////////////////////////////////////////////////////////////////////////// 
// Values for services

#define MIM_SERVICE_SMARSH     @"smarsh"
#define MIM_SERVICE_AIM        @"aim"
#define MIM_SERVICE_FACEBOOK   @"fbkp"
#define MIM_SERVICE_GTALK      @"jab"
#define MIM_SERVICE_MSN        @"msn"
#define MIM_SERVICE_XMPP       @"xmpp"
#define MIM_SERVICE_YAHOO      @"yah"
#define MIM_SERVICE_ICQ        @"icq"

///////////////////////////////////////////////////////////////////////////////////////// 

///////////////////////////////////////////////////////////////////////////////////////// 
// Values for services[prefernces]

#define MIM_SERVICE_SMARSH_DETAILS     @"smarsh"
#define MIM_SERVICE_AIM_DETAILS        @"aim"
#define MIM_SERVICE_FACEBOOK_DETAILS   @"fbkp"
#define MIM_SERVICE_GTALK_DETAILS      @"jab"
#define MIM_SERVICE_MSN_DETAILS        @"msn"
#define MIM_SERVICE_XMPP_DETAILS       @"xmpp"
#define MIM_SERVICE_YAHOO_DETAILS      @"yho"


///////////////////////////////////////////////////////////////////////////////////////// 


#define checkIfNilAndCorrect(value) value ? value : [NSString stringWithString:@""]

#define itos(value) [NSString stringWithFormat:@"%i", value]

#define booltos(value) value?@"true":@"false"

#define shadowVerticalMultiplier [[[UIDevice currentDevice] systemVersion] floatValue] < 3.2f ? -1 : 1

/////////////////////////////////////////////////////////////////////////////////////////
// About screen information
#define kAppStoreReviewURL @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=407228604"
#define kStoreGeoAppsURL   @"http://ax.search.itunes.apple.com/WebObjects/MZSearch.woa/wa/search?entity=software&media=software&page=1&restrict=false&startIndex=0&term=geodesic%20limited"
//#define kAboutUrlUserMan   @"http://www.mundu.com/im/iphone/Mundu_IM_iOS_User_Guide_v1.00.pdf"
#define kAboutUrlUserMan   @"http://www.smarsh.com/"
#define kAboutUrlMundu     @"http://www.smarsh.com/"
#define kAboutVersion      [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define kRC4Key            @"00ae8876c8209787e81d094158a4351172d63297439fab88812d16af6f96869106ceab3901d9624187d9e0a52ed0e6b99344bcfd2597db819d7e00625f52e2b3b527958970b7dc86074700789abba32e1a13d9efece8d4b653a37baae01a065c0d80641b51583fc7cf2614c1d6ab5d237b182d51bd93524038ff0575b16a0718d1"

/////////////////////////////////////////////////////////////////////////////////////////
// Keys to store in NSUserDefaults
#define kRestoreLocationKey              @"kRestoreLocationKey"             // key to obtain our restore location
#define kSessionIdKey                    @"kSessionIdKey"                   // key to access session cookie
#define kApnsTokenIdKey                  @"kApnsTokenIdKey"                 // key to access apns token
#define kBroadcastTokenIdKey             @"kBroadcastTokenIdKey"            // key to access broadcast token 
#define kStatusCodeKey                   @"kStatusCodeKey"                  // key to access current status code
#define kCustomStatusCodeKey             @"kCustomStatusCodeKey"            // key to access current custom status code
#define kCustomStatusMessageKey          @"kCustomStatusMessageKey"         // key to store current custom status messageText
#define kShowOfflineContactsKey          @"kShowOfflineContactsKey"         // preferences key to ON/OFF offline contacts
#define kShowGroupsInContactsKey         @"kShowGroupsInContactsKey"        // preferences key to ON/OFF groups in contact list
#define kSortByStatusEnabledKey          @"kSortByStatusEnabledKey"         // preferences Key to ON/OFF sorted by status
#define kAutoCorrectIMKey                @"kAutoCorrectIMKey"               // preferences Key to ON/OFF auto correction while sending IM
#define kConversationStyleKey            @"kConversationStyleKey"           // preferences key to select conversation style
#define kEnablePushNotificationsKey      @"kEnablePushNotificationsKey"     // preferences key to ON/OFF push notifications
#define kEnableSoundNotificationsKey     @"kEnableSoundNotificationsKey"    // preferences key to ON/OFF sound notifications
#define kEnableMailNotificationsKey      @"kEnableMailNotificationsKey"     // preferences key to ON/OFF mail notifications
#define kInformativeImageDisplayDateKey  @"kInformativeImageDisplayDateKey" // key to access informative image display date
#define kConversationSessionKey          @"kConversationSessionKey"         // key to access current chat conversation session ( service + userid + contactid )
#define kConversationSessionKeyFormat    @"%@:%@:%@"                        // Service, User, Contact
#define kConversationSessionKeySeparator @":"
#define kServerTimeoutPeriod             @"kServerTimeoutPeriod"            // key to access timeout period on server
#define kMovedAwayFromChatScreenKey      @"kMovedAwayFromChatScreenKey"     // Key to check if user has moved away from chat window
#define kNextPollBoxNumber               @"kNextPollBoxNumber"              // key to save the next box number
#define kFavoriteContactsKey             @"kFavoriteContactsKey"            // key to save favorite contacts
#define kCustomStatusMessagesKey         @"kCustomStatusMessagesKey"        // Key to store a list of custom messages
#define kGlobalStatusIsSetKey            @"kGlobalStatusIsSetKey"           // Key to check if global status is set or not
#define kLoginWithPreviousStatusKey      @"kLoginWithPreviousStatusKey"     // Key to check if user should log in with previous status
#define kUseCurrentPlayingStatusKey      @"kUseCurrentPlayingStatusKey"     // Key to check if user has enabled current song as status
#define kAutoFavoritesEnabledKey         @"kAutoFavoritesEnabledKey"        // Key to check if auto favorite is enabled
#define kChatHistoryDurationKey          @"kChatHistoryDurationKey"         // Key to save chat history duration
#define kChatHistoryEnabledKey           @"kChatHistoryEnabledKey"          // Key to check if chat history should be saved or not
#define kRecentMessagesCountKey          @"kRecentMessagesCountKey"         // Key to save recent messages count
#define kRecentMessagesEnabledKey        @"kRecentMessagesEnabledKey"       // Key to check if recent messages should be displayed or not
#define kFacebookAPICode                 @"kFacebookAPICode"                // Key to store facebook API code
#define kFacebookAppSecret               @"kFacebookAppSecret"              // Key to facebook secret code
#define kMobilePolicy                    @"kMobilePolicy"                   // Key to mobile policy
/////////////////////////////////////////////////////////////////////////////////////////
// Notification Constants

#define kSettingsUpdateNotification                 @"kSettingsUpdateNotification"
#define kServerSettingsUpdateNotification           @"kServerSettingsUpdateNotification"
#define kConversationSessionKeyUpdateNotification   @"kConversationSessionKeyUpdateNotification"
#define kFavoriteScreenUpdateNotification           @"kFavoriteScreenUpdateNotification"
#define kIFTweetLabelURLNotification                @"kIFTweetLabelURLNotification"

#define kDatabaseActionRowId                        @"kDatabaseActionRowId"
#define kDatabaseActionType                         @"kDatabaseActionType"
#define kXMPPServer                                 @"kXMPPServer"
#define kXMPPPort                                   @"kXMPPPort"

#define kUserAccountLoggedInNotification            @"kUserAccountLoggedInNotification"
#define kUserAccountLoggedOutNotification           @"kUserAccountLoggedOutNotification"
#define kUserIdKey                                  @"kUserIdKey"
#define kServiceKey                                 @"kServiceKey"

#define kNetworkAvailableNotification               @"kNetworkAvailableNotification"
#define kNetworkUnavailableNotification             @"kNetworkUnavailableNotification"

#define kContactsAvatarUpdateNotification           @"kContactsAvatarUpdateNotification"
#define kUserAvatarUpdateNotification               @"kUserAvatarUpdateNotification"
#define kStatusUpdateNotification                   @"kStatusUpdateNotification"
#define kContactGroupSelectedNotification           @"kContactGroupSelectedNotification"
#define kSelectedContactGroupKey                    @"kSelectedContactGroupKey"
#define kAllAccountsDeletedNotification             @"kAllAccountsDeletedNotification"
#define kAccountScreenIsVisibleNotification         @"kAccountScreenIsVisibleNotification"
#define kLoggedOutShowSmarshNotification            @"kLoggedOutShowSmarshNotification"
#define kPrivateSearchUserReturnedKey               @"kPrivateSearchUserReturnedKey"
#define kPrivateSearchUserListEndedKey              @"kPrivateSearchUserListEndedKey"
#define kUserProfileReceived                        @"kUserProfileReceived"
#define kContactInfoReceived                        @"kContactInfoReceived"
#define kProfileModificationReceived                @"kProfileModificationReceived"
/////////////////////////////////////////////////////////////////////////////////////////
// Privilage states
#define ACCOUNT_DISABLED          @"0"
#define ACCOUNT_ADD_CHAT_RESTRICT @"1"
#define ACCOUNT_ADD_RESTRICTED    @"2"
#define ACCOUNT_FIXED_ACCOUNT     @"3"
#define ACCOUNT_FULL_ACCESS       @"4"
#define ACCOUNT_NOT_VALID         @"5"
/////////////////////////////////////////////////////////////////////////////////////////
// Network related vars

// promo image
#define MIM_INFORMATIVE_IMAGE_URL @"http://im.mundu.com/iphone/promo.jpg"

// args: (NSString*)service, (NSString*)loginid, (NSString*)contactid
#define MIM_REQUEST_FORMAT_AVATAR_LOAD_FROM_CACHE @"http://munduIM/%@/%@/%@.avatar"

// args: (int)box
#define MIM_REQUEST_FORMAT_POLL @"<IM_CLIENT><REQUEST type='poll' box='%@' /></IM_CLIENT>"
// args: (NSString*)service, (NSString*)loginid, (NSString*)password, (NSString*)mech
//#define MIM_REQUEST_FORMAT_LOGIN @"<LOGIN im='%@' login='%@' pass='%@' mech='%@' mode='visible' timeout='180' />"
// args: (NSString*)service, (NSString*)loginid, (NSString*)password, (NSString*)mech, (NSString*)buddyListHash
//#define MIM_REQUEST_FORMAT_LOGIN_WITH_HASH @"<LOGIN im='%@' login='%@' pass='%@' mech='%@' buddylisthash='%@' mode='visible' timeout='180' />"
// args: (NSString*)service, (NSString*)loginid, (NSString*)password, (NSString*)mech, (NSString*)buddyListHash, (NSString*)server, (NSString*)port
#define MIM_REQUEST_FORMAT_LOGIN_WITH_HASH_SERVER @"<LOGIN im='%@' login='%@' pass='%@' mech='%@' buddylisthash='%@' mode='%@' xmpp_server='%@' xmpp_port='%@' email_notification='%@' apns_name='adhoc-smarsh' app_version='3013' client_type='iphone' />"
// args: (NSString*)service, (NSString*)loginid
#define MIM_REQUEST_FORMAT_LOGOUT @"<IM_CLIENT><LOGOUT im='%@' login='%@' /></IM_CLIENT>"
#define MIM_REQUEST_FORMAT_LOGOUT_ALL @"<IM_CLIENT><LOGOUT im=\"all\"/></IM_CLIENT>"
// args: (NSString*)service, (NSString*)loginid, (NSString*)contactid, (NSString*)messageText
#define MIM_REQUEST_FORMAT_MESSAGE_SEND @"<IM_CLIENT><MESSAGE im='%@' login='%@' name='%@' >%@</MESSAGE></IM_CLIENT>"
// args: (NSString*)service, (NSString*)loginid, (NSString*)contactid, (NSString*)group
#define MIM_REQUEST_FORMAT_ADD_CONTACT @"<IM_CLIENT><FRIENDSHIP im='%@' login='%@' name='%@' group='%@' type='add' message='Hi' /></IM_CLIENT>"
// args: (NSString*)service, (NSString*)loginid, (NSString*)contactid, (NSString*)group
#define MIM_REQUEST_FORMAT_DELETE_CONTACT @"<IM_CLIENT><FRIENDSHIP im='%@' login='%@' name='%@' group='%@' type='remove' /></IM_CLIENT>"
// args: (NSString*)service, (NSString*)loginid, (NSString*)contactid, (NSString*)group
#define MIM_REQUEST_FORMAT_BLOCK_CONTACT @"<IM_CLIENT><FRIENDSHIP im='%@' login='%@' name='%@' group='%@' type='block' /></IM_CLIENT>"
// args: (NSString*)service, (NSString*)loginid, (NSString*)contactid, (NSString*)group
#define MIM_REQUEST_FORMAT_UNBLOCK_CONTACT @"<IM_CLIENT><FRIENDSHIP im='%@' login='%@' name='%@' group='%@' type='unblock' /></IM_CLIENT>"
// args: (NSString*)service, (NSString*)loginid, (NSString*)contacti`d, (NSString*)group
#define MIM_REQUEST_FORMAT_AUTHORIZE_CONTACT @"<IM_CLIENT><FRIENDSHIP im='%@' login='%@' name='%@' group='%@' type='authorize' /></IM_CLIENT>"
// args: (NSString*)service, (NSString*)loginid, (NSString*)contactid
#define MIM_REQUEST_FORMAT_DENY_CONTACT @"<IM_CLIENT><FRIENDSHIP im='%@' login='%@' name='%@' type='deny' /></IM_CLIENT>"
// args: (NSInteger)statuscode, (NSString*)custom
#define MIM_REQUEST_FORMAT_PRESENCE @"<IM_CLIENT><STATUS code='%i' custom='%@' /></IM_CLIENT>"
// args: (NSInteger)statuscode, (NSString*)custom, (NSString*)service, (NSString*)loginid
#define MIM_REQUEST_FORMAT_INDIVIDUAL_PRESENCE @"<IM_CLIENT><STATUS code='%i' custom='%@' im='%@' login='%@' /></IM_CLIENT>"
// args: (NSString*)deviceToken in Hex format
#define MIM_REQUEST_FORMAT_PUSH_NOTIFICATION @"<IM_CLIENT><PUSH token='%@' /></IM_CLIENT>"
// args: (NSInteger)time in minutes
#define MIM_REQUEST_FORMAT_TIMEOUT @"<IM_CLIENT><TIMEOUT time='%i' /><SOCKET_TIMEOUT time='%i' /><POLL_TIMEOUT time='%0.2f' /></IM_CLIENT>"
// args: (NSString*)service, (NSString*)loginid, (NSString*)contactid
#define MIM_REQUEST_FORMAT_AVATAR_GET @"<IM_CLIENT><AVATAR im='%@' login='%@' name='%@' type='get' /></IM_CLIENT>"
// args: (NSString*)service, (NSString*)loginid, (NSString*)contactid, (NSString*)fileName, (NSString*)fileSize, (NSString*)Base64 encoded file content
#define MIM_REQUEST_FORMAT_SEND_FILE @"<IM_CLIENT><FILE im='%@' login='%@' name='%@' file_name='%@' file_size='%@' type='send'>%@</FILE></IM_CLIENT>"
// args: (NSString*)service, (NSString*)loginid, (NSString*)contactid, (NSString*)fileName, (NSString*)fileSize, (NSString*)key
#define MIM_REQUEST_FORMAT_ACCEPT_FILE @"<IM_CLIENT><FILE im='%@' login='%@' name='%@' file_name='%@' file_size='%@' key='%@' type='accept' /></IM_CLIENT>"
// args: (NSString*)service, (NSString*)loginid, (NSString*)contactid, (NSString*)fileName, (NSString*)fileSize, (NSString*)key
#define MIM_REQUEST_FORMAT_DENY_FILE @"<IM_CLIENT><FILE im='%@' login='%@' name='%@' file_name='%@' file_size='%@' key='%@' type='deny' /></IM_CLIENT>"
// args: (NSString*)service, (NSString*)loginid, (NSString*)filename, (NSString*)Base64 encoded file content
#define MIM_REQUEST_FORMAT_AVATAR_SET @"<IM_CLIENT><AVATAR im='%@' login='%@' filename='%@' type='set'>%@</AVATAR></IM_CLIENT>"
// args: (NSInteger)tokenid
#define MIM_REQUEST_FORMAT_BROADCAST_TOKEN @"<IM_CLIENT><BROADCAST token='%i' /></BROADCAST></IM_CLIENT>"
// args: (NSString*)service, (NSString*)loginid, (NSString*)contactid, (NSString*)nickname
#define MIM_REQUEST_FORMAT_SET_CONTACT_NICKNAME @"<IM_CLIENT><NICKNAME im='%@' login='%@' name='%@' nickname='%@'/></IM_CLIENT>"
#define MIM_REQUEST_FORMAT_PRIVATE_SEARCH @"<IM_CLIENT><SEARCH_BUDDY im='smarsh' login='%@' name='%@' nickname='%@' firstname='%@' lastname='%@' email='%@' onlineflag='%@'></SEARCH_BUDDY></IM_CLIENT>"
#define MIM_REQUEST_FORMAT_GROUP_MANAGEMENT @"<IM_CLIENT><GROUP im='%@' login='%@' type='%@' group='%@' contact='%@' newgroup='%@' im_specific='%@' /></IM_CLIENT>"
#define MIM_REQUEST_FORMAT_PROFILE @"<IM_CLIENT><PROFILE login='%@' im='%@' action='%@' fname='%@' lname='%@' email='%@' auth_req='%@' presence_notify='%@' hide_email='%@' /></IM_CLIENT>"
#define MIM_REQUEST_FORMAT_CONTACT_INFO @"<IM_CLIENT><CONTACT_INFO im='%@' login='%@' name='%@'/></IM_CLIENT>"
#define MIM_REQUEST_FORMAT_MESSAGE_LOG @"<IM_CLIENT><MSGLOG im='%@' login='%@' name='%@' service='%@' type='%@'>%@</MSGLOG></IM_CLIENT>"
#define MIM_REQUEST_FORMAT_SAVE_ACCOUNT @"<IM_CLIENT><ACCOUNT_LIST im='smarsh' login='%@' action='set' service='%@' name='%@' password='%@' /></IM_CLIENT>"
/////////////////////////////////////////////////////////////////////////////////////////
//Values for Event tracking in google Analytics

#define CATEGORY_LOGIN                 @"Login"
#define CATEGORY_VIEW_CHAT_ARCHIVE     @"Archive"
#define CATEGORY_CHAT_STYLE            @"ChatStyle"
#define CATEGORY_VISIT_ABOUT_PAGE      @"About"
#define CATEGORY_VIEW_OFFLINE_CONTACTS @"OfflineContacts"
#define CATEGORY_CONTACTS_VIEW         @"ContactGroups"
#define CATEGORY_PUSH_NOTIFICATIONS    @"PushNotifications"
#define CATEGORY_SOUND_NOTIFICATIONS   @"SoundNotifications"
#define CATEGORY_MAIL_NOTIFICATIONS    @"MailNotifications"

/////////////////////////////////////////////////////////////////////////////////////////
/*!
    @enum       MIMStatus
    @abstract   Used for storing and rendering status information.
    @discussion Used in UserAccount, Contact
    @constant   ONLINE    Available
                BUSY      Busy
				AWAY      Away - Idle
                IDLE      Idle
                OFFLINE   Offline
*/

enum {
	ONLINE = 0,
	BUSY = 1,
	AWAY = 2,
	INVISIBLE = 3,
	OFFLINE = 4,
	IDLE = 5,
	BLOCKED = 6,
};
typedef NSUInteger MIMStatus;

/////////////////////////////////////////////////////////////////////////////////////////
// MIMUserAccountProgressCode

enum MIMUserAccountProgressCode {
	MIMUserAccountProgressCodeNotConnected = 0,
	MIMUserAccountProgressCodeConnectedToServer = 100,
	MIMUserAccountProgressCodeGotChallenge = 101,
	MIMUserAccountProgressCodeAthenticated = 102,
	MIMUserAccountProgressCodeGettingBuddyList = 103,
	MIMUserAccountProgressCodeLoginComplete = 104
};
typedef NSInteger MIMUserAccountProgressCode;

/////////////////////////////////////////////////////////////////////////////////////////
// MIMChatState

enum MIMChatState {
	MIMChatStateUnread = 0,
	MIMChatStateOpen = 1,
	MIMChatStateNoChat = 2
};
typedef NSInteger MIMChatState;

/////////////////////////////////////////////////////////////////////////////////////////
// MIMSubscriptionState

enum MIMSubscriptionState {
	MIMSubscriptionStateNonExisting = -1,
	MIMSubscriptionStateMutual = 0,
	MIMSubscriptionStatePending = 1,
	MIMSubscriptionStateDenied = 2,
	MIMSubscriptionStateUnknown = 3,
	MIMSubscriptionStateAuto = 4
};
typedef NSInteger MIMSubscriptionState;

/////////////////////////////////////////////////////////////////////////////////////////
// MIMMessageType

enum MIMMessageType {
	MIMMessageTypeSent = 0,
	MIMMessageTypeReceived = 1,
	MIMMessageTypeStatusUpdate = 2,
	MIMMessageTypeInformation = 3, // Timestamp etc.
	MIMMessageTypeTypingNotification = 4,
	MIMMessageTypeUnknown = 5
};
typedef NSInteger MIMMessageType;

/////////////////////////////////////////////////////////////////////////////////////////
// MIMMessageDisplayType

enum MIMMessageDisplayType {
	MIMMessageDisplayText = 0,          // Displays whatever text is there
	MIMMessageDisplayImage = 1,             // Displays image preview of file-path stored in text
};
typedef NSInteger MIMMessageDisplayType;

/////////////////////////////////////////////////////////////////////////////////////////
// MIMScreenType

enum MIMScreenType { //shahil - to hide favorites view
	MIMScreenTypeContacts = 0,
	MIMScreenTypeChats = 1,
	MIMScreenTypeSettings = 2,
	MIMScreenTypeConversation = 3,
	MIMScreenTypeFavorites = 4,
};
typedef NSInteger MIMScreenType;

/////////////////////////////////////////////////////////////////////////////////////////
// UIConversationMessageCellStyle

enum UIConversationMessageCellStyle {
	UIConversationMessageCellBubble = 0,
	UIConversationMessageCellStripe = 1,
	UIConversationMessageCellBubbleWithAvatar = 2,
};
typedef NSInteger UIConversationMessageCellStyle;

/////////////////////////////////////////////////////////////////////////////////////////
// MIMServerTimeoutPeriod

enum MIMServerTimeoutPeriod {
	MIMServerTimeoutPeriod_15 = 0,
	MIMServerTimeoutPeriod_30 = 1,
	MIMServerTimeoutPeriod_60 = 2,
	MIMServerTimeoutPeriod_120 = 3,
	MIMServerTimeoutPeriod_240 = 4,
	MIMServerTimeoutPeriod_720 = 5,
	MIMServerTimeoutPeriod_1440 = 6,
	MIMServerTimeoutPeriod_4320 = 7,
};
typedef NSInteger MIMServerTimeoutPeriod;

/////////////////////////////////////////////////////////////////////////////////////////
// MIMChatHistoryDuration

enum MIMChatHistoryDuration {
	MIMChatHistoryDuration_7 = 0,
	MIMChatHistoryDuration_15 = 1,
	MIMChatHistoryDuration_30 = 2,
	MIMChatHistoryDuration_90 = 3,
	MIMChatHistoryDuration_Forever = 4
};
typedef NSInteger MIMChatHistoryDuration;

/////////////////////////////////////////////////////////////////////////////////////////
// MIMRecentMessagesCount

enum MIMRecentMessagesCount {
	MIMRecentMessagesCount_5 = 0,
	MIMRecentMessagesCount_10 = 1,
	MIMRecentMessagesCount_15 = 2
};
typedef NSInteger MIMRecentMessagesCount;

