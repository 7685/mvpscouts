//
//  SearchViewController.h
//  MVPScouts
//
//  Created by Shahil Shah on 18/05/12.
//  Copyright (c) 2012 kraftwebsolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "downloadpages.h"
#import "cosmonetwork.h"

@class AccountViewController;

@interface SearchViewController : UITableViewController <UISearchBarDelegate, UIUpdateProtocol, DownLoadDelegate> {
    AccountViewController *_accountViewController;
    CosmoNetwork *cosmoFeaturesnetworkP;
    UISearchBar *_searchBar;
    NSString *_searchURL;
    NSMutableArray *_data, *_acceptedArray, *_pendingArray, *_requestArray;
    int acceptedCount, pendingCount, requestCount, totalSections;
    BOOL _isFavourites;
}

@property(nonatomic, copy)NSString *searchURL;
@property(nonatomic)BOOL isFavourites;

- (void)loadData;
@end
