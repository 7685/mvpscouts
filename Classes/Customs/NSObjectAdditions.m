//
//  NSObjectAdditions.m
//  munduIM
//
//  Created by Vinay Chavan on 06/11/10.
//  Copyright 2010 Vinay Chavan. All rights reserved.
//

#import "NSObjectAdditions.h"
#import "WindowBasedApplicationAppDelegate.h"

@implementation NSObject(UIHudView)

+ (void)showHUDViewWithTitle:(NSString*)title image:(UIImage*)image shouldShowActivity:(BOOL)shouldShowActivity shouldAutoHide:(BOOL)shouldAutoHide {
	[(WindowBasedApplicationAppDelegate*)[[UIApplication sharedApplication] delegate] showHUDViewWithTitle:title
																					  image:image
																		   shouldShowActivity:shouldShowActivity
																			 shouldAutoHide:shouldAutoHide];
}

+ (void)hideHUDView {
	[(WindowBasedApplicationAppDelegate*)[[UIApplication sharedApplication] delegate] hideHUDView];
}

+ (BOOL)isNetworkAvailable {
	return NO;
//	return ((WindowBasedApplicationAppDelegate*)[UIApplication sharedApplication].delegate).isNetworkAvailable;
}


+ (void)registerForRemoteNotification {
	[(WindowBasedApplicationAppDelegate*)[[UIApplication sharedApplication] delegate] registerForRemoteNotification];
}

@end
