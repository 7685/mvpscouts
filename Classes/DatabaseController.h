//
//  DatabaseController.h
//  WindowBasedApplication
//
//  Created by Shahil Shah on 07/07/12.
//  Copyright (c) 2012 kraftwebsolutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DatabaseController : NSObject

- (NSMutableArray*)selectQuery:(NSString*)query params:(NSDictionary*)paramsDict;
- (NSMutableArray*)selectCountryCityQuery:(NSString*)sql;
@end
