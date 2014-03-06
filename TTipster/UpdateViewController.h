//
//  UpdateViewController.h
//  TTipster
//
//  Created by Tong Tianqi on 3/3/14.
//  Copyright (c) 2014 tongtianqi. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol passUpdateTimeProtocol
- (void) passTime:(NSString *)time;
@end

@interface UpdateViewController : UIViewController
@property (nonatomic, unsafe_unretained) id<passUpdateTimeProtocol> delegate;
@end
