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

    [self addRefreshControl];
}

//##############################################################################
- (void) viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];

    if (self.rates.count == 0) {
        [self loadRates];
    }
}

//##############################################################################
#pragma mark - UI

//##############################################################################
- (void) addRefreshControl {

    UIRefreshControl * refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(loadRates:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
}

//##############################################################################
#pragma mark - Network

//##############################################################################
- (void) loadRates {

    __weak __typeof(self)weakSelf = self;

#warning TODO: Show spinner
    [self.ratesAPI getRates:^(NSArray<Rate *> *rates) {

#warning TODO: Hide spinner
        NSLog(@"RATES: %@", rates);

        __strong __typeof(weakSelf)strongSelf = weakSelf;
        strongSelf.rates = rates;

        dispatch_async(dispatch_get_main_queue(), ^{
            [strongSelf.tableView reloadData];
        });

    } failure:^(NSError *error) {

        NSLog(@"FAILURE: %@", error);

#warning TODO: Hide spinner
#warning TODO: Show Error

    }];
}

//##############################################################################
#pragma mark - Actions

//##############################################################################
- (IBAction) loadRates:(id)sender {

    dispatch_async(dispatch_get_main_queue(), ^{
        [self.refreshControl endRefreshing];
    });

    [self loadRates];
}

//##############################################################################
#pragma mark - UITAbleViewDataSource

//##############################################################################
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.rates.count;
}

//##############################################################################
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"RateCell" forIndexPath:indexPath];

    Rate * rate = (indexPath.row < self.rates.count) ? self.rates[indexPath.row] : nil;
    cell.textLabel.text = rate.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f", rate.rate.floatValue];

    return cell;
}

//##############################################################################
@end
//##############################################################################
