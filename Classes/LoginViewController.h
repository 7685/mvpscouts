//
//  LoginViewController.h
//  WindowBasedApplication
//
//  Created by Shahil Shah on 20/05/12.
//  Copyright (c) 2012 kraftwebsolutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cosmonetwork.h"

@interface LoginViewController : UITableViewController <UITextFieldDelegate, UIUpdateProtocol> {
    UITextField *_usernameTextField;
    UITextField *_passwordTextField;
    UIButton *_submitButton;
    CosmoNetwork *cosmoFeaturesnetworkP;
}

@end
