//
//  UpdateViewController.m
//  TTipster
//
//  Created by Tong Tianqi on 3/3/14.
//  Copyright (c) 2014 tongtianqi. All rights reserved.
//

#import "UpdateViewController.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "FMDatabasePool.h"
#import "FMDatabaseQueue.h"


@interface UpdateViewController ()
@property (strong, nonatomic) IBOutlet UILabel *underImageLabel;
@property (strong, nonatomic) IBOutlet UIImageView *TestImage;
@property (strong, nonatomic) IBOutlet UILabel *updateTime;
@property (strong, nonatomic) IBOutlet UILabel *pathLabel;
@end

@implementation UpdateViewController
- (NSString *)fetchUpdateTime{
    NSString *lastUpdateTime = @"";
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, @"Tipster.sqlite"];
    FMDatabase* db = [FMDatabase databaseWithPath:dbPath];
    if (![db open]) {
        NSLog(@"FAIL TO OPEN DB.");
        NSString *error = @"Error";
        return error;
    };
    NSLog(@"DB Opened.");
    FMResultSet *rs = [db executeQuery:@"select * from UD"];
    if ([rs next]) {
        lastUpdateTime = [rs stringForColumn:@"lasttime"];
    };
    [db close];
    return lastUpdateTime;
}

- (void)writeUpdateTime:(NSString *)time{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, @"Tipster.sqlite"];
    FMDatabase* db = [FMDatabase databaseWithPath:dbPath];
    if (![db open]) {
        NSLog(@"DB fail to Open.");
        return;
    };
    BOOL update = [db executeUpdate:@"update UD set lasttime = ? where id = 0", time];
    if(update){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Update Success!" delegate:self cancelButtonTitle:@"OK." otherButtonTitles:nil, nil];
        [alert show];
    }
    [db close];
    return;
}

- (NSString *)filePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, @"test.jpg"];
    return filePath;
}
- (IBAction)update:(id)sender {
    NSString *stringURL = @"https://s3.amazonaws.com/Tipster/social.jpg";
    NSURL  *url = [NSURL URLWithString:stringURL];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    if ( urlData )
    {
        NSString *filePath = [self filePath];
        [urlData writeToFile:filePath atomically:YES];
        NSDate *today = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        // display in 12HR/24HR (i.e. 11:25PM or 23:25) format according to User Settings
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        NSString *currentTime = [dateFormatter stringFromDate:today];
        NSLog(@"User's current time:%@",currentTime);
        self.updateTime.text = currentTime;
        self.TestImage.image = [UIImage imageWithContentsOfFile:self.filePath];
        [self writeUpdateTime:currentTime];
        [[self delegate]passTime:currentTime];
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    if ([self fetchUpdateTime]) {
        self.updateTime.text = [self fetchUpdateTime];
        NSLog(@"Got data successfully!");
    };
    NSString *filePath = [self filePath];
    [super viewDidLoad];
    self.TestImage.image = [UIImage imageWithContentsOfFile:filePath];
    if (self.TestImage.image) {
        self.underImageLabel.text = @"Congratulations!";
        self.pathLabel.text = [filePath stringByAppendingString:@"  Stored!"];
    }else
        self.underImageLabel.text = @"";
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
