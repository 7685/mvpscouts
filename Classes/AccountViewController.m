//
//  AccountViewController.m
//  MVPScouts
//
//  Created by Shahil Shah on 18/05/12.
//  Copyright (c) 2012 kraftwebsolutions. All rights reserved.
//

#import "AccountViewController.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "ComposeMessageViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SHKActivityIndicator.h"
#import "DatabaseController.h"
#import "constants.h"
#import "SBJsonParser.h"

//TextField Constants
#define kLeftMargin				100.0
#define kTopMargin				10.0
#define kTextFieldWidth			160.0
#define kTextFieldHeight		25.0

@implementation AccountViewController
@synthesize isAccountsPage = _isAccountsPage, buddyID = _buddyID, addToFavorite = _addToFavorite, parentType = _parentType;

NSString *title[29] = {@"Firstname", @"Lastname",/* @"Email", @"User Type",*/ @"DOB", @"State", @"City", @"Zip", @"Contact No.", @"Fax No.", @"School Name", @"Class End Year", @"Height", @"Weight", @"Bench", @"Squat", @"Time 40", @"Facebook", @"Twitter", @"Email", @"Phone", @"Email", @"Phone"};
NSString *titleTags[29] = {JSONTAG_FIRSTNAME, JSONTAG_LASTNAME, JSONTAG_DOB, JSONTAG_STATE, JSONTAG_CITY, JSONTAG_ZIP, JSONTAG_CONTACT_NO, JSONTAG_FAX_NO, JSONTAG_SCHOOL, JSONTAG_CLASS_END_YEAR, JSONTAG_HEIGHT, JSONTAG_WEIGHT, JSONTAG_BENCH, JSONTAG_SQUAT, JSONTAG_TIME_40, JSONTAG_FB_URL, JSONTAG_TWITTER_URL, JSONTAG_PARENT_PHONE, JSONTAG_PARENT_EMAIL, JSONTAG_COACH_PHONE, JSONTAG_COACH_EMAIL, JSONTAG_SPORTS1, JSONTAG_POSITION1, JSONTAG_SPORTS2, JSONTAG_POSITION2, JSONTAG_SPORTS3, JSONTAG_POSITION3};

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        _addToFavorite = NO;
        _textFieldForResign = nil;
        for (int i=0; i < 3; i++) {
            _sportIDs[i] = _positionIDs[i] = _sport[i] = _pos[i] = 0;
        }
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
    [_acceptSendMsgBtn release], _acceptSendMsgBtn = nil;
    if (!_isAccountsPage) {
        [_unfavouriteRejectBtn release], _unfavouriteRejectBtn = nil;
    }
    [_editButton release], _editButton = nil;
    [_buddyID release], _buddyID = nil;
    [super dealloc];
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    _acceptSendMsgBtn = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
    if (_isAccountsPage) {
        self.navigationItem.title = @"Account";
    }
    else {
        _unfavouriteRejectBtn = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
    }
    _userInfoTextView = [[UITextView alloc] initWithFrame:CGRectMake(85, 5, 220, 90)];
    _userInfoTextView.font = [UIFont fontWithName:FONT_NAME size:FONT_HEIGHT];
    _userInfoTextView.editable = NO;
    
    DatabaseController *dbController = [[DatabaseController alloc] init];
    _sportsArray = [dbController selectQuery:SQL_GET_SPORTS params:nil];
    [_sportsArray retain];
    
    _positionsArray = [[NSMutableArray alloc] init];
    for (int i=0; i < [_sportsArray count]; i++) {
        NSMutableDictionary *dict = [_sportsArray objectAtIndex:i];
        NSString *sql = [NSString stringWithFormat:SQL_GET_POSITIONS, [dict valueForKey:@"id"]];
        NSMutableArray *arr = [dbController selectQuery:sql params:nil];
        [_positionsArray addObject:arr];
    }
    [dbController release];
    
    //self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg.png"]];
    _data = [[NSMutableDictionary alloc] init];
    _profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 75, 90)];
    //_profileImageView.backgroundColor = [UIColor redColor];
    _profileImageView.image = [UIImage imageNamed:@"default_avatar.png"];
    _profileImageView.layer.cornerRadius = 8.0f;
    _profileImageView.layer.masksToBounds = YES;
    _profileImageView.layer.borderWidth = 1.0f;
    self.tableView.tableHeaderView = [self getHeaderView];
    self.tableView.tableHeaderView.frame = CGRectMake(0, 0, 320, 120);
    
    _firstPickerView = [[UIPickerView alloc]  initWithFrame:CGRectMake(0, 200, 320, 200)];
    _secondPickerView = [[UIPickerView alloc]  initWithFrame:CGRectMake(0, 200, 320, 200)];
    _thirdPickerView = [[UIPickerView alloc]  initWithFrame:CGRectMake(0, 200, 320, 200)];
    
    
    _firstPickerView.dataSource = self;
    _firstPickerView.delegate = self;
    _secondPickerView.dataSource = self;
    _secondPickerView.delegate = self;
    _thirdPickerView.dataSource = self;
    _thirdPickerView.delegate = self;
    
    _firstPickerView.showsSelectionIndicator = YES;
    _secondPickerView.showsSelectionIndicator = YES;
    _thirdPickerView.showsSelectionIndicator = YES;
    
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
    
    for (int i=0; i<kProfileArraySize; i++) {
        _dataTextFields[i] = [[UITextField alloc] initWithFrame:CGRectMake(kLeftMargin, kTopMargin, kTextFieldWidth, kTextFieldHeight)];
        _dataTextFields[i].placeholder = title[i];
        _dataTextFields[i].autocapitalizationType = UITextAutocapitalizationTypeNone;
        _dataTextFields[i].autocorrectionType = UITextAutocorrectionTypeNo;
        _dataTextFields[i].borderStyle = UITextBorderStyleNone;
        _dataTextFields[i].font = [UIFont boldSystemFontOfSize:15.0];
        _dataTextFields[i].minimumFontSize = 12;
        _dataTextFields[i].adjustsFontSizeToFitWidth = YES;
        _dataTextFields[i].backgroundColor = [UIColor clearColor];
        _dataTextFields[i].delegate = self;
        _dataTextFields[i].clearButtonMode = UITextFieldViewModeWhileEditing;
        _dataTextFields[i].text = @"";
        _dataTextFields[i].tag = i;
        _dataTextFields[i].inputAccessoryView = toolbar;
        _dataTextFields[i].font = [UIFont fontWithName:FONT_NAME size:FONT_HEIGHT];
        
        if (i == kProfileArraySize-4) {
            _dataTextFields[i].frame = CGRectMake(40, kTopMargin, 280, kTextFieldHeight);
            _dataTextFields[i].inputView = _firstPickerView;
        }
        else if (i == kProfileArraySize -3) {
            _dataTextFields[i].frame = CGRectMake(40, kTopMargin, 280, kTextFieldHeight);
            _dataTextFields[i].inputView = _secondPickerView;
        }
        else if (i == kProfileArraySize -2) {
            _dataTextFields[i].frame = CGRectMake(40, kTopMargin, 280, kTextFieldHeight);
            _dataTextFields[i].inputView = _thirdPickerView;
        }
        else {
            _dataTextFields[i].returnKeyType = UIReturnKeyNext;
            _dataTextFields[i].keyboardType = UIKeyboardTypeEmailAddress;
        }
    }
    
    if (_addToFavorite) {
//        self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addToFavoriteBtnClicked)] autorelease];
    }
    if (_isAccountsPage) {
//        self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleBordered target:self action:@selector(logoutBtnClicked)] autorelease];
        self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(loadData)] autorelease];

        _editButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStyleBordered target:self action:@selector(editBtnClicked)];
        self.navigationItem.leftBarButtonItem = _editButton;
    }
    [self loadData];
    if (!_isAccountsPage) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popToRootView) name:kReloadData object:nil];
    }
    else {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:kReloadData object:nil];
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
	_textFieldForResign = textField;
	CGPoint point = [self.tableView convertPoint:CGPointZero fromView:textField];
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.2];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	
    self.tableView.contentOffset = CGPointMake(0, point.y - 120);
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
        if (textFieldTag == 0) {
            return;
        }
		textFieldTag--;
	}
	else {//next
        if (self.tableView.numberOfSections == 1 && textFieldTag == 10) {
            return;
        }
        if (self.tableView.numberOfSections == 4 && textFieldTag == 23) {
            return;
        }
		textFieldTag++;
	}
    NSLog(@"textFieldTag :: %d", textFieldTag);
    [_dataTextFields[textFieldTag] becomeFirstResponder];
	_textFieldForResign = _dataTextFields[textFieldTag];
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
    if ([_data count] != 0) {
        if ([[_data valueForKey:JSONTAG_USERTYPE] isEqualToString:@"Player"]) {
            return 4;
        }
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            if ([[_data valueForKey:JSONTAG_USERTYPE] isEqualToString:@"Player"]) {
                return 17;
            }
            else {
                return 11;
            }
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 2;
            break;
        case 3:
            return 3;
            break;
    }
    return 0;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Personal Information";
        case 1:
            return @"Parent's Contact";
        case 2:
            return @"Coach's Contact";
        case 3:
            return @"Sports";
        default:
            break;
    }
    return nil;
}

