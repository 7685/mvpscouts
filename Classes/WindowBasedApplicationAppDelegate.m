//
//  WindowBasedApplicationAppDelegate.m
//  WindowBasedApplication
//
//  Created by Shahil Shah on 12/04/11.
//  Copyright 2011 kraftwebsolutions. All rights reserved.
//

#import "WindowBasedApplicationAppDelegate.h"
#import "ViewControllerBase.h"
#import "cosmonetwork.h"
#import "constants.h"
//#import "UIHudView.h"

@implementation WindowBasedApplicationAppDelegate

@synthesize window;
@synthesize viewControllerBase;
//@synthesize HUDView = _hudView;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
    [self createEditableCopyOfDatabaseIfNeeded];
    [CosmoNetwork copyExistingFile];
	viewControllerBase = [[ViewControllerBase alloc]initWithNibName:nil bundle:nil];
	[self.window addSubview:viewControllerBase.view];
    [self.window makeKeyAndVisible];
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken 
{
    NSString *deviceTokenStr = [[[[deviceToken description]
                               stringByReplacingOccurrencesOfString: @"<" withString: @""] 
                              stringByReplacingOccurrencesOfString: @">" withString: @""] 
                             stringByReplacingOccurrencesOfString: @" " withString: @""];

    [[NSUserDefaults standardUserDefaults] setValue:deviceTokenStr forKey:NS_DEVICE_TOKEN];
    
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)err
{     
    NSString *str = [NSString stringWithFormat:@"Error %@", err];
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:NS_DEVICE_TOKEN];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo 
{
    //
}
#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [window release];
    [super dealloc];
}
/*
#pragma mark -
#pragma mark UIHudView

- (void)showHUDViewWithTitle:(NSString*)title image:(UIImage*)image shouldShowActivity:(BOOL)shouldShowActivity shouldAutoHide:(BOOL)shouldAutoHide {
	if (self.HUDView == nil) {
		self.HUDView = [[UIHudView alloc] initWithFrame:CGRectMake(0, 0, 160, 120)];
		
		self.HUDView.backgroundColor = [UIColor clearColor];
		[self.window addSubview:self.HUDView];
	}
	
	self.HUDView.center = self.window.center;
	[self.window bringSubviewToFront:self.HUDView];
	
	[self.HUDView setShouldShowActivityIndicator:shouldShowActivity];
	[self.HUDView setTitle:title];
	[self.HUDView setImage:image];
	[self.HUDView show];
	
	if (shouldAutoHide) {
		[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hideHUDView) object:nil];
		[self performSelector:@selector(hideHUDView) withObject:nil afterDelay:1.5];
	}
}

- (void)hideHUDView {
	[self.HUDView hide];
}
*/

#pragma mark - custom methods
// Creates a writable copy of the bundled default database in the application Documents directory.
- (void)createEditableCopyOfDatabaseIfNeeded {
    // First, test for existence.
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:DATABASE_FILE_NAME];
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (success) return;
    // The writable database does not exist, so copy the default to the appropriate location.
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DATABASE_FILE_NAME];
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if (!success) {
        NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
}

@end
