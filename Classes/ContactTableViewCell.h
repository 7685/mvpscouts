//
//  ContactTableViewCell.h
//  munduIM
//
//  Created by Vinay Chavan on 08/10/09.
//  Copyright 2009 Geodesic Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ContactCellView;
@class MIMContact;

@interface ContactTableViewCell : UITableViewCell {
	ContactCellView * _contactCellView;
}

- (void)setContact:(MIMContact*)contact;

@end
