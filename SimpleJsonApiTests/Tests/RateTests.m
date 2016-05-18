//
//  RateTests.m
//  SimpleJsonApiTests
//
//  Created by x0000ff on 18/05/16.
//  Copyright © 2016 x0000ff. All rights reserved.
//

//##############################################################################
#import <XCTest/XCTest.h>
#import "Rate.h"

//##############################################################################
@interface RateTests : XCTestCase

@end

//##############################################################################
@implementation RateTests

//##############################################################################
- (void)testInitializeRateWithDictionary {

    NSDictionary * rateDictionary = @{
                                      @"id": @"USDRUB",
                                      @"Name": @"USD/RUB",
                                      @"Rate": @"65.2520",
                                      @"Date": @"5/18/2016",
                                      @"Time": @"6:39pm",
                                      };

    Rate * rate = [[Rate alloc] initWithDictionary:rateDictionary];

    XCTAssertNotNil(rate);
    XCTAssertEqual(rate.rId, @"USDRUB");
    XCTAssertEqual(rate.name, @"USD/RUB");
    XCTAssertEqualWithAccuracy(rate.rate.floatValue, @(65.2520).floatValue, 0.0001);

    // 05/18/2016 @ 6:39pm (UTC)
    NSDate * correctDate = [NSDate dateWithTimeIntervalSince1970:1463596740];
    XCTAssertEqual(rate.date, correctDate);
}

//##############################################################################
- (void)testInitializeRateWithDictionaryWithoutDate {

    NSDictionary * rateDictionary = @{
                                      @"Time": @"5:42am",
                                      };

    Rate * rate = [[Rate alloc] initWithDictionary:rateDictionary];

    XCTAssertNotNil(rate);
    XCTAssertNil(rate.date);
}

//##############################################################################
- (void)testInitializeRateWithDictionaryWithoutTime {

    NSDictionary * rateDictionary = @{
                                      @"Date": @"5/18/2016",
                                      };

    Rate * rate = [[Rate alloc] initWithDictionary:rateDictionary];

    XCTAssertNotNil(rate);
    XCTAssertNil(rate.date);
}

//##############################################################################
- (void)testInitializeRateWithDictionaryWithoutDateAndTime {

    NSDictionary * rateDictionary = @{
                                      };

    Rate * rate = [[Rate alloc] initWithDictionary:rateDictionary];

    XCTAssertNotNil(rate);
    XCTAssertNil(rate.date);
}

//##############################################################################
@end
//##############################################################################
