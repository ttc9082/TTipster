//
//  db.h
//  TTipster
//
//  Created by Tong Tianqi on 3/8/14.
//  Copyright (c) 2014 tongtianqi. All rights reserved.
//

#import "FMDatabase.h"

@interface db : FMDatabase
-(NSString *)getTaxRateFromAbb:(NSString *)Abb;
-(NSMutableArray *)getAllStates;
-(NSMutableArray *)getAllTax;
@end
