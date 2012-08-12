//
//  LinksViewController.h
//  MVPScouts
//
//  Created by Shahil Shah on 18/05/12.
//  Copyright (c) 2012 kraftwebsolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cosmonetwork.h"

@interface LinksViewController : UITableViewController <UIUpdateProtocol>{
//    NSArray *_videos, *_schoolOfInterest, *_sportCamps, *_upcomingEvents, *_additionalComments, *_newsArticlesHeadlines;
    CosmoNetwork *cosmoFeaturesnetworkP;
    NSMutableArray *_videosArray, *_newsArticlesArray;
    NSDictionary *_otherInfoDictionary;
}

- (void)loadData;
@end
