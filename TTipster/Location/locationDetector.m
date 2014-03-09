//
//  locationDetector.m
//  TTipster
//
//  Created by Vein on 3/7/14.
//  Copyright (c) 2014 tongtianqi. All rights reserved.
//

#import "locationDetector.h"
#import<CoreLocation/CoreLocation.h>

@interface locationDetector () <CLLocationManagerDelegate>
@end
@implementation locationDetector
@synthesize manager;
@synthesize geocoder;
@synthesize location;
@synthesize placemark;

-(id)init{
    manager = [[CLLocationManager alloc]init];
    geocoder = [[CLGeocoder alloc] init];
    manager.delegate = self;
    return self;
}
-(NSString *)getCurrentLocation{
    [self startUpdateLocation];
    return self.location;
}

-(void)startUpdateLocation{
    manager.desiredAccuracy = kCLLocationAccuracyBest;
    [manager startUpdatingLocation];
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
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error ==nil &&[placemarks count]>0) {
            placemark = [placemarks lastObject];
            
            location = placemark.administrativeArea;
            //pass the value to the dedial property
            NSLog(@"hahaha%@",self.location);

        }else{
            NSLog(@"eroor%@",error.debugDescription);
            
        }
    }];
}

@end