/*- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
 {
 if (section == 0) {
 return 160;
 }
 return 20;
 }
 
 - (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
 {
 if (section != 0) {
 return nil;
 }
 if ([_data count] == 0) {
 return nil;
 }*/
- (UIView *)getHeaderView
{
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 175)];
    UIView *innerView = [[UIView alloc] initWithFrame:CGRectMake(10, 55, 300, 110)];
    innerView.layer.cornerRadius = 8.0f;
    innerView.layer.masksToBounds = YES;
    innerView.layer.borderWidth = 1.0f;
    innerView.backgroundColor = [UIColor whiteColor];
    innerView.layer.borderColor = [UIColor grayColor].CGColor;
    [innerView addSubview:_profileImageView];
    [innerView addSubview:_userInfoTextView];
 
    if (_parentType == ROOT || _parentType == FAVOURITE_SEARCH) {
        _acceptSendMsgBtn.frame = CGRectMake(10, 10, 300, 40);
        
    }
    else {
        _acceptSendMsgBtn.frame = CGRectMake(10, 10, 145, 40);
        _unfavouriteRejectBtn.frame = CGRectMake(165, 10, 145, 40);
        [contentView addSubview:_unfavouriteRejectBtn];
    }

    switch (_parentType) {
        case ROOT: {
            [_acceptSendMsgBtn setTitle:@"Logout" forState:UIControlStateNormal];
            [_acceptSendMsgBtn addTarget:self action:@selector(logoutBtnClicked) forControlEvents:UIControlEventTouchUpInside];
            break;
        }
        case FAVOURITE_SEARCH: {
            [_acceptSendMsgBtn setTitle:@"Add to Favourite" forState:UIControlStateNormal];
            [_acceptSendMsgBtn addTarget:self action:@selector(addToFavoriteBtnClicked) forControlEvents:UIControlEventTouchUpInside];
            break;
        }
        case FAVOURITE_FOLLOWING: {
            [_acceptSendMsgBtn setTitle:@"Message" forState:UIControlStateNormal];
            [_acceptSendMsgBtn addTarget:self action:@selector(composeMessage) forControlEvents:UIControlEventTouchUpInside];
            [_unfavouriteRejectBtn setTitle:@"Reject" forState:UIControlStateNormal];
            [_unfavouriteRejectBtn addTarget:self action:@selector(removeFromFollowing) forControlEvents:UIControlEventTouchUpInside];
            break;
        }
        case FAVOURITE_ADDED: {
            [_acceptSendMsgBtn setTitle:@"Message" forState:UIControlStateNormal];
            [_acceptSendMsgBtn addTarget:self action:@selector(composeMessage) forControlEvents:UIControlEventTouchUpInside];
            [_unfavouriteRejectBtn setTitle:@"Unfavourite" forState:UIControlStateNormal];
            [_unfavouriteRejectBtn addTarget:self action:@selector(removeFromFavourites) forControlEvents:UIControlEventTouchUpInside];
            break;
        }
        case FAVOURITE_REQUEST: {
            [_acceptSendMsgBtn setTitle:@"Accept" forState:UIControlStateNormal];
            [_acceptSendMsgBtn addTarget:self action:@selector(acceptRequest) forControlEvents:UIControlEventTouchUpInside];
            [_unfavouriteRejectBtn setTitle:@"Reject" forState:UIControlStateNormal];
            [_unfavouriteRejectBtn addTarget:self action:@selector(rejectRequest) forControlEvents:UIControlEventTouchUpInside];
            break;
        }
    }
            
    [contentView addSubview:_acceptSendMsgBtn];
    [contentView addSubview:innerView];
    
    [innerView release];
	
    return [contentView autorelease];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    int indexInContext = 0;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    cell.textLabel.font = [UIFont fontWithName:FONT_NAME size:FONT_HEIGHT];
    cell.accessoryView = nil;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    _dataTextFields[indexPath.row].enabled = NO;
    // Configure the cell...
    if (indexPath.section == 0) {
        indexInContext = indexPath.row;
        cell.accessoryView = _dataTextFields[indexPath.row];
        cell.textLabel.text = title[indexPath.row];
        switch (indexPath.row) {
            case 0:
                //cell.textLabel.text = @"Firstname";
                _dataTextFields[indexPath.row].text = [_data valueForKey:JSONTAG_FIRSTNAME];
                break;
            case 1:
                //cell.textLabel.text = @"Lastname";
                _dataTextFields[indexPath.row].text = [_data valueForKey:JSONTAG_LASTNAME];
                break;
                /*            case 2:
                 //cell.textLabel.text = @"Email";
                 _dataTextFields[indexPath.row].text = [_data valueForKey:JSONTAG_EMAIL];
                 _dataTextFields[indexPath.row].enabled = NO;
                 break;
                 case 3:
                 _dataTextFields[indexPath.row].text = [_data valueForKey:JSONTAG_USERTYPE];
                 _dataTextFields[indexPath.row].enabled = NO;
                 break;*/
            case 2:
                _dataTextFields[indexPath.row].text = [_data valueForKey:JSONTAG_DOB];//[NSString stringWithFormat:@"%@/%@/%@", [_data valueForKey:JSONTAG_DOB_YEAR], [_data objectForKey:JSONTAG_DOB_MONTH], [_data objectForKey:JSONTAG_DOB_DAY]];
                break;
            case 3:
                _dataTextFields[indexPath.row].text = [_data valueForKey:JSONTAG_STATE];
                break;
            case 4:
                _dataTextFields[indexPath.row].text = [_data valueForKey:JSONTAG_CITY];
                break;
            case 5:
                _dataTextFields[indexPath.row].text = [_data valueForKey:JSONTAG_ZIP];
                break;
            case 6:
                _dataTextFields[indexPath.row].text = [_data valueForKey:JSONTAG_CONTACT_NO];
                break;
            case 7:
                _dataTextFields[indexPath.row].text = [_data valueForKey:JSONTAG_FAX_NO];
                break;
            case 8:
                _dataTextFields[indexPath.row].text = [_data valueForKey:JSONTAG_SCHOOL];
                break;
            case 9:
                _dataTextFields[indexPath.row].text = [_data valueForKey:JSONTAG_CLASS_END_YEAR];
                break;
            case 10:
                _dataTextFields[indexPath.row].text = [_data valueForKey:JSONTAG_HEIGHT];
                break;
            case 11:
                _dataTextFields[indexPath.row].text = [_data valueForKey:JSONTAG_WEIGHT];
                break;
            case 12:
                _dataTextFields[indexPath.row].text = [_data valueForKey:JSONTAG_BENCH];
                break;
            case 13:
                _dataTextFields[indexPath.row].text = [_data valueForKey:JSONTAG_SQUAT];
                break;
            case 14:
                _dataTextFields[indexPath.row].text = [_data valueForKey:JSONTAG_TIME_40];
                break;
            case 15:
                _dataTextFields[indexPath.row].text = [_data valueForKey:JSONTAG_FB_URL];
                break;
            case 16:
                _dataTextFields[indexPath.row].text = [_data valueForKey:JSONTAG_TWITTER_URL];
                break;
            default:
                break;
        }
    }
    else if (indexPath.section == 1) {
        cell.accessoryView = _dataTextFields[indexPath.row + kPlayerProfileCount];
        cell.textLabel.text = title[indexPath.row];
        switch (indexPath.row) {
            case 0: {
                cell.textLabel.text = @"Phone";
                _dataTextFields[indexPath.row + kPlayerProfileCount].text = [_data valueForKey:JSONTAG_PARENT_PHONE];
                break;
            }
            case 1: {
                cell.textLabel.text = @"Email";
                _dataTextFields[indexPath.row + kPlayerProfileCount].text = [_data valueForKey:JSONTAG_PARENT_EMAIL];
                break;
            }
        }
        indexInContext = indexPath.row + kPlayerProfileCount;
    }
    else if (indexPath.section == 2) {
        cell.accessoryView = _dataTextFields[indexPath.row + kPlayerProfileCount + kPlayerParentInfoCount];
        cell.textLabel.text = title[indexPath.row];
        switch (indexPath.row) {
            case 0: {
                cell.textLabel.text = @"Phone";
                _dataTextFields[indexPath.row + kPlayerProfileCount + kPlayerParentInfoCount].text = [_data valueForKey:JSONTAG_COACH_PHONE];
                break;
            }
            case 1: {
                cell.textLabel.text = @"Email";
                _dataTextFields[indexPath.row + kPlayerProfileCount + kPlayerParentInfoCount].text = [_data valueForKey:JSONTAG_COACH_EMAIL];
                break;
            }
        }
        indexInContext = indexPath.row + kPlayerProfileCount + kPlayerParentInfoCount;
    }
    else if (indexPath.section == 3) {
        indexInContext = indexPath.row + kPlayerProfileCount + kPlayerParentInfoCount + kPlayerCoachInfoCount;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.accessoryView = _dataTextFields[indexPath.row + kPlayerProfileCount + kPlayerParentInfoCount + kPlayerCoachInfoCount];
        /*switch (indexPath.row) {
            case 0: {
                _dataTextFields[indexPath.row + kPlayerProfileCount + kPlayerParentInfoCount + kPlayerCoachInfoCount].text = [self getSportPositionString:[[_data objectForKey:JSONTAG_SPORTS1] intValue] :[[_data objectForKey:JSONTAG_POSITION1] intValue] :0];
                break;
            }
            case 1: {
                _dataTextFields[indexPath.row + kPlayerProfileCount + kPlayerParentInfoCount + kPlayerCoachInfoCount].text = [self getSportPositionString:[[_data objectForKey:JSONTAG_SPORTS2] intValue] :[[_data objectForKey:JSONTAG_POSITION2] intValue] :1];
                break;
            }
            case 2: {
                _dataTextFields[indexPath.row + kPlayerProfileCount + kPlayerParentInfoCount + kPlayerCoachInfoCount].text = [self getSportPositionString:[[_data objectForKey:JSONTAG_SPORTS3] intValue] :[[_data objectForKey:JSONTAG_POSITION3] intValue] :2];
                break;
            }
        }*/
        _dataTextFields[indexPath.row + kPlayerProfileCount + kPlayerParentInfoCount + kPlayerCoachInfoCount].text = [self getSportPositionString:_kwsSport[indexPath.row] :_kwsPos[indexPath.row] :indexPath.row];

    }
    if (_isAccountsPage) {
        if ([_editButton.title isEqualToString:@"Edit"]) _dataTextFields[indexInContext].enabled = NO;
        else _dataTextFields[indexInContext].enabled = YES;
    }
    if (!_isAccountsPage || _addToFavorite) {
        _dataTextFields[indexInContext].enabled = NO;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (NSString*)getSportPositionString:(int)sportID :(int)positionID :(int)index{
    if (sportID == 0 || positionID == 0) {
            return @"Add Sport-Position";
    }
    NSString *sportName, *positionName;
    int i;
    for (i=0; i < [_sportsArray count]; i++) {
        NSDictionary *dict = [_sportsArray objectAtIndex:i];
        if ([[dict valueForKey:@"id"] intValue] == sportID) {
            sportName = [dict valueForKey:@"title"];
            _sportIDs[index] = i;
            break;
        }
    }

    NSMutableArray *arr = [_positionsArray objectAtIndex:_sportIDs[index]];//[_positionsArray valueForKey:sportName];
    //NSLog(@"arr :: %@", arr);
    for (i=0; i < [arr count]; i++) {
        NSDictionary *dict = [arr objectAtIndex:i];
        if (positionID == -1) {
            positionName = [dict valueForKey:@"title"];
            _kwsPos[index] = [[dict valueForKey:@"id"] intValue];
            break;
        }
        if ([[dict valueForKey:@"id"] intValue] == positionID) {
            positionName = [dict valueForKey:@"title"];
            _kwsPos[index] = [[dict valueForKey:@"id"] intValue];
            _positionIDs[index] = i;
            break;
        }
    }
    return [NSString stringWithFormat:@"%@ - %@", sportName, positionName];
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
    if (!_isAccountsPage || _addToFavorite) {
        if (indexPath.section == 0) {
            if (indexPath.row == 2) {
                if (![[_data valueForKey:JSONTAG_EMAIL] isEqualToString:BLANK_STRING]) {
                    
                }
            }
            if (indexPath.row == 8) {
                if (![[_data valueForKey:JSONTAG_CONTACT_NO] isEqualToString:BLANK_STRING]) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", [_data valueForKey:JSONTAG_CONTACT_NO]]]];
                }
            }
            if (indexPath.row == 17) {
                if (![[_data valueForKey:JSONTAG_FB_URL] isEqualToString:BLANK_STRING]) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[_data valueForKey:JSONTAG_FB_URL]]]; 
                }
            }
            if (indexPath.row == 18) {
                if (![[_data valueForKey:JSONTAG_TWITTER_URL] isEqualToString:BLANK_STRING]) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[_data valueForKey:JSONTAG_TWITTER_URL]]]; 
                }
            }
        }
        
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                if (![[_data valueForKey:JSONTAG_PARENT_PHONE] isEqualToString:BLANK_STRING]) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", [_data valueForKey:JSONTAG_PARENT_PHONE]]]];
                }
            }
            if (indexPath.row == 1) {
                if (![[_data valueForKey:JSONTAG_PARENT_EMAIL] isEqualToString:BLANK_STRING]) {
                    [self sendEmail:[_data valueForKey:JSONTAG_PARENT_EMAIL]];
                }                
            }
        }
        
        if (indexPath.section == 2) {
            if (indexPath.row == 0) {
                if (![[_data valueForKey:JSONTAG_COACH_PHONE] isEqualToString:BLANK_STRING]) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", [_data valueForKey:JSONTAG_COACH_PHONE]]]];
                }
            }
            if (indexPath.row == 1) {
                if (![[_data valueForKey:JSONTAG_COACH_EMAIL] isEqualToString:BLANK_STRING]) {
                    [self sendEmail:[_data valueForKey:JSONTAG_COACH_EMAIL]];
                }                
            }
        }
    }
}

