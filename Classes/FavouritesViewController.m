//
//  FavouritesViewController.m
//  MVPScouts
//
//  Created by Shahil Shah on 18/05/12.
//  Copyright (c) 2012 kraftwebsolutions. All rights reserved.
//

#import "FavouritesViewController.h"
#import "SHKActivityIndicator.h"
#import "AccountViewController.h"
#import "MyLauncherItem.h"
#import "SBJsonParser.h"
#import "CustomBadge.h"
#import "constants.h"

@implementation FavouritesViewController


-(void)loadView
{    
    _data = [[NSArray alloc] init];
    buddys = [[NSMutableArray alloc] init];
	[super loadView];
    [self loadData];
    //self.title = @"myLauncher";
    _accountViewController = [[AccountViewController alloc] initWithStyle:UITableViewStyleGrouped];
    _accountViewController.isAccountsPage = YES;
    _accountViewController.addToFavorite = YES;
    [[self appControllers] setObject:[AccountViewController class] forKey:@"AccountViewController"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:kReloadData object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReloadData object:nil];
    [_data release], _data = nil;
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
	//If you don't want to support multiple orientations uncomment the line below
    //return (toInterfaceOrientation == UIInterfaceOrientationPortrait);
	return [super shouldAutorotateToInterfaceOrientation:toInterfaceOrientation];
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload 
{
    [super viewDidUnload];
}

#pragma mark custom methods
- (void)loadData {
//    [self.launcherView clearPagesArray];
//    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"myLauncherView"];
//    [self clearSavedLauncherItems];
    //[self.launcherView setPages:[NSMutableArray arrayWithObjects: nil, nil]];
    
    for (int i = 0; i < [buddys count]; i++) {
        NSLog(@"removed");
//        [self.launcherView didDeleteItem:[buddys objectAtIndex:i]];
    }
    [buddys removeAllObjects];
    [cosmoFeaturesnetworkP release];
	cosmoFeaturesnetworkP = [[CosmoNetwork alloc]init];
	cosmoFeaturesnetworkP.writeToFileB=YES;
    cosmoFeaturesnetworkP.xmlDataB=NO;
    NSString *URL = [NSString stringWithFormat:[URL_BASE stringByAppendingString:URL_FAVOURITES], [[NSUserDefaults standardUserDefaults] valueForKey:NS_USER_ID]];
    [cosmoFeaturesnetworkP loadSection:self url:URL];
    NSLog(@"URL :: %@", URL);
    
    [SHKActivityIndicator currentIndicator].frame = CGRectMake([[UIScreen mainScreen] bounds].size.width/2 - 12.5, 
                                                               [[UIScreen mainScreen] bounds].size.height/2 - 12.5, 25, 25);
    [[SHKActivityIndicator currentIndicator] displayActivity:@""];
}

- (void)showFavourites {
 //   [self.launcherView clearPagesArray];
    //[[self appControllers] setObject:[ItemViewController class] forKey:@"ItemViewController"];
    
    //Add your view controllers here to be picked up by the launcher; remember to import them above
	//[[self appControllers] setObject:[MyCustomViewController class] forKey:@"MyCustomViewController"];
	//[[self appControllers] setObject:[MyOtherCustomViewController class] forKey:@"MyOtherCustomViewController"];
	
	if(![self hasSavedLauncherItems])
	{
        
        for (int i=0; i < [_data count]; i++) {
            NSDictionary *dict = [_data objectAtIndex:i];
            NSString *name = [NSString stringWithFormat:@"%@ %@", [dict valueForKey:@"first_name"], [dict valueForKey:@"last_name"]];
            MyLauncherItem *temp = [[MyLauncherItem alloc] initWithTitle:name
                                                             iPhoneImage:@"default_avatar" 
                                                               iPadImage:@"itemImage-iPad"
                                                                  target:@"AccountViewController" 
                                                             targetTitle:[dict valueForKey:@"id"] 
                                                               deletable:YES];
            [temp setBadgeText:[dict valueForKey:@"request_status"]];
            [buddys addObject:temp];
            NSLog(@"object added");
            [temp release], temp = nil;
        }
        [self.launcherView setPages:[NSMutableArray arrayWithObjects:buddys, nil]];
        
/*		[self.launcherView setPages:[NSMutableArray arrayWithObjects: 
                                     [NSMutableArray arrayWithObjects: 
                                      [[MyLauncherItem alloc] initWithTitle:@"John"
                                                                iPhoneImage:@"default_avatar" 
                                                                  iPadImage:@"itemImage-iPad"
                                                                     target:nil 
                                                                targetTitle:@"Item 1 View"
                                                                  deletable:NO],
                                      [[MyLauncherItem alloc] initWithTitle:@"Shahil"
                                                                iPhoneImage:@"default_avatar" 
                                                                  iPadImage:@"itemImage-iPad"
                                                                     target:nil 
                                                                targetTitle:@"Item 2 View" 
                                                                  deletable:NO],
                                      [[MyLauncherItem alloc] initWithTitle:@"Mark"
                                                                iPhoneImage:@"default_avatar" 
                                                                  iPadImage:@"itemImage-iPad"
                                                                     target:nil 
                                                                targetTitle:@"Item 3 View"
                                                                  deletable:YES],
                                      [[MyLauncherItem alloc] initWithTitle:@"Kelly"
                                                                iPhoneImage:@"default_avatar" 
                                                                  iPadImage:@"itemImage-iPad"
                                                                     target:nil 
                                                                targetTitle:@"Item 4 View"
                                                                  deletable:NO],
                                      [[MyLauncherItem alloc] initWithTitle:@"Naomi"
                                                                iPhoneImage:@"default_avatar" 
                                                                  iPadImage:@"itemImage-iPad"
                                                                     target:nil 
                                                                targetTitle:@"Item 5 View"
                                                                  deletable:YES],
                                      [[MyLauncherItem alloc] initWithTitle:@"Tom"
                                                                iPhoneImage:@"default_avatar" 
                                                                  iPadImage:@"itemImage-iPad"
                                                                     target:nil 
                                                                targetTitle:@"Item 6 View"
                                                                  deletable:NO],
                                      [[MyLauncherItem alloc] initWithTitle:@"Rebecca"
                                                                iPhoneImage:@"default_avatar" 
                                                                  iPadImage:@"itemImage-iPad"
                                                                     target:nil 
                                                                targetTitle:@"Item 7 View"
                                                                  deletable:NO],
                                      nil], 
                                     [NSMutableArray arrayWithObjects: 
                                      [[MyLauncherItem alloc] initWithTitle:@"Kate"
                                                                iPhoneImage:@"default_avatar" 
                                                                  iPadImage:@"itemImage-iPad"
                                                                     target:nil 
                                                                targetTitle:@"Item 8 View"
                                                                  deletable:NO],
                                      [[MyLauncherItem alloc] initWithTitle:@"Adam"
                                                                iPhoneImage:@"default_avatar" 
                                                                  iPadImage:@"itemImage-iPad"
                                                                     target:nil 
                                                                targetTitle:@"Item 9 View"
                                                                  deletable:YES],
                                      [[MyLauncherItem alloc] initWithTitle:@"William"
                                                                iPhoneImage:@"default_avatar" 
                                                                  iPadImage:@"itemImage-iPad"
                                                                     target:nil 
                                                                targetTitle:@"Item 10 View"
                                                                  deletable:NO],
                                      nil],
                                     nil]];*/
        
        // Set number of immovable items below; only set it when you are setting the pages as the 
        // user may still be able to delete these items and setting this then will cause movable 
        // items to become immovable.
        // [self.launcherView setNumberOfImmovableItems:1];
        
        // Or uncomment the line below to disable editing (moving/deleting) completely!
        // [self.launcherView setEditingAllowed:NO];
	}
    
    // Set badge text for a MyLauncherItem using it's setBadgeText: method
    //[(MyLauncherItem *)[[[self.launcherView pages] objectAtIndex:0] objectAtIndex:0] setBadgeText:@"4"];
    
    // Alternatively, you can import CustomBadge.h as above and setCustomBadge: as below.
    // This will allow you to change colors, set scale, and remove the shine and/or frame.
    //[(MyLauncherItem *)[[[self.launcherView pages] objectAtIndex:0] objectAtIndex:1] setCustomBadge:[CustomBadge customBadgeWithString:@"2" withStringColor:[UIColor blackColor] withInsetColor:[UIColor whiteColor] withBadgeFrame:YES withBadgeFrameColor:[UIColor blackColor] withScale:0.8 withShining:NO]];
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
        [self showFavourites];
	}
}

@end
