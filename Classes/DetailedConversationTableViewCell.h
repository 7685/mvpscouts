//
//  DetailedConversationTableViewCell.h
//  WindowBasedApplication
//
//  Created by Shahil Shah on 20/06/12.
//  Copyright (c) 2012 kraftwebsolutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailedConversationTableViewCell : UITableViewCell {
    UILabel *subtitleLabel, *titleLabel;
}

- (void)setData:(NSString*)name message:(NSString*)message;
- (void)setChatColor:(UIColor*)color;
@end
