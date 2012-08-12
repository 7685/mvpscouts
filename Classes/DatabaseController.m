//
//  DatabaseController.m
//  WindowBasedApplication
//
//  Created by Shahil Shah on 07/07/12.
//  Copyright (c) 2012 kraftwebsolutions. All rights reserved.
//

#import "DatabaseController.h"
#import "constants.h"
#import <sqlite3.h>

@implementation DatabaseController

- (NSMutableArray*)selectQuery:(NSString*)sql params:(NSDictionary*)paramsDict {
    NSMutableArray *dataTuples = [[NSMutableArray alloc] init];
    sqlite3 *database;
    // The database is stored in the application bundle. 
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:DATABASE_FILE_NAME];
    // Open the database. The database was prepared outside the application.
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) {
        sqlite3_stmt *sqlStmt = nil;
        
        if(sqlite3_prepare_v2(database, [sql cStringUsingEncoding:NSASCIIStringEncoding], -1, &sqlStmt, NULL) != SQLITE_OK)
            NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
        
        // Loop through the results and add them to the feeds array
        while(sqlite3_step(sqlStmt) == SQLITE_ROW) {
            // Read the data from the result row
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            NSString *sportsID = [NSString stringWithFormat:@"%d", (int)sqlite3_column_int(sqlStmt, 0)];
            NSString *title = [NSString stringWithUTF8String:(char *)sqlite3_column_text(sqlStmt, 1)];
            [dict setValue:title forKey:@"title"];
            [dict setValue:sportsID forKey:@"id"];
            [dataTuples addObject:dict];
            [dict release];
        }
        // Release the compiled statement from memory
        sqlite3_finalize(sqlStmt);
        sqlite3_close(database);
    }
    return [dataTuples autorelease];
}

- (NSMutableArray*)selectCountryCityQuery:(NSString*)sql {
    NSMutableArray *dataTuples = [[NSMutableArray alloc] init];
    sqlite3 *database;
    // The database is stored in the application bundle. 
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:DATABASE_FILE_NAME];
    // Open the database. The database was prepared outside the application.
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK) {
        sqlite3_stmt *sqlStmt = nil;
        
        if(sqlite3_prepare_v2(database, [sql cStringUsingEncoding:NSASCIIStringEncoding], -1, &sqlStmt, NULL) != SQLITE_OK)
            NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
        
        // Loop through the results and add them to the feeds array
        while(sqlite3_step(sqlStmt) == SQLITE_ROW) {
            // Read the data from the result row
            [dataTuples addObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(sqlStmt, 0)]];
        }
        // Release the compiled statement from memory
        sqlite3_finalize(sqlStmt);
        sqlite3_close(database);
    }
    return [dataTuples autorelease];
}
@end
