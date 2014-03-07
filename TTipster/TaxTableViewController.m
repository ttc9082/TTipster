//
//  TaxTableViewController.m
//  TTipster
//
//  Created by Tong Tianqi on 3/2/14.
//  Copyright (c) 2014 tongtianqi. All rights reserved.
//

#import "TaxTableViewController.h"

@interface TaxTableViewController ()

@end

@implementation TaxTableViewController

@synthesize stateEntries;
@synthesize taxEntries;


- (void) copyDatabaseIfNeeded {
    
    //Using NSFileManager we can perform many file system operations.
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    
    NSString *dbPath = [self filePath];
    BOOL success = [fileManager fileExistsAtPath:dbPath];
    if(!success) {
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Tipster.sqlite"];
        NSLog(@"%@",defaultDBPath);
        success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
        if (!success)
            NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
}

//returns the URL of database
-(NSString *)filePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    return [[paths objectAtIndex:0] stringByAppendingString:@"/Tipster.sqlite"];
}

//open DB
-(void)openDB{
    if (sqlite3_open([[self filePath] UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"Open DB failed.");
    }
    else{
        NSLog(@"DB opened %@", [self filePath]);}
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    stateEntries = [[NSMutableArray alloc]init];
    taxEntries = [[NSMutableArray alloc]init];
    [super viewDidLoad];
    [self copyDatabaseIfNeeded];
    [self openDB];
    NSString* query = [NSString stringWithFormat:@"SELECT * FROM Tipster"];
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(db, [query UTF8String], -1, &statement, nil) == SQLITE_OK) {
        
        while (sqlite3_step(statement)==SQLITE_ROW) {
            char *field1 = (char *) sqlite3_column_text(statement, 0);
            NSString *field1str = [[NSString alloc]initWithUTF8String:field1];
            char *field2 = (char *) sqlite3_column_text(statement, 1);
            NSString *field2str = [[NSString alloc]initWithUTF8String:field2];
            NSString *rate = [NSString stringWithFormat:@"%@%%", field2str];
            [stateEntries addObject:field1str];
            [taxEntries addObject:rate];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [stateEntries count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = [self.stateEntries objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [self.taxEntries objectAtIndex:indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate passSelectedTaxValue:[NSString stringWithFormat:@"%@(%@)",[self.stateEntries objectAtIndex:indexPath.row],[self.taxEntries objectAtIndex:indexPath.row]]];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
