//
//  TaxTableViewController.h
//  TTipster
//
//  Created by Tong Tianqi on 3/2/14.
//  Copyright (c) 2014 tongtianqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@protocol taxReturnProtocol
- (NSString *) passSelectedTaxValue:(NSString *)taxRate;
@end

@interface TaxTableViewController : UITableViewController
{
    sqlite3 *db;
}
@property (nonatomic,unsafe_unretained) id<taxReturnProtocol> delegate;
@property (nonatomic,retain) NSMutableArray * stateEntries;
@property (nonatomic,retain) NSMutableArray * taxEntries;
-(NSString *)filePath;
-(void)openDB;
-(void)copyDatabaseIfNeeded;
@end
