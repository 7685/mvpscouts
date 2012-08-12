//
//  ConversationTableViewCell.h
//  munduIM
//
//  Created by Shweta Desai on 10/12/09.
//  Copyright 2009 Geodesic Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ConversationCellView;
@class MIMContact;

@interface ConversationTableViewCell : UITableViewCell {
	ConversationCellView *_conversationCellView;
}

- (void)setContact:(MIMContact*)contact;
- (void)setMessage:(NSString*)message;
@end