- (void)loadData {
    if (_data) {
        [_data release], _data = nil;
        [self.tableView reloadData];
    }
    [cosmoFeaturesnetworkP release];
	cosmoFeaturesnetworkP = [[CosmoNetwork alloc]init];
	cosmoFeaturesnetworkP.writeToFileB=NO;
    cosmoFeaturesnetworkP.callType = @"ACCOUNT";
    cosmoFeaturesnetworkP.xmlDataB=NO;
    NSString *URL;
    if (_isAccountsPage) {
        URL = [NSString stringWithFormat:[URL_BASE stringByAppendingString:URL_PROFILE], [[NSUserDefaults standardUserDefaults] valueForKey:NS_USER_ID], @"read"];
    }
    else {
        URL = [NSString stringWithFormat:[URL_BASE stringByAppendingString:URL_PROFILE], _buddyID, @"read"];
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
        //NSLog(@"success");
        SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
        NSError *error;
        NSString *jsonString = [[[NSString alloc]initWithData:[cosmoFeaturesnetworkP dataP] encoding:NSUTF8StringEncoding] autorelease];
        if (![cosmoFeaturesnetworkP.callType isEqualToString:@"ACCOUNT"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kReloadFavourites object:self userInfo:nil];
            NSDictionary *dict = [jsonParser objectWithString:jsonString error:&error];
            UIAlertView *alert;
            NSString *msgStr;
            switch ([[dict valueForKey:@"success"] intValue]) {
                case 0: { // add request sent
                    msgStr = @"Request Sent";
                    break;
                }
                case 1: { // add request sent
                    msgStr = @"Request Sent";
                    break;
                }
                case 2: { // request accepted.
                    [self.tableView reloadData];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    return;
                }
                case 3: { // unfollow
                    msgStr = [NSString stringWithFormat:@"You are no longer in %@'s favourite list. ", [_data valueForKey:JSONTAG_FIRSTNAME]];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    break;
                }
                case 4: {
                    msgStr = @"Removed from favourite list.";
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    break;
                }
            }
            
            alert = [[[UIAlertView alloc] initWithTitle:@"Success" message:msgStr delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] autorelease];
            [alert show];
        }
        else {
            _data = [[jsonParser objectWithString:jsonString error:&error] retain];
            if (!_isAccountsPage || _addToFavorite) {
                NSString *title = [NSString stringWithFormat:@"%@ %@", [_data valueForKey:JSONTAG_FIRSTNAME ], [_data valueForKey: JSONTAG_LASTNAME]];  
                self.navigationItem.title = title;
            }
            _userInfoTextView.text = [NSString stringWithFormat:@"%@ %@\n%@\n%@", [_data valueForKey:JSONTAG_FIRSTNAME ], [_data valueForKey: JSONTAG_LASTNAME], [_data valueForKey:JSONTAG_USERTYPE], [_data valueForKey:JSONTAG_EMAIL]];
            int i;
            for (i = 0; i < 21; i++) {
                _dataTextFields[i].text = [_data valueForKey:titleTags[i]];
            }
            _kwsSport[0] = [[_data valueForKey:JSONTAG_SPORTS1] intValue];
            _kwsSport[1] = [[_data valueForKey:JSONTAG_SPORTS2] intValue];
            _kwsSport[2] = [[_data valueForKey:JSONTAG_SPORTS3] intValue];
            
            _kwsPos[0] = [[_data valueForKey:JSONTAG_POSITION1] intValue];
            _kwsPos[1] = [[_data valueForKey:JSONTAG_POSITION2] intValue];
            _kwsPos[2] = [[_data valueForKey:JSONTAG_POSITION3] intValue];
            
            [self.tableView reloadData];
        }
        [jsonParser release];
	}
    if (![[_data valueForKey:JSONTAG_PROFILE_PHOTO] isEqualToString:BLANK_STRING]) {
        [self performSelectorInBackground:@selector(doTaskInBackGround) withObject:nil];
    }
}

