//
//  RatesTVC.m
//  SimpleJsonApi
//
//  Created by x0000ff on 18/05/16.
//  Copyright © 2016 x0000ff. All rights reserved.
//

//##############################################################################
#import "RatesTVC.h"

#import "RatesAPI.h"

//##############################################################################
@interface RatesTVC ()

@property (strong, nonatomic) RatesAPI * ratesAPI;

@end

//##############################################################################
@implementation RatesTVC

//##############################################################################
#pragma mark - Overrides

//##############################################################################
- (void)viewDidLoad {
    [super viewDidLoad];

    self.ratesAPI = [[RatesAPI alloc] init];
}

//##############################################################################
- (void) viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];

    [self.ratesAPI getRates:^(NSArray<Rate *> *rates) {
        NSLog(@"RATES: %@", rates);
    } failure:^(NSError *error) {
        NSLog(@"FAILURE: %@", error);
    }];
}

//##############################################################################
@end
//##############################################################################
