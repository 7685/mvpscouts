//
//  ConversationTableViewCell.m
//  munduIM
//
//  Created by Shweta Desai on 10/12/09.
//  Copyright 2009 Geodesic Ltd. All rights reserved.
//

#import "ConversationTableViewCell.h"

#import "ConversationCellView.h"

@implementation ConversationTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _conversationCellView = [[ConversationCellView alloc] initWithFrame:self.contentView.bounds];
		_conversationCellView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
		[self.contentView addSubview:_conversationCellView];
		self.opaque = YES;
		self.clearsContextBeforeDrawing = NO;
		self.clipsToBounds = YES;
    }
    return self;
}

- (void)dealloc {
	[_conversationCellView release], _conversationCellView = nil;
    [super dealloc];
}



- (void) setContact:(MIMContact*)contact {
	[_conversationCellView setContact:contact];
}
- (void)setMessage:(NSString*)message {
	[_conversationCellView setMessage:message];
}
@end
