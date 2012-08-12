//
//  SearchViewController.m
//  MVPScouts
//
//  Created by Shahil Shah on 18/05/12.
//  Copyright (c) 2012 kraftwebsolutions. All rights reserved.
//

#import "SearchViewController.h"
#import "AccountViewController.h"
#import "ConversationTableViewCell.h"
#import "SHKActivityIndicator.h"
#import "SBJsonParser.h"
#import "UIConstants.h"
#import "MIMContact.h"
#import "constants.h"

@implementation SearchViewController

@synthesize searchURL = _searchURL, isFavourites = _isFavourites;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.navigationController.navigationBarHidden = NO;
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
    if (_isFavourites) {
        self.navigationItem.title = @"Favourites";
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:kReloadData object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:kReloadFavourites object:nil];
    }
    else {
        self.navigationItem.title = @"Search Results";
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popToRootView) name:kReloadData object:nil];
    }
    _accountViewController = [[AccountViewController alloc] initWithStyle:UITableViewStyleGrouped];
    _accountViewController.addToFavorite = YES;
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, HEIGHT_SEARCH_BAR)];
	_searchBar.delegate = self;
	//_searchBar.tintColor = [UIColor blueColor];
	_searchBar.placeholder = @"Enter search text";

    self.tableView.rowHeight = kTableViewCellRowHeight;
    //self.tableView.tableHeaderView = _searchBar;
    
/*    UIImageView *navigationBarLogo = [[UIImageView alloc] initWithFrame:CGRectMake(120, 2, 88, 38)];
	navigationBarLogo.image = [UIImage imageNamed:IMG_LOGO];
	self.navigationItem.titleView = navigationBarLogo;
	[navigationBarLogo release];
*/
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(loadData)] autorelease];
}

- (void)dealloc {
    if (_isFavourites) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:kReloadData object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:kReloadFavourites object:nil];
    }
    [_searchBar release], _searchBar = nil;
    [super dealloc];
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
    if (_isFavourites) {
        return 3;
    }
    return 1;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (_isFavourites) {
        switch (section) {
            case 0: {
                if (_requestArray)
                    return [_requestArray count];
                break;
            }
            case 1: {
                if (_pendingArray)
                    return [_pendingArray count];
                break;
            }
            case 2: {
                if (_acceptedArray)
                    return [_acceptedArray count];
                break;
            }
            default:
                return 0;
                break;
        }
    }
    else {
        if (_data) {
            return [_data count];
        }
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (!_isFavourites) {
        return @"";
    }
    
    if (section == 0) {
        if (_requestArray && [_requestArray count] > 0) {
            return @"Favourite Request";
        }
        else
            return @"";
    }
    
    if (section == 1) {
        if (_pendingArray && [_pendingArray count] > 0) {
            return @"People following you";
        }
        else
            return @"";
    }
    
    if (section == 2) {
        if (_acceptedArray && [_acceptedArray count] > 0) {
            return @"Favourite List";
        }
        else
            return @"";
    }
    return @"";
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
    
    NSDictionary *dict;
    if (_isFavourites) {
        if (indexPath.section == 0) {
            dict = [_requestArray objectAtIndex:indexPath.row];
        }
        else if (indexPath.section == 1) {
            dict = [_pendingArray objectAtIndex:indexPath.row];
        }
        else if (indexPath.section == 2) {
            dict = [_acceptedArray objectAtIndex:indexPath.row];
        }
    }
    else
        dict = [_data objectAtIndex:indexPath.row];
    MIMContact *contact = [[MIMContact alloc] initContact:[NSString stringWithFormat:@"%@ %@", [dict valueForKey:@"first_name"], [dict valueForKey:@"last_name"]] user:@"Shahil" service:@"MVPScouts"];
    contact.avatar = [dict valueForKey:JSONTAG_LOCAL_PROFILE_PHOTO];
    [(ConversationTableViewCell*)cell setMessage:[dict valueForKey:@"user_details"]];
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
    AccountViewController *accountViewController = [[AccountViewController alloc] initWithStyle:UITableViewStyleGrouped];
    NSDictionary *dict;
    if (_isFavourites) {
        if (indexPath.section == 0) {
            dict = [_requestArray objectAtIndex:indexPath.row];
            accountViewController.parentType = FAVOURITE_REQUEST;
        }
        else if (indexPath.section == 1) {
                dict = [_pendingArray objectAtIndex:indexPath.row];
                accountViewController.parentType = FAVOURITE_FOLLOWING;
        }
        else if (indexPath.section == 2) {
            dict = [_acceptedArray objectAtIndex:indexPath.row];
            accountViewController.parentType = FAVOURITE_ADDED;
        }
    }
    else {
        dict = [_data objectAtIndex:indexPath.row];
        accountViewController.parentType = FAVOURITE_SEARCH;
    }
    accountViewController.isAccountsPage = NO;
    accountViewController.buddyID = [dict valueForKey:@"id"];
    [accountViewController clearPage];
    [accountViewController loadData];
    [self.navigationController pushViewController:accountViewController animated:YES];
    [accountViewController release], accountViewController = nil;
}