-(int)downLoadNotification:(id)objectP index:(int)index url:(NSString*)urlP {
	DownLoadPages *downloadP;
	downloadP = (DownLoadPages*)objectP;
	if(downloadP.error==0) {	
        _profileImageView.image = [UIImage imageWithContentsOfFile:urlP];
		//downloadP.fileUrlP=urlP;
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
    /* Add the operation to the queue */
    downLoadP = [[DownLoadPages alloc]init];
    downLoadP.downloadDelegateP=nil;
    downLoadP.textContentUrlP=nil;
    downLoadP.imageContentUrlP=[NSString stringWithFormat:@"http://www.mvpscouts.com/%@", [_data valueForKey:JSONTAG_PROFILE_PHOTO]];
    downLoadP.fileUrlP=nil;
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
        _profileImageView.image = [UIImage imageWithContentsOfFile:downLoadP.fileUrlP];
    }			
	
	[self performSelectorOnMainThread:@selector(updateView)withObject:nil waitUntilDone:NO];
	[pool release];
}

-(void)updateView {
	[self.tableView reloadData];
}

#pragma mark custom methods
- (void)composeMessage {
    ComposeMessageViewController *composeMessageVC = [[[ComposeMessageViewController alloc] init] autorelease];
    composeMessageVC.receiverID = _buddyID;
    UINavigationController *nav = [[[UINavigationController alloc] initWithRootViewController:composeMessageVC] autorelease];
    nav.navigationBar.tintColor = NAVIGATION_BAR_COLOR;
    [self presentModalViewController:nav animated:YES];
}

