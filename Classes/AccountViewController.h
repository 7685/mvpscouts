//
//  AccountViewController.h
//  MVPScouts
//
//  Created by Shahil Shah on 18/05/12.
//  Copyright (c) 2012 kraftwebsolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "downloadpages.h"
#import "cosmonetwork.h"
#import "constants.h"

@interface AccountViewController : UITableViewController <UITextFieldDelegate, UIUpdateProtocol, UIActionSheetDelegate, MFMailComposeViewControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, DownLoadDelegate> {
    UIPickerView *_firstPickerView, *_secondPickerView, *_thirdPickerView;
    NSMutableDictionary *_data;
    UITextField *_dataTextFields[kProfileArraySize];
    UIImageView *_profileImageView;
    CosmoNetwork *cosmoFeaturesnetworkP;
    NSString *_buddyID;
    BOOL _isAccountsPage;
    BOOL _addToFavorite;
    NSMutableArray *_sportsArray;
    NSMutableArray *_positionsArray;
    int _sportIDs[3], _positionIDs[3], _sport[3], _pos[3];
    int _kwsSport[3];
    int _kwsPos[3];
    UITextField *_textFieldForResign;
    UITextView *_userInfoTextView;
    UIBarButtonItem *_editButton;
    UIButton *_acceptSendMsgBtn, *_unfavouriteRejectBtn;
    ParentType _parentType;
}

@property(nonatomic, copy)NSString *buddyID;
@property(nonatomic) BOOL isAccountsPage;
@property(nonatomic) BOOL addToFavorite;
@property(nonatomic) ParentType parentType;

- (void)loadData;
- (void)sendEmail:(NSString*)recipientEmailID;
- (NSString*)getSportPositionString:(int)sportID :(int)positionID :(int)index;
- (UIView *)getHeaderView;
- (void)clearPage;
@end