#pragma Custom methods
- (void)popToRootView {
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (void)loadData {
    [cosmoFeaturesnetworkP release];
	cosmoFeaturesnetworkP = [[CosmoNetwork alloc]init];
	cosmoFeaturesnetworkP.writeToFileB=YES;
    cosmoFeaturesnetworkP.xmlDataB=NO;
/*    NSString *URL = [NSString stringWithFormat:[URL_BASE stringByAppendingString:URL_SEARCH], _searchBar.text, [[NSUserDefaults standardUserDefaults] valueForKey:NS_USER_ID]];
    [cosmoFeaturesnetworkP loadSection:self url:URL];*/
    NSString *URL;
    if (_isFavourites) {
        URL = [NSString stringWithFormat:[URL_BASE stringByAppendingString:URL_FAVOURITES], [[NSUserDefaults standardUserDefaults] valueForKey:NS_USER_ID]];
    }
    else {
        URL = [URL_BASE stringByAppendingString:_searchURL];
    }
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
        if (_isFavourites) {
            [_acceptedArray release];
            [_pendingArray release];
            [_requestArray release];
            
            NSDictionary *dict = [jsonParser objectWithString:jsonString error:&error];
            _acceptedArray = [[dict valueForKey:@"accepted"] retain];
            _pendingArray = [[dict valueForKey:@"pending"] retain];
            _requestArray = [[dict valueForKey:@"request"] retain];
        }
        else {
            [_data release];
            _data = [[jsonParser objectWithString:jsonString error:&error] retain];
        }
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
        NSDictionary *dict;
        if (_isFavourites) {
            if (downloadP.uniqueID == 0) dict = [_requestArray objectAtIndex:downloadP.tag];
            else if (downloadP.uniqueID == 1) dict = [_pendingArray objectAtIndex:downloadP.tag];
            else if (downloadP.uniqueID == 2) dict = [_acceptedArray objectAtIndex:downloadP.tag];
        }
        else
            dict = [_data objectAtIndex:downloadP.tag];
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
    
    if (_isFavourites) {
        for (int j=0; j<3; j++) {
            NSMutableArray *arr;
            if (j == 0) arr = _requestArray;
            else if (j == 1) arr = _pendingArray;
            else if (j == 2) arr = _acceptedArray;

            for(int i=0;i<[arr count];++i) {
                NSDictionary *dict = [arr objectAtIndex:i];;

                if (![[dict valueForKey:JSONTAG_PROFILE_PHOTO] isEqualToString:BLANK_STRING]) {
                    downLoadP = [[DownLoadPages alloc]init];
                    downLoadP.downloadDelegateP=nil;
                    downLoadP.textContentUrlP=nil;
                    downLoadP.imageContentUrlP=[NSString stringWithFormat:@"http://www.mvpscouts.com/%@", [dict valueForKey:JSONTAG_PROFILE_PHOTO]];
                    downLoadP.tag=i;
                    downLoadP.fileUrlP=nil;
                    downLoadP.uniqueID = j;
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
            }
        }
    }
    else {
        for(int i=0;i<[_data count];++i) {
            NSDictionary *dict = [_data objectAtIndex:i];
            if (![[dict valueForKey:JSONTAG_PROFILE_PHOTO] isEqualToString:BLANK_STRING]) {
                downLoadP = [[DownLoadPages alloc]init];
                downLoadP.downloadDelegateP=nil;
                downLoadP.textContentUrlP=nil;
                downLoadP.imageContentUrlP=[NSString stringWithFormat:@"http://www.mvpscouts.com/%@", [dict valueForKey:JSONTAG_PROFILE_PHOTO]];
                downLoadP.tag=i;
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
        }
    }
    [self performSelectorOnMainThread:@selector(updateView)withObject:nil waitUntilDone:NO];
	[pool release];
}

-(void)updateView {
	[self.tableView reloadData];
}

#pragma mark searchbar delegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {  
	searchBar.showsScopeBar = YES;  
	[searchBar sizeToFit];  
	
	[searchBar setShowsCancelButton:YES animated:YES];  
	
	return YES;  
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {  
	searchBar.showsScopeBar = NO;  
	[searchBar sizeToFit];  
	
	[searchBar setShowsCancelButton:NO animated:YES];  
	return YES;  
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
	[_searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
	[_searchBar resignFirstResponder];
    [self loadData];
}

@end