- (void)saveData {
    [cosmoFeaturesnetworkP release];
	cosmoFeaturesnetworkP = [[CosmoNetwork alloc]init];
	cosmoFeaturesnetworkP.writeToFileB=NO;
    cosmoFeaturesnetworkP.callType = @"ACCOUNT";
    cosmoFeaturesnetworkP.xmlDataB=NO;
    
    NSString *URL = [NSString stringWithFormat:[URL_BASE stringByAppendingString:URL_PROFILE], [[NSUserDefaults standardUserDefaults] valueForKey:NS_USER_ID], @"save"]; //, _sportIDs[0], _positionIDs[0], _sportIDs[1], _positionIDs[1], _sportIDs[2], _positionIDs[2]];
    int i;
    for (i=0; i < 21; i++) {
        URL = [URL stringByAppendingFormat:@"&%@=%@", titleTags[i], _dataTextFields[i].text]; 
    }
    int k=0;
    for (int j=0; j < 6; j+=2) {    
        URL = [URL stringByAppendingFormat:@"&%@=%d&%@=%d", titleTags[j+i], _kwsSport[k], titleTags[j+i+1], _kwsPos[k]];
        k++;
    }
    [cosmoFeaturesnetworkP loadSection:self url:URL];
    NSLog(@"URL :: %@", URL);
    
    [SHKActivityIndicator currentIndicator].frame = CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - 12.5, 
                                                               [[UIScreen mainScreen] bounds].size.height/2 - 12.5, 25, 25);
    [[SHKActivityIndicator currentIndicator] displayActivity:@""];
}

