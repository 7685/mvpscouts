//
//  WindowBasedApplicationAppDelegate.h
//  WindowBasedApplication
//
//  Created by Shahil Shah on 12/04/11.
//  Copyright 2011 kraftwebsolutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewControllerBase;
//@class UIHudView;

@interface WindowBasedApplicationAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	ViewControllerBase *viewControllerBase;
//    UIHudView *_hudView;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ViewControllerBase *viewControllerBase;
//@property (nonatomic, retain) UIHudView *HUDView;

- (void)createEditableCopyOfDatabaseIfNeeded;
@end

