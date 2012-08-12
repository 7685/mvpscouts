//
//  MessagesViewController.m
//  MVPScouts
//
//  Created by Shahil Shah on 18/05/12.
//  Copyright (c) 2012 kraftwebsolutions. All rights reserved.
//

#import "MessagesViewController.h"
#import "ConversationTableViewCell.h"
#import "ConversationDetailsViewController.h"
#import "SHKActivityIndicator.h"
#import "MIMContact.h"
#import "UIConstants.h"
#import "constants.h"
#import "SBJsonParser.h"
#import <CommonCrypto/CommonDigest.h>

@implementation MessagesViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.tabBarItem.title = @"Messages";
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReloadData object:nil];
    [super dealloc];
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];
    _conversationDetailsViewController = [[ConversationDetailsViewController alloc] initWithStyle:UITableViewStylePlain];
    self.tableView.rowHeight = kTableViewCellRowHeight;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:kReloadData object:nil];

    self.navigationItem.title = @"Messages";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(loadData)] autorelease];
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
    if (_data) {
        return [_data count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";

    UITableViewCell *cell = (ConversationTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[ConversationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSDictionary *dict = [_data objectAtIndex:indexPath.row];
    MIMContact *contact = [[MIMContact alloc] initContact:[dict valueForKey:@"first_name"] user:@"Shahil" service:@"MVPScouts"];
    contact.avatar = [dict valueForKey:JSONTAG_LOCAL_PROFILE_PHOTO];
    [(ConversationTableViewCell*)cell setMessage:[dict valueForKey:@"message"]];
    [(ConversationTableViewCell*)cell setContact:contact];
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
    NSDictionary *dict = [_data objectAtIndex:indexPath.row];
    _conversationDetailsViewController.buddyID = [dict valueForKey:@"sender_id"];
    _conversationDetailsViewController.buddyName = [NSString stringWithFormat:@"%@ %@", [dict valueForKey:@"first_name"], [dict valueForKey:@"last_name"]];
    [_conversationDetailsViewController loadData];
    [self.navigationController pushViewController:_conversationDetailsViewController animated:YES];
}

#pragma mark -
#pragma mark Custom Functions
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

- (void)loadData {
    [cosmoFeaturesnetworkP release];
	cosmoFeaturesnetworkP = [[CosmoNetwork alloc]init];
	cosmoFeaturesnetworkP.writeToFileB=YES;
    cosmoFeaturesnetworkP.mainTag=@"profile";
    cosmoFeaturesnetworkP.xmlDataB=NO;
    NSString *URL = [NSString stringWithFormat:[URL_BASE stringByAppendingString:URL_MESSAGES], [self md5:[[NSUserDefaults standardUserDefaults] valueForKey:NS_USER_ID]]];
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
        SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
        NSError *error;
        NSString *jsonString = [[[NSString alloc]initWithData:[cosmoFeaturesnetworkP dataP] encoding:NSUTF8StringEncoding] autorelease];
        [_data release];
        _data = [[jsonParser objectWithString:jsonString error:&error] retain];
        [jsonParser release];
        [self.tableView reloadData];
        [self performSelectorInBackground:@selector(doTaskInBackGround) withObject:nil];
	}
}

-(int)downLoadNotification:(id)objectP index:(int)index url:(NSString*)urlP {
	DownLoadPages *downloadP;
	downloadP = (DownLoadPages*)objectP;
	if(downloadP.error==0) {	
		//downloadP.fileUrlP=urlP;
        NSDictionary *dict = [_data objectAtIndex:downloadP.tag];
        [dict setValue:urlP forKey:JSONTAG_LOCAL_PROFILE_PHOTO];
		[self.tableView reloadData];
	}
	return 0;
}

-(void)doTaskInBackGround {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSOperationQueue *queue = [NSOperationQueue new];
	DownLoadPages *downLoadP;
	
    /* Create our NSInvocationOperation to call loadDataWithOperation, passing in nil */
    NSInvocationOperation *operation;
    for(int i=0;i<[_data count];++i) {
        NSDictionary *dict = [_data objectAtIndex:i];
        downLoadP = [[DownLoadPages alloc]init];
        downLoadP.downloadDelegateP=nil;
        downLoadP.textContentUrlP=nil;
        downLoadP.imageContentUrlP=[NSString stringWithFormat:@"http://www.mvpscouts.com/%@", [dict valueForKey:JSONTAG_PROFILE_PHOTO]];
        downLoadP.index=i;
        downLoadP.fileUrlP=nil;
        NSLog(@"downLoadP.imageContentUrlP :: %@", downLoadP.imageContentUrlP);
        if([downLoadP fileExist]==NO)
        {	
            downLoadP.downloadDelegateP=self;
            operation = [[NSInvocationOperation alloc] initWithTarget:downLoadP
                                                             selector:@selector(startDownLoad)
                                                               object:nil];
            [queue addOperation:operation];
            [operation release];
        }	
        else {
            downLoadP.downLoadFinishB=YES;
            [dict setValue:downLoadP.fileUrlP forKey:JSONTAG_LOCAL_PROFILE_PHOTO];
        }			
    }
    [self performSelectorOnMainThread:@selector(updateView)withObject:nil waitUntilDone:NO];
	[pool release];
}

-(void)updateView {
	[self.tableView reloadData];
}

@end