- (void)editBtnClicked {
    if ([_editButton.title isEqualToString:@"Edit"]) {
        _editButton.title = @"Save";
    }
    else {
        [self saveData];
        _editButton.title = @"Edit";
    }
    [self.tableView reloadData];
}

- (void)popToRootView {
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (void)clearPage {
    [_data release], _data = nil;
    _userInfoTextView.text = @"";
    _profileImageView.image = [UIImage imageNamed:IMG_DEFAULT_AVATAR];
    [self.tableView reloadData];
}

- (void)logoutBtnClicked {
    [self clearPage];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:NS_USER_ID];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:NS_IS_USER_LOGGED_IN];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:kLogoutNotification object:self userInfo:nil];
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:kReloadData object:nil];
}

- (void)sendRequest:(NSString*)requestType :(NSString*)type{
    if ([requestType isEqualToString:@"accept"]) {
        _parentType = FAVOURITE_ADDED;
    }
    [cosmoFeaturesnetworkP release];
    cosmoFeaturesnetworkP = [[CosmoNetwork alloc]init];
    cosmoFeaturesnetworkP.writeToFileB=YES;
    cosmoFeaturesnetworkP.callType = type;
    cosmoFeaturesnetworkP.xmlDataB=NO;
    NSString *URL = [NSString stringWithFormat:[URL_BASE stringByAppendingString:URL_FAVOURITE_OPERATION], [[NSUserDefaults standardUserDefaults] valueForKey:NS_USER_ID], _buddyID, requestType];
    [cosmoFeaturesnetworkP loadSection:self url:URL];
    NSLog(@"URL :: %@", URL);
    [SHKActivityIndicator currentIndicator].frame = CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - 12.5, 
                                                               [[UIScreen mainScreen] bounds].size.height/2 - 12.5, 25, 25);
    [[SHKActivityIndicator currentIndicator] displayActivity:@""];    
}

