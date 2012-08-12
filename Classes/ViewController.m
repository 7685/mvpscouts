    //
//  ViewController.m
//  WindowBasedApplication
//
//  Created by Shahil Shah on 12/04/11.
//  Copyright 2011 kraftwebsolutions. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

@synthesize lblInfo;
@synthesize btnGoBack;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
	
	lblInfo = [[UILabel alloc]initWithFrame:CGRectMake(10, 30, 300, 50)];
	lblInfo.textAlignment = UITextAlignmentCenter;
	lblInfo.font = [UIFont fontWithName:@"Verdana" size:20];
	//lblInfo.text = @"This is sample Page 1\nClick the button below to go to the previous page.";
	lblInfo.text = @"Go Back";
	//lblInfo.tag = 0;
	
	//btnGoBack = [UIButton buttonWithType:UIButtonTypeRoundedRect]initWithFrame:CGRectMake(10, 85, 20, 20)];
	btnGoBack = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	btnGoBack.frame = CGRectMake(10, 90, 300, 40);
	[btnGoBack setTitle:@"Go back to previous page" forState:UIControlStateNormal];
	[btnGoBack setTitle:@"Go back to previous page" forState:UIControlStateReserved];
	[btnGoBack setTitle:@"Go back to previous page" forState:UIControlStateSelected];
	[btnGoBack setTitle:@"Go back to previous page" forState:UIControlStateHighlighted];
	btnGoBack.backgroundColor = [UIColor clearColor];
	[btnGoBack addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
	//btnGoBack.tag = 1;
	contentView.backgroundColor=[UIColor grayColor];

	[contentView addSubview:lblInfo];
	[contentView addSubview:btnGoBack];
	
	self.view = contentView;
	[contentView release];
	[super viewDidLoad];
}

-(IBAction)btnClicked:(id)sender{
	[self.view removeFromSuperview];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
	[lblInfo release];
	[btnGoBack release];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
