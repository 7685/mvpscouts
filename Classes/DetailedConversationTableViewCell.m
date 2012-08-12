//
//  DetailedConversationTableViewCell.m
//  WindowBasedApplication
//
//  Created by Shahil Shah on 20/06/12.
//  Copyright (c) 2012 kraftwebsolutions. All rights reserved.
//

#import "DetailedConversationTableViewCell.h"
#import "UIConstants.h"

@implementation DetailedConversationTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
// 		self.backgroundColor = [UIColor redColor];
//		self.opaque = YES;
		self.clearsContextBeforeDrawing = NO;
		self.clipsToBounds = YES;
		
		subtitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		subtitleLabel.adjustsFontSizeToFitWidth = YES;
		subtitleLabel.font = [UIFont systemFontOfSize:18];
		subtitleLabel.minimumFontSize = 18;
        subtitleLabel.numberOfLines = 10;
		subtitleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		subtitleLabel.backgroundColor = [UIColor clearColor];
		subtitleLabel.textColor = [UIColor darkGrayColor];
		subtitleLabel.highlightedTextColor = [UIColor whiteColor];	
		[self addSubview:subtitleLabel];
		
		titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		titleLabel.adjustsFontSizeToFitWidth = YES;
		titleLabel.font = [UIFont boldSystemFontOfSize:10];
		titleLabel.minimumFontSize = 9;
		titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		titleLabel.backgroundColor = [UIColor whiteColor];
		titleLabel.textColor = [UIColor colorWithWhite:0.2 alpha:1];
		titleLabel.highlightedTextColor = [UIColor whiteColor];
//		[self addSubview:titleLabel];
		

    }
    return self;
}

- (void)setData:(NSString*)name message:(NSString*)message {
    [subtitleLabel setText:message];
    CGSize maximumLabelSize = CGSizeMake(300,9999);
    CGSize expectedLabelSize = [message sizeWithFont:subtitleLabel.font 
                                                             constrainedToSize:maximumLabelSize 
                                                                 lineBreakMode:UILineBreakModeWordWrap];
    
    CGRect frame = CGRectMake(5, 0, 300, expectedLabelSize.height + 20);
    subtitleLabel.frame = frame;
    [self setNeedsDisplay];
}

- (void)setChatColor:(UIColor*)color {
    subtitleLabel.textColor = color;
}

- (void)dealloc {
    [subtitleLabel release], subtitleLabel = nil;
    [titleLabel release], titleLabel = nil;
    [super dealloc];
}
@end
