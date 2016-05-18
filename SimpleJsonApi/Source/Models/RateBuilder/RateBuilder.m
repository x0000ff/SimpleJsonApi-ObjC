//
//  RateBuilder.m
//  SimpleJsonApi
//
//  Created by x0000ff on 18/05/16.
//  Copyright © 2016 x0000ff. All rights reserved.
//

//##############################################################################
#import "RateBuilder.h"

//##############################################################################
@implementation RateBuilder

//##############################################################################
- (NSArray<Rate *> *) parseRateFromJSONResponse:(NSString *)jsonResponse {

    if (!jsonResponse) {
        return nil;
    }

    NSData * jsonData = [jsonResponse dataUsingEncoding:NSUTF8StringEncoding];
    if (!jsonData) {
        return nil;
    }

    NSDictionary * jsonDictionary = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                    options:0
                                                                      error:nil];
    
    NSArray * jsonRates = [jsonDictionary valueForKeyPath:@"query.results.rate"];
    if (![jsonRates isKindOfClass:NSArray.class]) {
        return nil;
    }

    NSMutableArray * rates = [NSMutableArray array];
    for (NSDictionary * rateJSON in jsonRates) {
        Rate * rate = [[Rate alloc] initWithDictionary:rateJSON];

        if (rate) {
            [rates addObject:rate];
        }
    }

    return rates;
}

//##############################################################################
@end
//##############################################################################
