/*
 *  UIConstants.h
 *  munduIM
 *
 *  Created by Vinay Chavan on 11/10/10.
 *  Copyright 2010 Geodesic Ltd. All rights reserved.
 *
 */

#define shadowVerticalMultiplier [[[UIDevice currentDevice] systemVersion] floatValue] < 3.2f ? -1 : 1

#define shouldEnableCopyOption [[[UIDevice currentDevice] systemVersion] floatValue] <= 3.2f ? NO : YES

#define kConversationSystemFontSize   16
#define kTableViewCellRowHeight       54
#define kMessageBackgroundColor       [UIColor colorWithRed:0.886 green:0.910 blue:0.945 alpha:1.0]
#define kEditableTextColor            [UIColor colorWithRed:0.220 green:0.329 blue:0.529 alpha:1.0]

#define kNavigationbarTintColor       nil
//#define kNavigationbarTintColor       [UIColor colorWithRed:0.06 green:0.44 blue:0.80 alpha:1.0]
//#define kNavigationbarTintColor       [UIColor colorWithWhite:0.15 alpha:1]
//#define kNavigationbarTintColor       [UIColor colorWithRed:0.378 green:0.165 blue:0 alpha:1.0]

#define kTableViewCellSelectionStyle UITableViewCellSelectionStyleBlue

#define shouldOutOfflineContacts YES

/////////////////////////////////////////////////////////////////////////////////////////
// Rendering constants

#define NAME_FONT_SIZE 18
#define MIN_NAME_FONT_SIZE 16

#define DETAIL_FONT_SIZE 13
#define MIN_DETAIL_FONT_SIZE 13
