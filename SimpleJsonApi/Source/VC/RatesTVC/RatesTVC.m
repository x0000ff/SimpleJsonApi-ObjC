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
@property (strong, nonatomic) NSArray<Rate *> * rates;

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

    if (self.rates.count == 0) {
        __weak __typeof(self)weakSelf = self;
        [self.ratesAPI getRates:^(NSArray<Rate *> *rates) {
            NSLog(@"RATES: %@", rates);
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            strongSelf.rates = rates;

            dispatch_async(dispatch_get_main_queue(), ^{
                [strongSelf.tableView reloadData];
            });

        } failure:^(NSError *error) {
            NSLog(@"FAILURE: %@", error);
        }];
    }
}

//##############################################################################
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.rates.count;
}

//##############################################################################
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"RateCell" forIndexPath:indexPath];

    Rate * rate = (indexPath.row < self.rates.count) ? self.rates[indexPath.row] : nil;
    cell.textLabel.text = rate.name;
    cell.detailTextLabel.text = rate.rate.description;

    return cell;
}

//##############################################################################
@end
//##############################################################################
