//
//  RateBuilderTests.m
//  SimpleJsonApi
//
//  Created by x0000ff on 18/05/16.
//  Copyright © 2016 x0000ff. All rights reserved.
//

//##############################################################################
#import <XCTest/XCTest.h>
#import "XCTestCase+Fixture.h"
#import "RateBuilder.h"

//##############################################################################
@interface RateBuilderTests : XCTestCase

@end

//##############################################################################
@implementation RateBuilderTests

//##############################################################################
- (void)testCreateRatesFromJSONString {

    NSString * jsonStringResponse = [self fixtureWithFileName:@"rate-response" extension:@"json"];

    RateBuilder * rateBuilder = [[RateBuilder alloc] init];
    NSArray * rates = [rateBuilder parseRateFromJSONResponse:jsonStringResponse];

    Rate * rateUsdRub = [[Rate alloc] initWithDictionary:@{
                                                           @"id": @"USDRUB",
                                                           @"Name": @"USD/RUB",
                                                           @"Rate": @"65.2520",
                                                           @"Date": @"5/18/2016",
                                                           @"Time": @"6:39pm",
                                                           }];
    Rate * rateEurRub = [[Rate alloc] initWithDictionary:@{
                                                           @"id": @"EURRUB",
                                                           @"Name": @"EUR/RUB",
                                                           @"Rate": @"73.6401",
                                                           @"Date": @"5/18/2016",
                                                           @"Time": @"6:40pm",
                                                           }];

    Rate * rateClpRub = [[Rate alloc] initWithDictionary:@{
                                                           @"id": @"CLPRUB",
                                                           @"Name": @"CLP/RUB",
                                                           @"Rate": @"0.0946",
                                                           @"Date": @"5/18/2016",
                                                           @"Time": @"6:39pm",
                                                           }];

    NSArray * correctRates = @[rateUsdRub, rateEurRub, rateClpRub];
    XCTAssertTrue([rates isEqualToArray:correctRates]);
}

//##############################################################################
- (void)testCreateRatesFromJSONObject {

    NSString * jsonStringResponse = [self fixtureWithFileName:@"rate-response" extension:@"json"];
    NSData * jsonData = [jsonStringResponse dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary * jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                    options:0
                                                                      error:nil];

    RateBuilder * rateBuilder = [[RateBuilder alloc] init];
    NSArray * rates = [rateBuilder parseRateFromJSON:jsonDictionary];

    Rate * rateUsdRub = [[Rate alloc] initWithDictionary:@{
                                                           @"id": @"USDRUB",
                                                           @"Name": @"USD/RUB",
                                                           @"Rate": @"65.2520",
                                                           @"Date": @"5/18/2016",
                                                           @"Time": @"6:39pm",
                                                           }];
    Rate * rateEurRub = [[Rate alloc] initWithDictionary:@{
                                                           @"id": @"EURRUB",
                                                           @"Name": @"EUR/RUB",
                                                           @"Rate": @"73.6401",
                                                           @"Date": @"5/18/2016",
                                                           @"Time": @"6:40pm",
                                                           }];

    Rate * rateClpRub = [[Rate alloc] initWithDictionary:@{
                                                           @"id": @"CLPRUB",
                                                           @"Name": @"CLP/RUB",
                                                           @"Rate": @"0.0946",
                                                           @"Date": @"5/18/2016",
                                                           @"Time": @"6:39pm",
                                                           }];

    NSArray * correctRates = @[rateUsdRub, rateEurRub, rateClpRub];
    XCTAssertTrue([rates isEqualToArray:correctRates]);
}

//##############################################################################
@end
//##############################################################################
