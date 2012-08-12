//
//  FavouritesViewController.h
//  MVPScouts
//
//  Created by Shahil Shah on 18/05/12.
//  Copyright (c) 2012 kraftwebsolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyLauncherViewController.h"
#import "cosmonetwork.h"

@class AccountViewController;

@interface FavouritesViewController : MyLauncherViewController <UIUpdateProtocol>{
    NSArray *_data;
    CosmoNetwork *cosmoFeaturesnetworkP;
    AccountViewController *_accountViewController;
    NSMutableArray *buddys;
}

- (void)showFavourites;
- (void)loadData;
@end
