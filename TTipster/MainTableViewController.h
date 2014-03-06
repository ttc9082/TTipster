//
//  MainTableViewController.h
//  TTipster
//
//  Created by Tong Tianqi on 3/3/14.
//  Copyright (c) 2014 tongtianqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UpdateViewController.h"
#import "TaxTableViewController.h"

@interface MainTableViewController : UITableViewController <passUpdateTimeProtocol, taxReturnProtocol>
@property (strong, nonatomic) IBOutlet UILabel *taxDetail;
@property (strong, nonatomic) IBOutlet UILabel *updateDBDetail;
@end