- (void)rejectRequest {
    [self sendRequest:@"reject" :REJECT_FAVOURITE];
}

- (void)acceptRequest {
    [self sendRequest:@"accept" :ACCEPT_FAVOURITE];
}

- (void)removeFromFollowing {
    [self sendRequest:@"unfollow" :REMOVE_FROM_FAVOURITE];
}

- (void)removeFromFavourites {
    [self sendRequest:@"remove" :REJECT_FAVOURITE];
}

- (void)addToFavoriteBtnClicked {
//    UIActionSheet *actionSheet = [[[UIActionSheet alloc] initWithTitle:@"Add to Favorite" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"YES", @"NO", nil] autorelease];
//    [actionSheet showInView:[[self tabBarController] tabBar]];
    [cosmoFeaturesnetworkP release];
    cosmoFeaturesnetworkP = [[CosmoNetwork alloc]init];
    cosmoFeaturesnetworkP.writeToFileB=YES;
    cosmoFeaturesnetworkP.callType = ADD_TO_FAVORITE;
    cosmoFeaturesnetworkP.xmlDataB=NO;
    NSString *URL = [NSString stringWithFormat:[URL_BASE stringByAppendingString:URL_ADD_TO_FAVORITE], [[NSUserDefaults standardUserDefaults] valueForKey:NS_USER_ID], _buddyID];
    [cosmoFeaturesnetworkP loadSection:self url:URL];
    NSLog(@"URL :: %@", URL);
    [SHKActivityIndicator currentIndicator].frame = CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - 12.5, 
                                                               [[UIScreen mainScreen] bounds].size.height/2 - 12.5, 25, 25);
    [[SHKActivityIndicator currentIndicator] displayActivity:@""];
}

