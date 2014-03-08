//
//  MainTableViewController.m
//  TTipster
//
//  Created by Tong Tianqi on 3/3/14.
//  Copyright (c) 2014 tongtianqi. All rights reserved.
//

#import "MainTableViewController.h"
#import "UpdateViewController.h"
#import "TaxTableViewController.h"
#import<CoreLocation/CoreLocation.h>
#import "locationDetector.h"


@interface MainTableViewController ()<CLLocationManagerDelegate>
@property (strong, nonatomic) IBOutlet UILabel *taxRateLabel;

@end



@implementation MainTableViewController{
    
}

-(NSString *)passSelectedTaxValue:(NSString *)taxRate{
    [[self taxDetail]setText:taxRate];
    return taxRate;
}

- (void)passTime:(NSString *)time{
    [[self updateDBDetail]setText:time];
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
    [super viewDidLoad];
    locationDetector *locationControl = [[locationDetector alloc] init];
    //[locationControl setManager:[[CLLocationManager alloc]init]];
    //[locationControl setGeocoder:[[CLGeocoder alloc]init]];
    //[[locationControl manager]setDelegate:self];
    
    [locationControl startUpdateLocation];
    //[[locationControl manager] startUpdatingLocation];
    NSLog(@"!!!!!!!");
    self.taxRateLabel.text = locationControl.location;
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier]isEqualToString:@"updateSegue"]) {
        UpdateViewController *UVC = [segue destinationViewController];
        [UVC setDelegate:self];
    }
    else if([[segue identifier]isEqualToString:@"taxSegue"]) {
            TaxTableViewController *TVC = [segue destinationViewController];
            [TVC setDelegate:self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//#warning Incomplete method implementation.
//    // Return the number of rows in the section.
//    return 2;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"mainCell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    
//    // Configure the cell...
//    
//    return cell;
//}

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
