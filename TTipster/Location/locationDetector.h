//
//  locationDetector.h
//  TTipster
//
//  Created by Vein on 3/7/14.
//  Copyright (c) 2014 tongtianqi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import<CoreLocation/CoreLocation.h>


@interface locationDetector : UIViewController<CLLocationManagerDelegate>

@property NSString *location;
@property CLLocationManager *manager;
@property CLGeocoder *geocoder;
@property CLPlacemark *placemark;

-(void)startUpdateLocation;




@end
