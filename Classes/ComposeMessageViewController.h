//
//  ComposeMessageViewController.h
//  WindowBasedApplication
//
//  Created by Shahil Shah on 14/07/12.
//  Copyright (c) 2012 kraftwebsolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cosmonetwork.h"

@interface ComposeMessageViewController : UIViewController <UITextViewDelegate>{
    UITextView *_composeMesageTextView;
    CosmoNetwork *cosmoFeaturesnetworkP;
    NSString *_receiverID;
}

@property(nonatomic, copy)NSString *receiverID;
@end
