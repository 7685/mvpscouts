//
//  LinksViewController.m
//  MVPScouts
//
//  Created by Shahil Shah on 18/05/12.
//  Copyright (c) 2012 kraftwebsolutions. All rights reserved.
//

#import "LinksViewController.h"
#import "SHKActivityIndicator.h"
#import "SBJsonParser.h"
#import "constants.h"

@implementation LinksViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.tabBarItem.title = @"Links";
        self.tabBarController.title = @"yo";
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
    [self loadData];
    self.navigationItem.title = @"Other Information";
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    switch (section) {
        case 0: {
            if (_videosArray) { NSLog(@"[_videosArray count] :: %d", [_videosArray count]); return [_videosArray count] + 1; }
            else return 0;
            break;
        }
        case 1: {
            if (_newsArticlesArray) return [_newsArticlesArray count] + 1;
            else return 0;
            break;
        }
        case 2: {
            if (_otherInfoDictionary) return 0;//[_otherInfoDictionary count];
            else return 0;
            break;
        }
    }
    return 0;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Videos";
        case 1:
            return @"News/Articles/Headlines";
        case 2:
            return @"Other Info";
//        case 3:
//            return @"Upcoming Events";
//        case 4:
//            return @"Additional Comments / Skills";
//        case 5:
//            return @"News/Articles/Headlines";
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    switch (indexPath.section) {
        case 0: {
            if (indexPath.row == [_videosArray count]) {
                cell.textLabel.text = @"Add";
            }
            else {
                NSDictionary *dict = [_videosArray objectAtIndex:indexPath.row];
                cell.textLabel.text = [dict valueForKey:JSONTAG_VIDEO_TITLE];
            }
            break;
        }
        case 1: {
            if (indexPath.row == [_newsArticlesArray count]) {
                cell.textLabel.text = @"Add";
            }
            else {
                NSDictionary *dict = [_newsArticlesArray objectAtIndex:indexPath.row];
                cell.textLabel.text = [dict valueForKey:JSONTAG_NEWS_TITLE];
            }
            break;
        }
        case 2: {
//            if (indexPath.row == 0) {
                cell.textLabel.text = @"yo";
  //          }
            break;
        }
    }
    // Configure the cell...
    
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
    if (indexPath.section == 0) {
        NSDictionary *dict = [_videosArray objectAtIndex:indexPath.row];
        NSLog(@"dict :: %@", [dict valueForKey:JSONTAG_VIDEO]);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:URL_YOUTUBE, [dict valueForKey:JSONTAG_VIDEO]]]];
    }
}

- (void)loadData {
    [cosmoFeaturesnetworkP release];
	cosmoFeaturesnetworkP = [[CosmoNetwork alloc]init];
	cosmoFeaturesnetworkP.writeToFileB=YES;
    cosmoFeaturesnetworkP.xmlDataB=NO;
    NSString *URL;
    URL = [NSString stringWithFormat:[URL_BASE stringByAppendingString:URL_GET_LINKS], [[NSUserDefaults standardUserDefaults] valueForKey:NS_USER_ID]]; 

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
        NSMutableDictionary *tempArray = [[jsonParser objectWithString:jsonString error:&error] retain];
        _videosArray = [[tempArray valueForKey:JSONTAG_VIDEOS] retain];
        NSLog(@"video array :: %@", _videosArray);
        _newsArticlesArray = [[tempArray valueForKey:JSONTAG_NEWS_ARTICLES] retain];
        _otherInfoDictionary = [[tempArray valueForKey:JSONTAG_OTHER_INFO] retain];
        [jsonParser release];   
        [self.tableView reloadData];
	}
}
@end
