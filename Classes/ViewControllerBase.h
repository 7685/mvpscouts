//
//  ViewControllerBase.h
//  WindowBasedApplication
//
//  Created by Shahil Shah on 12/04/11.
//  Copyright 2011 kraftwebsolutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;
@class SearchFieldsViewController, LinksViewController, MessagesViewController, AccountViewController, FavouritesViewController, SearchViewController;

@interface ViewControllerBase : UIViewController {
    UITabBarController *_tabBarController;
    SearchFieldsViewController *_searchFieldsViewController;
    LinksViewController *_linksViewController;
    MessagesViewController *_messagesViewController;
    AccountViewController *_accountViewController;
    FavouritesViewController *_favouritesViewController;
    SearchViewController *_searchViewController;
}

@end
