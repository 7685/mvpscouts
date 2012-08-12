//
//  ConversationDetailsViewController.m
//  WindowBasedApplication
//
//  Created by Shahil Shah on 20/06/12.
//  Copyright (c) 2012 kraftwebsolutions. All rights reserved.
//

#import "ConversationDetailsViewController.h"
#import "DetailedConversationTableViewCell.h"
#import "ComposeMessageViewController.h"
#import "SHKActivityIndicator.h"
#import "UIConstants.h"
#import "SBJsonParser.h"
#import "constants.h"

@implementation ConversationDetailsViewController

@synthesize buddyID = _buddyID, buddyName = _buddyName;

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
    self.navigationItem.title = _buddyName;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popToRootView) name:kReloadData object:nil];
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.tableView.separatorColor = [UIColor clearColor];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(composeMessage)] autorelease];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
    if (_data!= nil) {
        return [_data count];
    }
    return 0;
}

//---calculate the height for the message---
/*-(CGFloat) labelHeight:(NSString *) text {
	CGSize maximumLabelSize = CGSizeMake((bubbleFragment_width * 3) - 25,9999);
	CGSize expectedLabelSize = [text sizeWithFont:[UIFont systemFontOfSize: kAccountDetailFontSize] 
								constrainedToSize:maximumLabelSize 
									lineBreakMode:UILineBreakModeWordWrap]; 
	return expectedLabelSize.height;
}*/

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = [_data objectAtIndex:indexPath.row];
    CGSize maximumLabelSize = CGSizeMake(300,9999);
    CGSize expectedLabelSize = [[dict valueForKey:@"sender_mesg"] sizeWithFont:[UIFont systemFontOfSize:18] 
								constrainedToSize:maximumLabelSize 
									lineBreakMode:UILineBreakModeWordWrap]; 
    return expectedLabelSize.height+20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    DetailedConversationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[DetailedConversationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    NSDictionary *dict = [_data objectAtIndex:indexPath.row];
    [cell setData:@"" message:[dict valueForKey:@"sender_mesg"]];
    
    if ([[dict valueForKey:@"receiver_id"] isEqualToString:_buddyID]) {
        //cell.backgroundColor = [UIColor colorWithRed:(173/255) green:(216/255) blue:(230/255) alpha:0.5];
/*        UIView* bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
        bgview.opaque = YES;
        bgview.backgroundColor = [UIColor colorWithRed:(173/255) green:(216/255) blue:(230/255) alpha:0.5];
        [cell setBackgroundView:bgview];
*/
        [cell setChatColor:[UIColor redColor]];
    }
    else {
/*        UIView* bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
        bgview.opaque = YES;
        bgview.backgroundColor = [UIColor whiteColor];
        [cell setBackgroundView:bgview];*/
        [cell setChatColor:[UIColor grayColor]];
    }
    return cell;
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

#pragma mark - custom methods
- (void)loadData {
    [cosmoFeaturesnetworkP release];
	cosmoFeaturesnetworkP = [[CosmoNetwork alloc]init];
	cosmoFeaturesnetworkP.writeToFileB=YES;
    cosmoFeaturesnetworkP.mainTag=@"profile";
    cosmoFeaturesnetworkP.xmlDataB=NO;
    NSString *URL = [NSString stringWithFormat:[URL_BASE stringByAppendingString:URL_ALL_MESSAGES], [[NSUserDefaults standardUserDefaults] valueForKey:NS_USER_ID], _buddyID];
    [cosmoFeaturesnetworkP loadSection:self url:URL];
    NSLog(@"URL :: %@", URL);
    [SHKActivityIndicator currentIndicator].frame = CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - 12.5, 
                                                               [[UIScreen mainScreen] bounds].size.height/2 - 12.5, 25, 25);
    [[SHKActivityIndicator currentIndicator] displayActivity:@""];
}

- (void)composeMessage {
    ComposeMessageViewController *composeMessageVC = [[[ComposeMessageViewController alloc] init] autorelease];
    composeMessageVC.receiverID = _buddyID;
    UINavigationController *nav = [[[UINavigationController alloc] initWithRootViewController:composeMessageVC] autorelease];
    nav.navigationBar.tintColor = NAVIGATION_BAR_COLOR;
    [self presentModalViewController:nav animated:YES];
}

- (void)popToRootView {
    [self.navigationController popToRootViewControllerAnimated:NO];
}

#pragma mark -
#pragma mark CosmoNetwork callbacks
-(void) UIUpdate:(id)updateP data:(NSString*)dataP {
    [[SHKActivityIndicator currentIndicator] hide];
	if ([dataP isEqualToString:@"success"]) {
        SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
        NSError *error;
        NSString *jsonString = [[[NSString alloc]initWithData:[cosmoFeaturesnetworkP dataP] encoding:NSUTF8StringEncoding] autorelease];
        [_data release];
        _data = [[jsonParser objectWithString:jsonString error:&error] retain];
        [jsonParser release];
        [self.tableView reloadData];
	}
}

@end
