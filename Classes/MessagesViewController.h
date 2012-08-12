//
//  MessagesViewController.h
//  MVPScouts
//
//  Created by Shahil Shah on 18/05/12.
//  Copyright (c) 2012 kraftwebsolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "downloadpages.h"
#import "cosmonetwork.h"

@class ConversationDetailsViewController;

@interface MessagesViewController : UITableViewController <UIUpdateProtocol, DownLoadDelegate> {
    CosmoNetwork *cosmoFeaturesnetworkP;
    NSMutableArray *_data;
    ConversationDetailsViewController *_conversationDetailsViewController;
}

- (void)loadData;
@end
