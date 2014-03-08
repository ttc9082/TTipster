//
//  locationDetector.m
//  TTipster
//
//  Created by Vein on 3/7/14.
//  Copyright (c) 2014 tongtianqi. All rights reserved.
//

#import "locationDetector.h"
#import<CoreLocation/CoreLocation.h>


@implementation locationDetector{
   
}

-(void)startUpdateLocation{
    _manager = [[CLLocationManager alloc]init];
    _geocoder = [[CLGeocoder alloc] init];
    _manager.delegate = self;
    _manager.desiredAccuracy = kCLLocationAccuracyBest;
    [_manager startUpdatingLocation];
    NSLog(@"!!!!!!!11");

}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"Error: %@", error);
    NSLog(@"Failed to get location@:");
    //
    //    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Sorry,we cannot get your current location" message:@"Would you like to point out your state for us?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK",nil];
    //    [alert show];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    NSLog(@"!!!!!!!22");

    
    CLLocation *currentLocation = newLocation;
    
    
    [_geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error ==nil &&[placemarks count]>0) {
            _placemark = [placemarks lastObject];
            
            _location = _placemark.administrativeArea;
            //pass the value to the dedial property
            NSLog(@"!!!!!!!22");

        }else{
            NSLog(@"%@",error.debugDescription);
            
        }
    }];
}

@end
