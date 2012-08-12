//
//  SearchFieldsViewController.h
//  WindowBasedApplication
//
//  Created by Shahil Shah on 07/07/12.
//  Copyright (c) 2012 kraftwebsolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#define MAX_FIELDS 6

@class SearchViewController, LoginViewController;

@interface SearchFieldsViewController : UITableViewController <UITextFieldDelegate, 
                                        UIPickerViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate> {
    UITextField *_dataTextFields[MAX_FIELDS];
    UIPickerView *_sportsPickerView, *_positionPickerView, *_statePickerView, *_cityPickerView;
    NSMutableArray *_sportsArray;
    NSMutableArray *_positionsArray;
    NSMutableArray *_stateListArray;
    NSMutableArray *_cityListArray;
    int _sportsArrayIndex;
    int _positionId, _sportsId;
    UIButton *_submitButton;
    SearchViewController *_searchViewController;
    LoginViewController *_loginViewController;
    UITextField *_textFieldForResign;
}

- (void)isLoggedIn;
@end
