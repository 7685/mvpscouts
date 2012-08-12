//
//  SearchFieldsViewController.m
//  WindowBasedApplication
//
//  Created by Shahil Shah on 07/07/12.
//  Copyright (c) 2012 kraftwebsolutions. All rights reserved.
//

#import "SearchFieldsViewController.h"
#import "SearchViewController.h"
#import "LoginViewController.h"
#import "DatabaseController.h"
#import "constants.h"

#define kLeftMargin				70.0
#define kTopMargin				10.0
#define kTextFieldWidth			190.0
#define kTextFieldHeight		25.0

@implementation SearchFieldsViewController

NSString *_placeHolderTitles[MAX_FIELDS] = {@"name", @"sport", @"position", @"state", @"city", @"year"};
NSString *_titles[MAX_FIELDS] = {@"Name", @"Sport", @"Position", @"State", @"City", @"Year"};

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        _sportsArrayIndex = 0;
        _positionId = 0;
        _sportsId = 0;
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
    [self isLoggedIn];
    self.navigationItem.title = @"Search";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isLoggedIn) name:kLogoutNotification object:nil];
    
    _searchViewController = [[SearchViewController alloc] initWithStyle:UITableViewStylePlain];
    _sportsPickerView = [[UIPickerView alloc]  initWithFrame:CGRectMake(0, 200, 320, 200)];
    _positionPickerView = [[UIPickerView alloc]  initWithFrame:CGRectMake(0, 200, 320, 200)];
    _statePickerView = [[UIPickerView alloc]  initWithFrame:CGRectMake(0, 200, 320, 200)];
    _cityPickerView = [[UIPickerView alloc]  initWithFrame:CGRectMake(0, 200, 320, 200)];
    
    _sportsPickerView.dataSource = self;
    _sportsPickerView.delegate = self;
    _positionPickerView.dataSource = self;
    _positionPickerView.delegate = self;
    _statePickerView.dataSource = self;
    _statePickerView.delegate = self;
    _cityPickerView.dataSource = self;
    _cityPickerView.delegate = self;
    
    _sportsPickerView.showsSelectionIndicator = YES;
    _positionPickerView.showsSelectionIndicator = YES;
    _statePickerView.showsSelectionIndicator = YES;
    _cityPickerView.showsSelectionIndicator = YES;
    
    DatabaseController *dbController = [[DatabaseController alloc] init];
    _sportsArray = [dbController selectQuery:SQL_GET_SPORTS params:nil];
    [_sportsArray retain];
    
    _positionsArray = [[NSMutableArray alloc] init];
    for (int i=0; i < [_sportsArray count]; i++) {
        NSMutableDictionary *dict = [_sportsArray objectAtIndex:i];
        NSString *sql = [NSString stringWithFormat:SQL_GET_POSITIONS, [dict valueForKey:@"id"]];
        NSArray *arr = [dbController selectQuery:sql params:nil];
        [_positionsArray addObject:arr];
    }
    [dbController release];
    _stateListArray = [dbController selectCountryCityQuery:SQL_GET_STATES];
    [_stateListArray retain];
    
    UIToolbar *toolbar = [[[UIToolbar alloc] init] autorelease];
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    [toolbar sizeToFit];
    
    UISegmentedControl *control = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:
                                                                             NSLocalizedString(@"Previous",@""),
                                                                             NSLocalizedString(@"Next",@""),                                         
                                                                             nil]];
    control.segmentedControlStyle = UISegmentedControlStyleBar;
    control.tintColor = [UIColor darkGrayColor];
    control.momentary = YES;
    [control addTarget:self action:@selector(nextPrevious:) forControlEvents:UIControlEventValueChanged];     
    
    UIBarButtonItem *prevNextButton = [[[UIBarButtonItem alloc] initWithCustomView:control] autorelease];
    UIBarButtonItem *flexButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:@selector(resignKeyboard)];
    UIBarButtonItem *doneButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(resignKeyboard)];
    
    NSArray *itemsArray = [NSArray arrayWithObjects:prevNextButton, flexButton, doneButton, nil];
    [toolbar setItems:itemsArray];
    [flexButton release];
    [control release];
    [doneButton release];
    
    for (int i=0; i < MAX_FIELDS; i++) {
        _dataTextFields[i] = [[UITextField alloc] initWithFrame:CGRectMake(kLeftMargin, kTopMargin, kTextFieldWidth, kTextFieldHeight)];
        _dataTextFields[i].placeholder = _placeHolderTitles[i];
        _dataTextFields[i].autocapitalizationType = UITextAutocapitalizationTypeNone;
        _dataTextFields[i].autocorrectionType = UITextAutocorrectionTypeNo;
        _dataTextFields[i].borderStyle = UITextBorderStyleNone;
        _dataTextFields[i].font = [UIFont boldSystemFontOfSize:15.0];
        _dataTextFields[i].minimumFontSize = 12;
        _dataTextFields[i].adjustsFontSizeToFitWidth = YES;
        _dataTextFields[i].backgroundColor = [UIColor clearColor];
        _dataTextFields[i].returnKeyType = UIReturnKeyNext;
        _dataTextFields[i].delegate = self;
        _dataTextFields[i].clearButtonMode = UITextFieldViewModeWhileEditing;
        _dataTextFields[i].text = @"";
        _dataTextFields[i].inputAccessoryView = toolbar;
        _dataTextFields[i].tag = i;
        _dataTextFields[i].font = [UIFont fontWithName:FONT_NAME size:FONT_HEIGHT];
        
        switch (i) {
            case 1:
                _dataTextFields[i].inputView = _sportsPickerView;
                break;
            case 2:
                _dataTextFields[i].inputView = _positionPickerView;
                break;
            case 3:
                _dataTextFields[i].inputView = _statePickerView;
                break;
            case 4:
                _dataTextFields[i].inputView = _cityPickerView;
                break;
            case 5:
                _dataTextFields[i].keyboardType = UIKeyboardTypeNumberPad;
                break;
            default:
                _dataTextFields[i].keyboardType = UIKeyboardTypeEmailAddress;
                break;
        }   
    }
}

