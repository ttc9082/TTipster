//
//  myViewController.h
//  Tipster_location_time
//
//  Created by Vein on 3/3/14.
//  Copyright (c) 2014 Vein. All rights reserved.
//

#import <UIKit/UIKit.h>


//prototype for value pass
@protocol myDelegate <NSObject>


-(void)changeLocation:(NSString *)value;
-(void)changeTime:(NSString *)value;


@end


@interface locationViewController : UIViewController

@property (nonatomic,unsafe_unretained)id<myDelegate> delegate;

@property (weak, nonatomic) NSString *location;
@property (weak, nonatomic) NSString *time;


- (IBAction)locationButtonPressed:(id)sender;
- (IBAction)timeButtonPressed:(id)sender;


@end
