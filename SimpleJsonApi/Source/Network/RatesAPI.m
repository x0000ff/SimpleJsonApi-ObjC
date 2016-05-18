//
//  RatesAPI.m
//  SimpleJsonApi
//
//  Created by x0000ff on 18/05/16.
//  Copyright © 2016 x0000ff. All rights reserved.
//

//##############################################################################
#import "RatesAPI.h"

#import <AFNetworking/AFNetworking.h>

#import "NSString+EscapeURL.h"
#import "RateBuilder.h"

//##############################################################################
@interface RatesAPI()

@property (strong, nonatomic) AFHTTPSessionManager * manager;

@end

//##############################################################################
@implementation RatesAPI

//##############################################################################
- (instancetype) init {

    if (self = [super init]) {

        _manager = [self.class createManager];

    }

    return self;
}

//##############################################################################
+ (AFHTTPSessionManager *) createManager {

    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];

    manager.requestSerializer  = [AFJSONRequestSerializer  serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    return manager;
}

//##############################################################################
- (void) getRates:(GetRatesSuccessCallback)success failure:(FailureCallback)failure {

    NSString * paramsString = [@"q=select * from yahoo.finance.xchange where pair in (\"USDRUB,EURRUB,CLPRUB\")&format=json&env=store://datatables.org/alltableswithkeys" escapeForURL];

    NSString * url  = [NSString stringWithFormat:@"http://query.yahooapis.com/v1/public/yql?%@", paramsString];

    AFHTTPSessionManager *manager = self.manager;
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            NSArray<Rate *> * rates = [[[RateBuilder alloc] init] parseRateFromJSON:responseObject];
            success(rates);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//##############################################################################
@end
//##############################################################################
