//
//  ContactTableViewCell.m
//  munduIM
//
//  Created by Vinay Chavan on 08/10/09.
//  Copyright 2009 Geodesic Ltd. All rights reserved.
//

#import "ContactTableViewCell.h"

#import "ContactCellView.h"

@implementation ContactTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
		_contactCellView = [[ContactCellView alloc] initWithFrame:self.contentView.bounds];
		_contactCellView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
		[self.contentView addSubview:_contactCellView];
		self.opaque = YES;
		self.clearsContextBeforeDrawing = NO;
		self.clipsToBounds = YES;
    }
    return self;
}


- (void)dealloc {
	[_contactCellView release], _contactCellView = nil;
    [super dealloc];
}





- (void) setContact:(MIMContact*)contact {
	[_contactCellView setContact:contact];
}

@end
