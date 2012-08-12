//
//  NSStringAdditions.m
//  munduIM
//
//  Created by Vinay Chavan on 06/12/09.
//  Copyright 2009 Geodesic. All rights reserved.
//

#import "NSStringAdditions.h"

static NSMutableDictionary *smileyDictionary;

//static NSArray *smileyKeys = nil;
//static NSArray *smileyValues = nil;

@implementation NSString (Emoticons)
+ (NSString*)replaceEmoticonsInString:(NSString*)textToConvert {
	if (textToConvert == nil) return [NSString stringWithString:@""];
	if ( !smileyDictionary ) {
		smileyDictionary = [[NSMutableDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Emoticons" ofType:@"strings"]] retain];

		[smileyDictionary setObject:@"\uE022" forKey:@"<3"];
		[smileyDictionary setObject:@"\uE023" forKey:@"</3"];
		[smileyDictionary setObject:@"\uE51a" forKey:@":o)"];
		[smileyDictionary setObject:@"\uE152" forKey:@"B-)"];
		[smileyDictionary setObject:@"\uE003" forKey:@":-*"];
		[smileyDictionary setObject:@"\uE04e" forKey:@":!)"];
		[smileyDictionary setObject:@"\uE32f" forKey:@"(*)"];
		[smileyDictionary setObject:@"\uE04a" forKey:@"[sun]"];
		[smileyDictionary setObject:@"\uE421" forKey:@"(N)"];
		[smileyDictionary setObject:@"\uE00e" forKey:@"(Y)"];
	}
	NSString *resultText = [NSString stringWithString:textToConvert];
	NSEnumerator *enumeration = [smileyDictionary keyEnumerator];
	
	id key;
	while ((key = [enumeration nextObject])) {
		resultText = [resultText stringByReplacingOccurrencesOfString:key 
														   withString:[smileyDictionary valueForKey:key]];
	} 
	return resultText;
}
@end




@implementation NSString (XML)
+ (NSString*)decodeXMLString:(NSString*)textToConvert {
	if (textToConvert == nil) {
		return [NSString stringWithString:@""];
	}
	
	NSString *resultText = [NSString stringWithString:textToConvert];
	resultText = [resultText stringByReplacingOccurrencesOfString:@"&#39;" withString:@"'"];
	resultText = [resultText stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
	resultText = [resultText stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
	resultText = [resultText stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
	resultText = [resultText stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
	resultText = [resultText stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
	resultText = [resultText stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
	return resultText;
}

+ (NSString*)encodeXMLString:(NSString*)textToConvert {
	NSString *resultText = [NSString stringWithString:textToConvert];
	resultText = [resultText stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"];
	resultText = [resultText stringByReplacingOccurrencesOfString:@"<" withString:@"&lt;"];
	resultText = [resultText stringByReplacingOccurrencesOfString:@">" withString:@"&gt;"];
	resultText = [resultText stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"];
	resultText = [resultText stringByReplacingOccurrencesOfString:@"'" withString:@"&apos;"];
	return resultText;
}
@end



@implementation NSString (contains)

- (BOOL)contains:(NSString *)inputString {
	NSRange range = [self rangeOfString:inputString];
	if(range.location == NSNotFound)
		return NO;
	else
		return YES;
}

@end