- (void)sendEmail:(NSString*)recipientEmailID {
    MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
    controller.mailComposeDelegate = self;
    [controller setToRecipients:[NSArray arrayWithObject:recipientEmailID]];
    if (controller) [self presentModalViewController:controller animated:YES];
    [controller release];    
}

#pragma mark actionsheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [cosmoFeaturesnetworkP release];
        cosmoFeaturesnetworkP = [[CosmoNetwork alloc]init];
        cosmoFeaturesnetworkP.writeToFileB=YES;
        cosmoFeaturesnetworkP.callType = @"ADD_TO_FAVORITE";
        cosmoFeaturesnetworkP.xmlDataB=NO;
        NSString *URL = [NSString stringWithFormat:[URL_BASE stringByAppendingString:URL_ADD_TO_FAVORITE], [[NSUserDefaults standardUserDefaults] valueForKey:NS_USER_ID], _buddyID];
        [cosmoFeaturesnetworkP loadSection:self url:URL];
        NSLog(@"URL :: %@", URL);
        [SHKActivityIndicator currentIndicator].frame = CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - 12.5, 
                                                                   [[UIScreen mainScreen] bounds].size.height/2 - 12.5, 25, 25);
        [[SHKActivityIndicator currentIndicator] displayActivity:@""];
    }
}

#pragma mark - email delegate
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    if (result == MFMailComposeResultSent) {
        NSLog(@"It's away!");
    }
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - pickerView
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    int index = 0;
    if (pickerView == _secondPickerView) {
        index = 1;
    }
    else if (pickerView == _thirdPickerView) {
        index = 2;
    }
    if (component == 0) {
        NSMutableDictionary *dict = [_sportsArray objectAtIndex:row];
        return [dict valueForKey:@"title"];
    }
    else {
//        NSDictionary *dict = [_sportsArray objectAtIndex:_sportIDs[index]];
//        NSMutableArray *arr = [_positionsArray valueForKey:[dict valueForKey:@"title"]];
        NSMutableArray *arr = [_positionsArray objectAtIndex:_sportIDs[index]];
        NSDictionary *temp = [arr objectAtIndex:row];
        return [temp valueForKey:@"title"];
    }
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component {
    // Handle the selection
    NSDictionary *sportsDict;
    NSDictionary *positionDict;
    int index = 0;
    if (pickerView == _secondPickerView) {
        index = 1;
    }
    else if (pickerView == _thirdPickerView) {
        index = 2;
    }
     
    if (component == 0) {
        sportsDict = [_sportsArray objectAtIndex:row];
        _kwsSport[index] = [[sportsDict valueForKey:@"id"] intValue];
        _sportIDs[index] = row;
        _positionIDs[index] = 0;
        [_firstPickerView reloadComponent:1];
        _dataTextFields[index + kPlayerProfileCount + kPlayerParentInfoCount + kPlayerCoachInfoCount].text = [self getSportPositionString:[[sportsDict valueForKey:@"id"] intValue] :-1 :index];
        if (index == 0) {
            [_firstPickerView reloadComponent:1];
        }
        else if (index == 1) {
            [_secondPickerView reloadComponent:1];
        }
        else if (index == 2) {
            [_thirdPickerView reloadComponent:1];
        }
    }
    if (component == 1) {
        sportsDict = [_sportsArray objectAtIndex:_sportIDs[index]];
        NSMutableArray *arr = [_positionsArray objectAtIndex:_sportIDs[index]];
        positionDict = [arr objectAtIndex:row];
        _positionIDs[index] = row;
        _pos[index] = [[positionDict valueForKey:@"id"] intValue];
        _dataTextFields[index + kPlayerProfileCount + kPlayerParentInfoCount + kPlayerCoachInfoCount].text = [self getSportPositionString:[[sportsDict valueForKey:@"id"] intValue] :[[positionDict valueForKey:@"id"] intValue] :index];
    }
    
    
}

// tell the picker how many rows are available for a given component
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return [_sportsArray count];
    }
    else {
        int index = 0;
        if (pickerView == _secondPickerView) {
            index = 1;
        }
        else if (pickerView == _thirdPickerView) {
            index = 2;
        }
        
//        NSDictionary *dict = [_sportsArray objectAtIndex:_sportIDs[index]];
        NSMutableArray *arr = [_positionsArray objectAtIndex:_sportIDs[index]];
        return [arr count];
    }
}

// tell the picker how many components it will have
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}


// tell the picker the width of each row for a given component
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (component == 0) {
        return 140;
    }
    return 180;
}

@end
