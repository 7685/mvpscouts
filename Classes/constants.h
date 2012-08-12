//
//  constants.h
//  WindowBasedApplication
//
//  Created by Shahil Shah on 19/05/12.
//  Copyright (c) 2012 kraftwebsolutions. All rights reserved.
//

typedef enum parentType {
    ROOT,
    FAVOURITE_SEARCH,
    FAVOURITE_ADDED,
    FAVOURITE_REQUEST,
    FAVOURITE_FOLLOWING
} ParentType;

#define DATABASE_FILE_NAME @"database.sqlite"


//font related
#define FONT_NAME @"Verdana"
#define FONT_HEIGHT 16

//SQL queries
#define SQL_GET_SPORTS @"SELECT id, sports_type FROM sports_category WHERE sports_type<>''"
#define SQL_GET_POSITIONS @"SELECT id, sports_position FROM sports_category WHERE pid=%@"
#define SQL_GET_STATES @"SELECT DISTINCT state FROM zipcode"
#define SQL_GET_CITIES @"SELECT DISTINCT city FROM zipcode WHERE state='%@'"

#define NAVIGATION_BAR_COLOR [UIColor colorWithRed:0.075 green:0.247 blue:0.434 alpha:1] // HTML code #299AF7
#define IMG_NAVBAR @"navBar.png"
#define IMG_DEFAULT_AVATAR @"default_avatar.png"

//sizes
#define HEIGHT_SEARCH_BAR 44

//Array Size constants
#define kProfileArraySize 25
#define kPlayerProfileCount 17
#define kPlayerParentInfoCount 2
#define kPlayerCoachInfoCount 2

//NSUserDefaults
#define NS_IS_USER_LOGGED_IN @"IS_USER_LOGGED_IN"
#define NS_USER_ID @"USER_ID"
#define NS_DEVICE_TOKEN @"DEVICE_TOKEN"

//Notifications
#define kLogoutNotification @"LOGOUT"
#define kReloadData @"RELOAD_DATA"
#define kReloadFavourites @"RELOAD_FAVOURITES"

//call type constants
#define REMOVE_FROM_FAVOURITE @"REMOVE_FROM_FAVORITE"
#define ADD_TO_FAVORITE @"ADD_TO_FAVORITE"
#define REJECT_FAVOURITE @"REJECT_FAVOURITE"
#define ACCEPT_FAVOURITE @"ACCEPT_FAVOURITE"

//placeholders
#define PLACEHOLDER_USERNAME @"email id"
#define PLACEHOLDER_PASSWORD @"password"

//string constants
#define BLANK_STRING @""

//URLs
#define URL_BASE @"http://www.mvpscouts.com/api/"
#define URL_LOGIN @"login.php?email=%@&password=%@&device_token=%@"
#define URL_PROFILE @"profile.php?userid=%@&action=%@"
#define URL_MESSAGES @"messages.php?id=%@"
#define URL_ALL_MESSAGES @"all-messages.php?id=%@&buddy_id=%@"
#define URL_SEARCH @"search.php?search=%@&id=%@"
#define URL_SEARCH_ADVANCED @"search.php?name=%@&sport=%d&position=%d&state=%@&city=%@&year=%@&id=%@"
#define URL_ADD_TO_FAVORITE @"add-to-favorite.php?id=%@&player_id=%@"
#define URL_FAVOURITES @"get-favourites.php?id=%@"
#define URL_SEND_MESSAGE @"send-message.php?userid=%@&receiver_id=%@&message=%@"
#define URL_GET_LINKS @"get-links.php?id=%@"
#define URL_YOUTUBE @"http://www.youtube.com/embed/%@"
#define URL_FAVOURITE_OPERATION @"favourites-operation.php?userid=%@&buddy_id=%@&operation=%@"
//#define URL_SAVE_PROFILE @"save-profile.php?id=%@&first_name=%@&last_name=%@&dob_year=%@&dob_month=%@&dob_day=%@&school_name=%@&class_end_year=%@&state=%@&city=%@&zip=%@&contact_no=%@&fax_no=%@&parent_email=%@&parent_phno=%@&facebook_url=%@&twitter_url=%@&height=%@&weight=%@&bench=%@&squat=%@&time_40=%@&coach_email=%@&coach_phno=%@&sports1=%@&position1=%@&sports2=%@&position2=%@&sports3=%@&position3=%@"

//JSON Tags
#define JSONTAG_USERID @"userid" // @"46
#define JSONTAG_FIRSTNAME @"first_name" // @"MVP Scouts 
#define JSONTAG_LASTNAME @"last_name" // @"Moderator
#define JSONTAG_EMAIL @"email" // @"support@mvpscouts.com
#define JSONTAG_USERTYPE @"user_type" // @"Scout / Coach
#define JSONTAG_DOB @"dob" // @"2012/04/06
#define JSONTAG_DOB_YEAR @"dob_year" // @"2012
#define JSONTAG_DOB_MONTH @"dob_month" // @"04
#define JSONTAG_DOB_DAY @"dob_day" // @"06
#define JSONTAG_SCHOOL @"school_name" // @"MVP Scouts Moderator
#define JSONTAG_CLASS_END_YEAR @"class_end_year" // @"
#define JSONTAG_STATE @"state" // @"
#define JSONTAG_CITY @"city" // @"
#define JSONTAG_ZIP @"zip" // @"
#define JSONTAG_CONTACT_NO @"contact_no" // @"
#define JSONTAG_FAX_NO @"fax_no" // @"
#define JSONTAG_PARENT_EMAIL @"parent_email" // @"
#define JSONTAG_PARENT_PHONE @"parent_phno" // @"
#define JSONTAG_FB_URL @"facebook_url" // @"
#define JSONTAG_TWITTER_URL @"twitter_url" // @"
#define JSONTAG_HEIGHT @"height" // @"
#define JSONTAG_WEIGHT @"weight" // @"
#define JSONTAG_BENCH @"bench" // @"
#define JSONTAG_SQUAT @"squat" // @"
#define JSONTAG_TIME_40 @"time_40" // @"
#define JSONTAG_SPORTS1 @"sports1" // @"0
#define JSONTAG_POSITION1 @"position1" // @"0
#define JSONTAG_SPORTS2 @"sports2" // @"0
#define JSONTAG_POSITION2 @"position2" // @"0
#define JSONTAG_SPORTS3 @"sports3" // @"0
#define JSONTAG_POSITION3 @"position3" // @"0
#define JSONTAG_PROFILE_PHOTO @"profile_photo" // @"
#define JSONTAG_COACH_EMAIL @"coach_email" // @"
#define JSONTAG_COACH_PHONE @"coach_phno" // @""
#define JSONTAG_LOCAL_PROFILE_PHOTO @"local_profile_photo"
#define JSONTAG_VIDEO @"video"
#define JSONTAG_VIDEOS @"videos"
#define JSONTAG_NEWS_ARTICLES @"news_articles"
#define JSONTAG_OTHER_INFO @"other_info"
#define JSONTAG_VIDEO_TITLE @"video_title"
#define JSONTAG_POST_DATE @"post_date"
#define JSONTAG_NEWS_LINK @"news_link"
#define JSONTAG_NEWS_DETAIL @"news_detail"
#define JSONTAG_POST_DT @"post_dt"
#define JSONTAG_EVENTS_ATTENDED @"events_attened"
#define JSONTAG_ADDITIONAL_SKILS @"additional_skills"
#define JSONTAG_UPCOMING_EVENTS @"upcoming_event"
#define JSONTAG_SCHOOL_INTEREST @"school_interest"
#define JSONTAG_NEWS_TITLE @"news_title"
