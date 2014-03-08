//
//  db.m
//  TTipster
//
//  Created by Tong Tianqi on 3/8/14.
//  Copyright (c) 2014 tongtianqi. All rights reserved.
//

#import "db.h"

@implementation db

-(NSString *)filePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    return [[paths objectAtIndex:0] stringByAppendingString:@"/Tipster.sqlite"];
}

-(id)init{
    return self;
}

-(NSString *)getTaxRateFromAbb:(NSString *)Abb{
    FMDatabase* db = [FMDatabase databaseWithPath:[self filePath]];
    if (![db open]) {
        NSLog(@"FAIL TO OPEN DB.");
    };
    NSLog(@"DB open for get tax from abb.");
    NSString *taxDetail = @"";
    FMResultSet *rs = [db executeQuery:@"select * from Tipster where abb = ?", Abb];
    if ([rs next]) {
        taxDetail = [rs stringForColumn:@"tax"];
    };
    [self close];
    return taxDetail;
}

-(NSMutableArray *)getAllStates{
    NSMutableArray *stateEntries = [[NSMutableArray alloc]init];
    FMDatabase* db = [FMDatabase databaseWithPath:[self filePath]];
    if (![db open]) {
        NSLog(@"FAIL TO OPEN DB.");
    };
    NSLog(@"DB open for get states.");
    FMResultSet *rs = [db executeQuery:@"select * from Tipster"];
    while ([rs next]) {
        [stateEntries addObject:[rs stringForColumn:@"state"]];
    };
    [self close];
    return stateEntries;
}

-(NSMutableArray *)getAllTax{
    NSMutableArray *taxEntries = [[NSMutableArray alloc]init];
    FMDatabase* db = [FMDatabase databaseWithPath:[self filePath]];
    if (![db open]) {
        NSLog(@"FAIL TO OPEN DB.");
    };
    NSLog(@"DB open for get tax.");
    FMResultSet *rs = [db executeQuery:@"select * from Tipster"];
    while ([rs next]) {
        [taxEntries addObject:[rs stringForColumn:@"tax"]];
    };
    [self close];
    return taxEntries;
}

@end
