    //
//  ViewControllerBase.m
//  WindowBasedApplication
//
//  Created by Shahil Shah on 12/04/11.
//  Copyright 2011 kraftwebsolutions. All rights reserved.
//

#import "ViewControllerBase.h"

#import "AccountViewController.h"
#import "MessagesViewController.h"
#import "FavouritesViewController.h"
#import "SearchViewController.h"
#import "LinksViewController.h"
#import "SearchFieldsViewController.h"
#import "constants.h"

@implementation ViewControllerBase

ViewController *viewController;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    
    _searchFieldsViewController = [[SearchFieldsViewController alloc] initWithStyle:UITableViewStyleGrouped];
    _accountViewController = [[AccountViewController alloc] initWithStyle:UITableViewStyleGrouped];
    _linksViewController = [[LinksViewController alloc] initWithStyle:UITableViewStyleGrouped];
    _messagesViewController = [[MessagesViewController alloc] initWithStyle:UITableViewStylePlain];
    _favouritesViewController = [[FavouritesViewController alloc] init];
    _searchViewController = [[SearchViewController alloc] init];
    
    _accountViewController.parentType = ROOT;
    _accountViewController.isAccountsPage =YES;
    _searchViewController.isFavourites = YES;
    [_searchViewController loadData];
    
    UINavigationController *nav1 = [[[UINavigationController alloc] initWithRootViewController:_searchFieldsViewController] autorelease];
    nav1.tabBarItem.title = @"Search";
    nav1.tabBarItem.image = [UIImage imageNamed:@"Search.png"];
    nav1.navigationBar.tintColor = NAVIGATION_BAR_COLOR;
    //[nav1.navigationBar setBackgroundImage:[UIImage imageNamed:IMG_NAVBAR] forBarMetrics:UIBarMetricsDefault];
    
    UINavigationController *nav2 = [[[UINavigationController alloc] initWithRootViewController:_searchViewController] autorelease];
    nav2.tabBarItem.title = @"Favorites";
    nav2.tabBarItem.image = [UIImage imageNamed:@"Favourite.png"];
    nav2.navigationBar.tintColor = NAVIGATION_BAR_COLOR;
    //[nav2.navigationBar setBackgroundImage:[UIImage imageNamed:IMG_NAVBAR] forBarMetrics:UIBarMetricsDefault];
    
    UINavigationController *nav3 = [[[UINavigationController alloc] initWithRootViewController:_messagesViewController] autorelease];
    nav3.tabBarItem.title = @"Messages";
    nav3.tabBarItem.image = [UIImage imageNamed:@"Chat-Bubble.png"];
    nav3.navigationBar.tintColor = NAVIGATION_BAR_COLOR;
    //[nav3.navigationBar setBackgroundImage:[UIImage imageNamed:IMG_NAVBAR] forBarMetrics:UIBarMetricsDefault];
    
    UINavigationController *nav4 = [[[UINavigationController alloc] initWithRootViewController:_accountViewController] autorelease];
    nav4.tabBarItem.title = @"Account";
    nav4.tabBarItem.image = [UIImage imageNamed:@"User.png"];
    nav4.navigationBar.tintColor = NAVIGATION_BAR_COLOR;
    //[nav4.navigationBar setBackgroundImage:[UIImage imageNamed:IMG_NAVBAR] forBarMetrics:UIBarMetricsDefault];
    
    UINavigationController *nav5 = [[[UINavigationController alloc] initWithRootViewController:_linksViewController] autorelease];
    nav5.tabBarItem.title = @"Links";
    nav5.tabBarItem.image = [UIImage imageNamed:@"Location-Pointer.png"];
    nav5.navigationBar.tintColor = NAVIGATION_BAR_COLOR;
    //[nav5.navigationBar setBackgroundImage:[UIImage imageNamed:IMG_NAVBAR] forBarMetrics:UIBarMetricsDefault];
    
    _tabBarController = [[UITabBarController alloc] init];
    _tabBarController.viewControllers = [NSArray arrayWithObjects:nav1, nav2, nav3, nav4, nav5, nil];
    [contentView addSubview:_tabBarController.view];
	self.view = contentView;
	[contentView release];
    
    
	[super viewDidLoad];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [_messagesViewController release], _messagesViewController = nil;
    [_searchFieldsViewController release], _searchFieldsViewController = nil;
    [_linksViewController release], _linksViewController = nil;
    [_accountViewController release], _accountViewController = nil;
    [_favouritesViewController release], _favouritesViewController = nil;
	[_tabBarController release], _tabBarController=nil;
    [super dealloc];
}

@end
