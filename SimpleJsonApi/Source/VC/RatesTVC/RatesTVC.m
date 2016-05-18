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

#import <MBProgressHUD/MBProgressHUD.h>

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

    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak __typeof(hud)weakHUD = hud;

    [self.ratesAPI getRates:^(NSArray<Rate *> *rates) {

        __strong __typeof(weakSelf)strongSelf = weakSelf;
        strongSelf.rates = rates;

        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:strongSelf.view animated:YES];
            [strongSelf.tableView reloadData];
        });

    } failure:^(NSError *error) {

        dispatch_async(dispatch_get_main_queue(), ^{

            weakHUD.mode = MBProgressHUDModeText;

            weakHUD.labelText = @"Error";
            weakHUD.detailsLabelText = error.localizedDescription;
            [weakHUD hide:YES afterDelay:2];

            [weakSelf.tableView reloadData];
        });

    }];
}

//##############################################################################
#pragma mark - Actions

//##############################################################################
- (IBAction) loadRates:(id)sender {

    __weak __typeof(self)weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.refreshControl endRefreshing];
    });

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf loadRates];
    });
}

//##############################################################################
#pragma mark - UITableViewDataSource

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