- (void)dealloc {
    for (int i=0; i < MAX_FIELDS; i++) {
        [_dataTextFields[i] release], _dataTextFields[i] = nil;
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kLogoutNotification object:nil];
    if (_loginViewController) {
        [_loginViewController release], _loginViewController = nil;
    }
    if (_cityListArray) {
        [_cityListArray release], _cityListArray = nil;
    }
    [_searchViewController release], _searchViewController = nil;
    [_submitButton release], _submitButton = nil;
    [_sportsPickerView release], _sportsPickerView = nil;
    [_positionPickerView release], _positionPickerView = nil;
    [_statePickerView release], _statePickerView = nil;
    [_cityPickerView release], _cityPickerView = nil;
    [_stateListArray release], _stateListArray = nil;
    [_positionsArray release], _positionsArray = nil;
    [_sportsArray release], _sportsArray = nil;
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return MAX_FIELDS;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.textLabel.font = [UIFont fontWithName:FONT_NAME size:FONT_HEIGHT];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryView = _dataTextFields[indexPath.row];
    cell.textLabel.text = _titles[indexPath.row];
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
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectZero];
    _submitButton = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
	_submitButton.frame = CGRectMake(10, 10, 300, 40);
    [_submitButton setTitle:@"Submit" forState:UIControlStateNormal];
    [_submitButton addTarget:self action:@selector(searchBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:_submitButton];
	return [contentView autorelease];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView == _sportsPickerView) {
        _sportsArrayIndex = row;
        NSMutableDictionary *dict = [_sportsArray objectAtIndex:row];
        return [dict valueForKey:@"title"];
    }
    else if (pickerView == _positionPickerView) {
        NSMutableArray *arr = [_positionsArray objectAtIndex:_sportsId];
        NSMutableDictionary *dict = [arr objectAtIndex:row];
        return [dict valueForKey:@"title"];
    }
    else if (pickerView == _statePickerView) {
        return [_stateListArray objectAtIndex:row];
    }
    else if (pickerView == _cityPickerView) {
        return [_cityListArray objectAtIndex:row];
    }
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    // Handle the selection
    if (pickerView == _sportsPickerView) {
        NSMutableDictionary *dict = [_sportsArray objectAtIndex:row];
        _dataTextFields[1].text = [dict valueForKey:@"title"];
        _sportsId = row;//[[dict valueForKey:@"id"] intValue];
        _dataTextFields[2].text = BLANK_STRING;
        [_positionPickerView reloadAllComponents];
    }
    else if (pickerView == _positionPickerView) {
        NSMutableArray *arr = [_positionsArray objectAtIndex:_sportsId];
        NSMutableDictionary *dict = [arr objectAtIndex:row];
        _dataTextFields[2].text = [dict valueForKey:@"title"];
        _positionId = [[dict valueForKey:@"id"] intValue];
    }
    else if(pickerView == _statePickerView) {
        _dataTextFields[3].text = [_stateListArray objectAtIndex:row];
        DatabaseController *dbController = [[DatabaseController alloc] init];
        _cityListArray = [dbController selectCountryCityQuery:[NSString stringWithFormat:SQL_GET_CITIES, [_stateListArray objectAtIndex:row]]];
        [_cityListArray retain];
        [_cityPickerView reloadAllComponents];
        
    }
    else if(pickerView == _cityPickerView) {
        _dataTextFields[4].text = [_cityListArray objectAtIndex:row];
    }
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == _sportsPickerView) {
        return [_sportsArray count];
    }
    else if (pickerView == _positionPickerView) {
        NSMutableArray *arr = [_positionsArray objectAtIndex:_sportsId];
        return [arr count];
    }
    else if (pickerView == _statePickerView) {
        return [_stateListArray count];
    }
    else if (pickerView == _cityPickerView) {
        return [_cityListArray count];
    }
    return 0;
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}


// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    int sectionWidth = 300;
    
    return sectionWidth;
}

#pragma mark - Keyboard delegate event
//-(BOOL)textFieldShouldReturn:(UITextField *)aTextField {
//    [aTextField resignFirstResponder];
//	if(aTextField == _dataTextFields[0]) {
//		[_dataTextFields[1] becomeFirstResponder];
//	}
//	else if(aTextField == _dataTextFields[1]) {
//		[_dataTextFields[2] becomeFirstResponder];
//	}
//    else if(aTextField == _dataTextFields[2]) {
//		[_dataTextFields[3] becomeFirstResponder];
//	}
//	else if(aTextField == _dataTextFields[3]) {
//		[_dataTextFields[4] becomeFirstResponder];
//	}
//	else if(aTextField == _dataTextFields[4]) {
//		[_dataTextFields[5] becomeFirstResponder];
//	}
//
//	return YES;
//}

#pragma Custom methods
- (void)isLoggedIn {
    if ([[NSUserDefaults standardUserDefaults] valueForKey:NS_IS_USER_LOGGED_IN] == NULL) {
        _loginViewController = [[LoginViewController alloc] initWithStyle:UITableViewStyleGrouped];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:_loginViewController];
        navController.navigationBar.tintColor = NAVIGATION_BAR_COLOR;
        //[navController.navigationBar setBackgroundImage:[UIImage imageNamed:IMG_NAVBAR] forBarMetrics:UIBarMetricsDefault];
        [self presentModalViewController:navController animated:NO];
        [navController release];
    }
}

- (void)searchBtnClicked {
    _searchViewController.searchURL = [NSString stringWithFormat:URL_SEARCH_ADVANCED, _dataTextFields[0].text, _sportsId, _positionId, _dataTextFields[3].text, _dataTextFields[4].text, _dataTextFields[5].text, [[NSUserDefaults standardUserDefaults] valueForKey:NS_USER_ID]];
    [_searchViewController loadData];
    for (int i=0; i < 6; i++) {
        [_dataTextFields[i] resignFirstResponder];
    }
    [self.navigationController pushViewController:_searchViewController animated:YES];
}

#pragma mark - keyboard
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	_textFieldForResign = textField;
	CGFloat offsetTarget    = 113.0f; // 3rd row
	CGFloat offsetThreshold = 248.0f; // 6th row (i.e. 2nd-to-last row)
	
	CGPoint point = [self.tableView convertPoint:CGPointZero fromView:textField];
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.2];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	
	CGRect frame = self.tableView.frame;
	if (point.y > offsetThreshold) {
        self.tableView.frame = CGRectMake(0.0f,
                                          offsetTarget - point.y + self.tableView.rowHeight + 20,
                                          frame.size.width,
                                          frame.size.height);
	} else if (point.y > offsetTarget) {
        self.tableView.frame = CGRectMake(0.0f,
                                          offsetTarget - point.y,
                                          frame.size.width,
                                          frame.size.height);
	} else {
        self.tableView.frame = CGRectMake(0.0f,
                                          0.0f,
                                          frame.size.width,
                                          frame.size.height);
	}
	
	[UIView commitAnimations];
	
	return YES;
	
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:0.2];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	
	CGRect frame = self.tableView.frame;
	self.tableView.frame = CGRectMake(0.0f,
									  0.0f,
									  frame.size.width,
									  frame.size.height);
	
	[UIView commitAnimations];
	
	return YES;
	
}

-(void)resignKeyboard{//DONE button clicked.
	[self textFieldShouldReturn:_textFieldForResign];
}

-(void)nextPrevious:(id)sender{
	int textFieldTag = [_textFieldForResign tag];
	if ([sender selectedSegmentIndex] == 0) {//prev
		textFieldTag--;
	}
	else {//next
		textFieldTag++;
	}
    [_dataTextFields[textFieldTag] becomeFirstResponder];
	
}
@end
