//
//  NSObjectAdditions.h
//  munduIM
//
//  Created by Vinay Chavan on 06/11/10.
//  Copyright 2010 Vinay Chavan. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSObject(UIHudView)

+ (void)showHUDViewWithTitle:(NSString*)title image:(UIImage*)image shouldShowActivity:(BOOL)shouldShowActivity shouldAutoHide:(BOOL)shouldAutoHide;

+ (void)hideHUDView;

+ (BOOL)isNetworkAvailable;

+ (void)registerForRemoteNotification;

@end
