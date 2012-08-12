//
//  NSStringAdditions.h
//  munduIM
//
//  Created by Vinay Chavan on 06/12/09.
//  Copyright 2009 Geodesic. All rights reserved.
//

@interface NSString (Emoticons)
+ (NSString*)replaceEmoticonsInString:(NSString*)textToConvert;
@end

@interface NSString (XML)
+ (NSString*)decodeXMLString:(NSString*)textToConvert;
+ (NSString*)encodeXMLString:(NSString*)textToConvert;
@end

@interface NSString (contains)
- (BOOL)contains:(NSString *)inputString;
@end