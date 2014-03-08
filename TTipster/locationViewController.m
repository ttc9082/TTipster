//
//  myViewController.m
//  Tipster_location_time
//
//  Created by Vein on 3/3/14.
//  Copyright (c) 2014 Vein. All rights reserved.
//

#import "locationViewController.h"
#import<CoreLocation/CoreLocation.h>


@interface locationViewController () <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

//get the location
- (IBAction)timeButtonPressed:(id)sender;

@end

@implementation locationViewController{
    CLLocationManager *manager;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    manager = [[CLLocationManager alloc]init];
    geocoder = [[CLGeocoder alloc] init];
    manager.delegate = self;
    manager.desiredAccuracy = kCLLocationAccuracyBest;
    [manager startUpdatingLocation];


	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)timeButtonPressed:(id)sender {
    NSDate *today = [NSDate date];
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *components =
    [gregorian components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:today];
    
    NSInteger hour = [components hour];
    
    NSLog(@"%d",hour);
    
//    if (hour>=18) {
//        
//        self.timeLabel.text = @"Dinner time!";
//        _time = @"Dinner time";
//        
//    }else {
//        
//        self.timeLabel.text = @"Lunch time!";
//        _time = @"Lunch time";
//    }
//    
//    [self.delegate changeTime:_time];
//
    
}



#pragma mark Methods

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"Error: %@", error);
    NSLog(@"Failed to get location@:");
    
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Sorry,we cannot get your current location" message:@"Would you like to point out your state for us?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK",nil];
    [alert show];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
   
    
    CLLocation *currentLocation = newLocation;
    
    
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error ==nil &&[placemarks count]>0) {
            placemark = [placemarks lastObject];
//
//            _location = placemark.locality;
//            //pass the value to the dedial label
//            [self.delegate changeLocation:_location];
//            self.cityLabel.text = [NSString stringWithFormat:@"City:%@ ",placemark.locality];
//            self.stateLabel.text = [NSString stringWithFormat:@"State:%@",placemark.administrativeArea];
//            
        }else{
           NSLog(@"%@",error.debugDescription);
        }
    }];
}



@end
