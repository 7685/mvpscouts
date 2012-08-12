//
//  ComposeMessageViewController.m
//  WindowBasedApplication
//
//  Created by Shahil Shah on 14/07/12.
//  Copyright (c) 2012 kraftwebsolutions. All rights reserved.
//

#import "ComposeMessageViewController.h"
#import "SHKActivityIndicator.h"
#import <QuartzCore/QuartzCore.h>
#import "constants.h"

@implementation ComposeMessageViewController

@synthesize receiverID = _receiverID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    _composeMesageTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, 300, 250)];
	_composeMesageTextView.autocapitalizationType = UITextAutocapitalizationTypeNone;
	_composeMesageTextView.autocorrectionType = UITextAutocorrectionTypeNo;
	_composeMesageTextView.font = [UIFont boldSystemFontOfSize:15.0];
	_composeMesageTextView.backgroundColor = [UIColor whiteColor];
	_composeMesageTextView.returnKeyType = UIReturnKeySend;
    //The rounded corner part, where you specify your view's corner radius:
    _composeMesageTextView.layer.cornerRadius = 5;
    _composeMesageTextView.clipsToBounds = YES;
	_composeMesageTextView.delegate = self;
	_composeMesageTextView.keyboardType = UIKeyboardTypeEmailAddress;
	_composeMesageTextView.text = @"";
    
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissView)] autorelease];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStyleBordered target:self action:@selector(sendMessage)] autorelease];
    
    [self.view addSubview:_composeMesageTextView];
    self.view.backgroundColor = [UIColor grayColor];
    self.navigationItem.title = @"Compose Message";
}

- (void)dealloc
{
    [_composeMesageTextView release], _composeMesageTextView = nil;
    [super dealloc];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Keyboard delegate event
//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    if([text isEqualToString:@"\n"])
//        [textView resignFirstResponder];
//    return YES;
//}



#pragma mark -
#pragma mark CosmoNetwork callbacks
-(void) UIUpdate:(id)updateP data:(NSString*)dataP {
    [[SHKActivityIndicator currentIndicator] hide];
    [self dismissModalViewControllerAnimated:YES];
//	if ([dataP isEqualToString:@"1"]) {
//        [self dismissModalViewControllerAnimated:YES];
//	}
//    else {
//        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Error" message:@"There was some error. Please try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] autorelease];
//        [alert show];
//    }
}


#pragma mark - custom methods
- (void)dismissView {
    [self dismissModalViewControllerAnimated:YES];
}

-(void)sendMessage {
    [cosmoFeaturesnetworkP release];
	cosmoFeaturesnetworkP = [[CosmoNetwork alloc]init];
	cosmoFeaturesnetworkP.writeToFileB=YES;
    cosmoFeaturesnetworkP.xmlDataB=NO;
    /*    NSString *URL = [NSString stringWithFormat:[URL_BASE stringByAppendingString:URL_SEARCH], _searchBar.text, [[NSUserDefaults standardUserDefaults] valueForKey:NS_USER_ID]];
     [cosmoFeaturesnetworkP loadSection:self url:URL];*/
    NSString *URL = [URL_BASE stringByAppendingString:[NSString stringWithFormat:URL_SEND_MESSAGE, [[NSUserDefaults standardUserDefaults] valueForKey:NS_USER_ID], _receiverID, _composeMesageTextView.text]];
    [cosmoFeaturesnetworkP loadSection:self url:URL];
    NSLog(@"URL :: %@", URL);
    
    [SHKActivityIndicator currentIndicator].frame = CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - 12.5, 
                                                               [[UIScreen mainScreen] bounds].size.height/2 - 12.5, 25, 25);
    [[SHKActivityIndicator currentIndicator] displayActivity:@""];
}
@end
