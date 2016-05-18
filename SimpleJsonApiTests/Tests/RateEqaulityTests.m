//
//  RateEqaulityTests.m
//  SimpleJsonApi
//
//  Created by x0000ff on 18/05/16.
//  Copyright © 2016 x0000ff. All rights reserved.
//

//##############################################################################
#import <XCTest/XCTest.h>
#import "Rate.h"

//##############################################################################
@interface RateEqaulityTests : XCTestCase

@property (strong, nonatomic) Rate * rateA;
@property (strong, nonatomic) Rate * rateB;

@end

//##############################################################################
@implementation RateEqaulityTests

//##############################################################################
- (void)setUp {
    [super setUp];

    NSDictionary * rateDictionary = @{
                                      @"id": @"USDRUB",
                                      @"Name": @"USD/RUB",
                                      @"Rate": @"65.2520",
                                      @"Date": @"5/18/2016",
                                      @"Time": @"6:39pm",
                                      };

    self.rateA = [[Rate alloc] initWithDictionary:rateDictionary];
    self.rateB = [[Rate alloc] initWithDictionary:rateDictionary];
}

//##############################################################################
- (void)testRatesMustBeEqual {
    XCTAssertTrue([self.rateA isEqual:self.rateB]);
}

//##############################################################################
- (void)testRatesWithDifferentIdsMustNotBeEqual {

    self.rateA.rId = @"AAA";
    self.rateB.rId = @"BBB";
    XCTAssertFalse([self.rateA isEqual:self.rateB]);
}

//##############################################################################
- (void)testRatesWithDifferentNameMustNotBeEqual {

    self.rateA.name = @"AAA";
    self.rateB.name = @"BBB";
    XCTAssertFalse([self.rateA isEqual:self.rateB]);
}

//##############################################################################
- (void)testRatesWithDifferentRatesMustNotBeEqual {

    self.rateA.rate = @(1.1);
    self.rateB.rate = @(1.0);
    XCTAssertFalse([self.rateA isEqual:self.rateB]);
}

//##############################################################################
- (void)testRatesWithDifferentDatesMustNotBeEqual {

    self.rateA.date = [NSDate dateWithTimeIntervalSinceNow:0];
    self.rateA.date = [NSDate dateWithTimeIntervalSinceNow:1214];
    XCTAssertFalse([self.rateA isEqual:self.rateB]);
}

//##############################################################################
@end
//##############################################################################
