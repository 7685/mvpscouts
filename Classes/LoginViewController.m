//
//  LoginViewController.m
//  WindowBasedApplication
//
//  Created by Shahil Shah on 20/05/12.
//  Copyright (c) 2012 kraftwebsolutions. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import "SHKActivityIndicator.h"
#import "SBJson.h"
#import "constants.h"

#define kLeftMargin				10.0
#define kTopMargin				10.0
#define kTextFieldWidth			270.0
#define kTextFieldHeight		25.0

@implementation LoginViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    _usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(kLeftMargin, kTopMargin, kTextFieldWidth, kTextFieldHeight)];
	_usernameTextField.placeholder = PLACEHOLDER_USERNAME;
	_usernameTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
	_usernameTextField.autocorrectionType = UITextAutocorrectionTypeNo;
	_usernameTextField.borderStyle = UITextBorderStyleNone;
	_usernameTextField.font = [UIFont boldSystemFontOfSize:15.0];
	_usernameTextField.minimumFontSize = 12;
	_usernameTextField.adjustsFontSizeToFitWidth = YES;
	_usernameTextField.backgroundColor = [UIColor clearColor];
	_usernameTextField.returnKeyType = UIReturnKeyNext;
	_usernameTextField.delegate = self;
	_usernameTextField.keyboardType = UIKeyboardTypeEmailAddress;
	_usernameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
	_usernameTextField.text = @"";
	
	_passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(kLeftMargin, kTopMargin, kTextFieldWidth, kTextFieldHeight)];
	_passwordTextField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	_passwordTextField.secureTextEntry = YES;
	_passwordTextField.placeholder = PLACEHOLDER_PASSWORD;
	_passwordTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
	_passwordTextField.autocorrectionType = UITextAutocorrectionTypeNo;
	_passwordTextField.borderStyle = UITextBorderStyleNone;
	_passwordTextField.font = [UIFont boldSystemFontOfSize:15.0];
	_passwordTextField.minimumFontSize = 12;
	_passwordTextField.adjustsFontSizeToFitWidth = YES;
	_passwordTextField.backgroundColor = [UIColor clearColor];
	_passwordTextField.returnKeyType = UIReturnKeyDone;
	_passwordTextField.delegate = self;
	_passwordTextField.keyboardType = UIKeyboardTypeDefault;	
	_passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
	_passwordTextField.text = @"";

    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Register" style:UIBarButtonItemStyleBordered target:self action:@selector(registerButtonClicked)] autorelease];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc {
    [_usernameTextField release], _usernameTextField = nil;
    [_passwordTextField release], _passwordTextField = nil;
    [_submitButton release], _submitButton = nil;
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        cell.accessoryView = _usernameTextField;
    }
    else {
        cell.accessoryView = _passwordTextField;
    }
    // Configure the cell...
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectZero];
    _submitButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
	_submitButton.frame = CGRectMake(10, 10, 300, 40);
    [_submitButton setTitle:@"Login" forState:UIControlStateNormal];
    [_submitButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:_submitButton];
	return [contentView autorelease];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

#pragma Custom methods
- (void)registerButtonClicked {
    RegisterViewController *registerViewController = [[[RegisterViewController alloc] initWithStyle:UITableViewStyleGrouped] autorelease];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:registerViewController];
    [self.navigationController pushViewController:nav animated:YES];
}

- (NSString *)md5:(NSString *)str { 
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH]; 
    CC_MD5(cStr, strlen(cStr), result); 
    return [NSString stringWithFormat: @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",                     
			result[0], result[1], result[2], result[3],
			result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11],
			result[12], result[13], result[14], result[15]];        
}

- (void)login {
    [cosmoFeaturesnetworkP release];
	cosmoFeaturesnetworkP = [[CosmoNetwork alloc]init];
	cosmoFeaturesnetworkP.writeToFileB=NO;
    cosmoFeaturesnetworkP.mainTag=@"login";
    cosmoFeaturesnetworkP.xmlDataB=NO;
    NSString *URL = [NSString stringWithFormat:[URL_BASE stringByAppendingString:URL_LOGIN], _usernameTextField.text, [self md5:_passwordTextField.text], [[NSUserDefaults standardUserDefaults] valueForKey:NS_DEVICE_TOKEN]];
    [cosmoFeaturesnetworkP loadSection:self url:URL];
    NSLog(@"URL :: %@", URL);
    [SHKActivityIndicator currentIndicator].frame = CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - 12.5, 
                                                               [[UIScreen mainScreen] bounds].size.height/2 - 12.5, 25, 25);
    [[SHKActivityIndicator currentIndicator] displayActivity:@""];
}

#pragma mark -
#pragma mark CosmoNetwork callbacks
-(void) UIUpdate:(id)updateP data:(NSString*)dataP {
    [[SHKActivityIndicator currentIndicator] hide];
	if ([dataP isEqualToString:@"success"]) {
        //NSLog(@"success");
        SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
        NSError *error;
        NSString *jsonString = [[[NSString alloc]initWithData:[cosmoFeaturesnetworkP dataP] encoding:NSUTF8StringEncoding] autorelease];
        NSMutableDictionary *data = [jsonParser objectWithString:jsonString error:&error];
        if ([[[data valueForKey:@"active"] stringValue] isEqualToString:@"1"]) {
            UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Account Inactive" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] autorelease];
            [alert show];
            return;
        }
        else if ([[[data valueForKey:@"active"] stringValue] isEqualToString:@"2"]) {
            UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Error" message:@"Incorrect username or password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] autorelease];
            [alert show];
            return;
        }
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Success" message:[NSString stringWithFormat:@"Welcome, %@", [data valueForKey:JSONTAG_FIRSTNAME]] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] autorelease];
        [alert show];
        //NSLog(@"username :: %@", [data valueForKey:@"first_name"]);
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:NS_IS_USER_LOGGED_IN];
        [[NSUserDefaults standardUserDefaults] setObject:[data valueForKey:JSONTAG_USERID] forKey:NS_USER_ID];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kReloadData object:self userInfo:nil];
                
        [self dismissModalViewControllerAnimated:YES];
	}
}

@end
