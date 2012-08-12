//
//  ViewController.h
//  WindowBasedApplication
//
//  Created by Shahil Shah on 12/04/11.
//  Copyright 2011 kraftwebsolutions. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController {
	UILabel *lblInfo;
	UIButton *btnGoBack;
}

@property (nonatomic, retain) IBOutlet UILabel *lblInfo;
@property (nonatomic, retain) IBOutlet UIButton *btnGoBack;

-(IBAction) btnClicked:(id)sender;

@end
