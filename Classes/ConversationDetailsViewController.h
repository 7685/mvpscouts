//
//  ConversationDetailsViewController.h
//  WindowBasedApplication
//
//  Created by Shahil Shah on 20/06/12.
//  Copyright (c) 2012 kraftwebsolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cosmonetwork.h"

@interface ConversationDetailsViewController : UITableViewController {
    NSArray *_data;
    CosmoNetwork *cosmoFeaturesnetworkP;
    NSString *_buddyID;
    NSString *_buddyName;
}

@property(nonatomic, retain)NSString *buddyID;
@property(nonatomic, retain)NSString *buddyName;

- (void)loadData;
@end
